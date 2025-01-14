

How to get the CUDA stuff working in Intel Fortran in MagTense on Windows

Intel's Fortran Compiler and the PG Fortran compiler (which is used for doing CUDA directly in Fortran) are not compatible. One simply cannot link object files from the two compilers as there is no standard for this.

The strategy then is to make the CUDA GPU kernel in C++, compile this with the nvcc compiler (that uses MSVC at the core), output to an object file and then compile a C++ wrapper with Intel C++ compiler (icl) that includes and uses the nvcc compiled file. The output here should be an obj file that can be called from Fortran (using the Intel Fortran compiler) via the standard way (iso_c_binding) for calling C++ functions from Fortran.

 The following details the required steps.
 
 -Install VS 2019 with Intel's C++ and Fortran compilers (and MKL as this is used also by MagTense) and with MSVC compiler
 -Install CUDA SDK: https://developer.nvidia.com/cuda-downloads
 
 Step 1. 
 Open a command line environment for CUDA / nvcc using the short cut in the Windows Start Menu (MS Visual Studio x64 native)
 Go to the directory where the CUDA kerne C++ file is located. 
 Compile with the following command 
 
 nvcc -c myCudaKernel.cu
 
 Step 2.
 Open a command line environemtn for Intel Visual Studio. Start Menu -> Intel Parallel Studio -> latest x64 cmd
 Compile the wrapper c++ file while linking to the CUDA kernel AND the CUDA library:
 
 icl myIntelWrapper.cxx myCudaKernel.obj  /link "c:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v10.2\lib\x64\cudart_static.lib"
 
 Note the last part of the line is the full path to the cuart_static.lib file that is essential for CUDA to work. There may be other directories required depending on which features to use from CUDA. These libraries should then be added here.
 
 Now comes the linking to Fortran...
 
 Step 3. Compile a Fortran program calling the Intel C++ wrapper
 ifort MyFortranModule.f90 MyFortranTestProgram.f90 myCudaKernel.obj myIntelWrapper.obj "c:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v10.2\lib\x64\cudart_static.lib"
 
 And this should produce a .exe file that runs....
 
 MAGTENSE EXAMPLE BEGINS HERE
 
 Concrete example (in MagTense):
 
 From the x64 Native Tools prompt navigate to the MagTense dir: 
 
 
 MagTense/source/MagTenseFortranCUDA/cuda
 
 Compile with nvcc 
 
 nvcc -c MagTenseCudaBlas.cu
 
 From the Intel 64 prompt:
 (compile the C++ wrapper with icl including the cuda stuff)
 
 icl -c MagTenseCudaBlasICLWrapper.cxx MagTenseCudaBlas.obj  /link "c:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v10.2\lib\x64\cublas.lib"
 
 Then compile MagTense as usual (there is a project in the MagTense solution that deals with CUDA)
 