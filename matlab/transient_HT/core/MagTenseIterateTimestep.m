
%By Kaspar K. Nielsen, kasparkn@gmail.com
%Latest update 20200502
%This function progresses the temporal solution of the coupled heat
%transfer and magnetic field problem iteratively, which means that it both
%solves for the temperature and magnetic field (T and H) at the new
%timestep (t+dt) but also includes the various properties (conductivity,
%density, specific heat, entropy etc.) as averages over the timestep, i.e.
%as weighted functions of the current (t) and the future (t+dt) timesteps
%The idea is that given dt and t the iteration works like this:
%while err>maxErr && nIte<maxIte
%c = 0.5 * ( c(T(t),H(t)) + c(T(t+dt),H(t+dt) )
%etc
%then set up the equations and find T* = T(t+t) and check the relative err
%err = max( abs( ( T(t+dt) - T(t) ) / (T(t)) )

%end
%argument solution is an object of type MagTenseTransietSolution that will
%also contain the resulting temperature field (new solution) and is thus
%modified and returned.
%argument geom is an object of type MagTenseTransientGeometry
%argument setts is an object of type MagTenseTransientSettings
function [solution, outFlag] = MagTenseIterateTimestep( solution, geom, setts, debug )

%iteration settings
maxErr = setts.maxErr;
maxIte = setts.maxIte;
dt = setts.dt;

%the geometrical part of the thermal resistance.
R_geom_inv = geom.R_geom_inv;
R_geom_inv_tr = R_geom_inv';

dV = geom.dV;

%no. of cells or finite volumes
n = length(dV);

%the solution at time t
T_old = solution.T;
H_old = solution.H;
p_old = solution.p;
Happ_old = solution.Happ_old;
M_old = solution.M;
c_old = solution.c;
k_old = solution.k;
rho_old = solution.rho;

%the applied field at the new time, t+dt
Happ_new = solution.Happ_new;

%initialization of parameters
err_T = 10 * maxErr;
err_H = err_T;
nIte = 0;

%the temperature at the new tims, t+dt, is denoted T_new
%the temperature at the current time, t, is denoted T_old
%initially the new temperature is set to the initial temperature
c_new = c_old;
k_new = k_old;
rho_new = rho_old;

%First guess at temperature at the new time step t+dt
T_prev = T_old;
%and first guess of the field at the new time step t+dt
H_prev = H_old;
%and first guess of the magnetization
M_prev = M_old;
%and the pressure
p_prev = p_old;
%while loop that exits after a max. no. of iteration or when the solution
%has converged
while err_T>maxErr && err_H>maxErr && nIte<maxIte
   
    %find resulting thermal properties (average over the timestep)
    %these all have to be single-column vectors (length n)
    c = 0.5 * ( c_old + c_new );
    k = 0.5 * ( k_old + k_new );
    rho = 0.5 * ( rho_old + rho_new );
    
    %thermal resistance matrix (each element R_ij = dl_i/(A_ij * k_i ) for
    %the i'th tile and it's surface area, A_ij, with the j'th cell)
    %setup matrix for inversion (A in A*T = b )
    %first find all thermal resistance terms that apply to all but the
    %diagonal. Note the minus sign as this is the part of the expression
    %multiplied onto the off-diagonal tile
    A = -1.*(R_geom_inv .* repmat( k, 1, n ) + R_geom_inv_tr .* repmat( k, 1, n )');
   
    %find the diagonal terms as minus the sum of the other terms
    A = A - sparse(1:n,1:n, sum(A,2) );
    %find the capacity term
    cap = dV .* rho .* c ./ dt;
    
    %setup result-vector b (right-hand side in A*T = b)
    b = cap .* T_old;
    %add the boundary conditions here
    [lhs_bdry,rhs_bdry] = geom.getBoundaryConditions(  k );
    
    A = A + sparse( 1:n,1:n, cap + lhs_bdry );
    b = b + rhs_bdry;
    
    %solve the equation system using \
    T_new = A \ b;
   
    %find the pressure at t+dt
    %p_new = zeros(size(T_new));
     p_new = p_old;   
    %find the magnetic field at t+dt
    [H_new,M_new] = MagTenseIterateMagneticField( Happ_new, M_prev, T_new, p_new, solution.hyst, geom, setts );
    
    
    %find thermal properties at the new temperature
    c_new = setts.c(T_new,H_new,p_new);
    k_new = setts.k(T_new,H_new,p_new);
    rho_new = setts.rho(T_new,H_new,p_new);
    
    %find the relative error
    err_T = max ( abs ( (T_new - T_prev)./T_prev ) );
    err_H = max ( abs ( sqrt(sum(H_new,2).^2) - sqrt(sum(H_prev.^2,2)) ) ./ sqrt(sum(H_prev.^2,2)) );
    
    
    if debug
        disp( ['err (T, H) = (' num2str(err_T,'%7.5f') ', ' num2str(err_H,'%7.5f') ')'] );
        disp( ['Iteration no. ' num2str(nIte)] );
    end
    
    T_prev = T_new;
    H_prev = H_new;
    M_prev = M_new;
    nIte = nIte + 1;
end

%set output flag
if err_T<=maxErr
    outFlag = 1;
    %update the solution
    solution.T = T_new;
    solution.H = H_new;
    solution.p = p_new;
else
    outFlag = -1;
end

end