include 'mkl_spblas.f90'
    module MicroMagParameters
    use MKL_SPBLAS
    
    !>------------------
    !> Custom types
    !>------------------
    
    type MicroMagGrid
        integer :: nx, ny, nz
        real :: Lx,Ly,Lz
        real :: dx,dy,dz
        real,dimension(:,:,:),allocatable :: x,y,z
        integer :: gridType
    end type MicroMagGrid
    
    !> Stores a table in one variable
    type MicroMagTable1D
        real,dimension(:),allocatable :: x,y        
    end type MicroMagTable1D
    
    
    !>-----------------
    !> Overall data structure for a micro magnetism problem.
    !> The design intention is such that a problem may be restarted given the information stored in this struct
    !>-----------------
    type MicroMagProblem
        !Below is stuff that needs to be provided by the "user":
        type(MicroMagGrid) :: grid                  !> Grid of the problem
        
        real,dimension(:,:),allocatable :: u_ea     !> Easy axis vectors that should have the dimensions (n,3) where n is the no. of grid points and thus u_ea(i,3) is the i'th point's z-component
        
        integer :: ProblemMode                      !> Defines the problem mode (new or continued from previous solution)
        
        integer :: solver                           !> Determines what type of solver to use
        
        real :: A0,Ms,K0,gamma,alpha0,MaxT0         !> User defined coefficients determining part of the problem.
        
        real :: HextX,HextY,HextZ                   !> Applied field along x-, y- and z-direction, single value (constant field)
        
        real,dimension(:),allocatable :: t          !> Time array for the desired output times
        real,dimension(:),allocatable :: m0         !>Initial value of the magnetization
        
        
        !Below is stuff that is computed when the solver initializes
        
        type(sparse_matrix_t) :: A_exch         !> Exchange term matrix
        
        real,dimension(:,:),allocatable :: Kxx,Kxy,Kxz  !> Demag field tensor split out into the nine symmetric components
        real,dimension(:,:),allocatable :: Kyy,Kyz      !> Demag field tensor split out into the nine symmetric components
        real,dimension(:,:),allocatable :: Kzz          !> Demag field tensor split out into the nine symmetric components
        
        real,dimension(:),allocatable :: Axx,Axy,Axz,Ayy,Ayz,Azz    !> Anisotropy vectors assuming local anisotropy only, i.e. no interaction between grains
        
        
    end type MicroMagProblem
    
    !>-----------------
    !> Data structure for a micro magnetism solution.
    !> The design intention is such that a problem may be restarted given the information stored in this struct
    !>-----------------
    type MicroMagSolution
        real,dimension(:),allocatable :: HjX,HjY,HjZ    !> Effective fields for the exchange term (X,Y and Z-directions, respectively)
        real,dimension(:),allocatable :: HhX,HhY,HhZ    !> Effective fields for the external field (X,Y and Z-directions, respectively)
        real,dimension(:),allocatable :: HkX,HkY,HkZ    !> Effective fields for the anisotropy energy term (X,Y and Z-directions, respectively)        
        real,dimension(:),allocatable :: HmX,HmY,HmZ    !> Effective fields for the demag energy term (X,Y and Z-directions, respectively)        
        real,dimension(:),allocatable :: Mx,My,Mz       !> The magnetization components used internally as the solution progresses
                        
        real,dimension(:),allocatable :: t_out          !> Output times at which the solution was computed
        real,dimension(:,:),allocatable :: M_out        !> The magnetization at each of these times
        
        real :: Jfact,Hfact,Mfact,Kfact                 !> Constant factors used for the determination of the effective fields
    end type MicroMagSolution
    
    
    !>------------
    !> Parameters
    !>------------
    
    integer,parameter :: gridTypeUniform=1
    integer,parameter :: ProblemModeNew=1,ProblemModeContinued=2
    integer,parameter :: MicroMagSolverExplicit=1,MicroMagSolverDynamic=2,MicroMagSolverImplicit=3
    
    
end module MicroMagParameters    