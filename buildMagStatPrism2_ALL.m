    
clear all

    
mex -g -Lsource\MagStatPrisms2\MagStatVersion2\MagStatVersion2\x64\release\ -lMagStatVersion2...
    -Isource\MagStatPrisms2\MagStatVersion2\MagStatVersion2\x64\release\ ...
    -Lsource\SpecialFunctions\SpecialFunctions\x64\release\ -lSpecialFunctions ...
    -Isource\SpecialFunctions\SpecialFunctions\x64\release\ ...
    -Lsource\NumericalIntegrationLib\NumericalIntegration\NumericalIntegration\x64\release\ -lsource\NumericalIntegration ...
    -Isource\NumericalIntegrationLib\NumericalIntegration\NumericalIntegration\x64\release\ ...
    -Lsource\TileDemagTensor\TileDemagTensor\TileDemagTensor\x64\release\ -lTileDemagTensor ...
    -Isource\TileDemagTensor\TileDemagTensor\TileDemagTensor\x64\release\ ...        
    source\MagStatPrismMex\MagStatPrismMex\IterateMagnetization_mex.f90 COMPFLAGS="$COMPFLAGS /O3 /extend_source:132 /real_size:64 /fpe:0"
        
mex -g -Lsource\MagStatPrisms2\MagStatVersion2\MagStatVersion2\x64\release\ -lMagStatVersion2...
    -Isource\MagStatPrisms2\MagStatVersion2\MagStatVersion2\x64\release\ ...
    -Lsource\SpecialFunctions\SpecialFunctions\x64\release\ -lSpecialFunctions ...
    -Isource\SpecialFunctions\SpecialFunctions\x64\release\ ...
    -Lsource\NumericalIntegrationLib\NumericalIntegration\NumericalIntegration\x64\release\ -lsource\NumericalIntegration ...
    -Isource\NumericalIntegrationLib\NumericalIntegration\NumericalIntegration\x64\release\ ...
    -Lsource\TileDemagTensor\TileDemagTensor\TileDemagTensor\x64\release\ -lTileDemagTensor ...
    -Isource\TileDemagTensor\TileDemagTensor\TileDemagTensor\x64\release\ ...    
    source\MagStatPrismMex\MagStatPrismMex\getHFromTiles_mex.f90 COMPFLAGS="$COMPFLAGS /O3 /extend_source:132 /real_size:64  /fpe:0"

mex -g -Lsource\MagStatPrisms2\MagStatVersion2\MagStatVersion2\x64\release\ -lMagStatVersion2...
    -Isource\MagStatPrisms2\MagStatVersion2\MagStatVersion2\x64\release\ ...
    -Lsource\SpecialFunctions\SpecialFunctions\x64\release\ -lSpecialFunctions ...
    -Isource\SpecialFunctions\SpecialFunctions\x64\release\ ...
    -Lsource\NumericalIntegrationLib\NumericalIntegration\NumericalIntegration\x64\release\ -lsource\NumericalIntegration ...
    -Isource\NumericalIntegrationLib\NumericalIntegration\NumericalIntegration\x64\release\ ...
    -Lsource\TileDemagTensor\TileDemagTensor\TileDemagTensor\x64\release\ -lTileDemagTensor ...
    -Isource\TileDemagTensor\TileDemagTensor\TileDemagTensor\x64\release\ ...        
    source\MagStatPrismMex\MagStatPrismMex\getNFromCylTile_mex.f90 COMPFLAGS="$COMPFLAGS /O3 /extend_source:132 /real_size:64  /fpe:0"


mex -g -Lsource\MagneticForceIntegrator\MagneticForceIntegrator\x64\release\ -lMagneticForceIntegrator...
    -Isource\MagneticForceIntegrator\MagneticForceIntegrator\x64\release\ ...
    -Lsource\MagStatPrisms2\MagStatVersion2\MagStatVersion2\x64\release\ -lMagStatVersion2...
    -Isource\MagStatPrisms2\MagStatVersion2\MagStatVersion2\x64\release\ ...
    -Lsource\NumericalRecipes\NumericalRecipes\x64\release\ -lNumericalRecipes...    
    -Isource\NumericalRecipes\NumericalRecipes\x64\release\ ...
    -Lsource\SpecialFunctions\SpecialFunctions\x64\release\ -lSpecialFunctions ...
    -Isource\SpecialFunctions\SpecialFunctions\x64\release\ ...
    -Lsource\NumericalIntegrationLib\NumericalIntegration\NumericalIntegration\x64\release\ -lsource\NumericalIntegration ...
    -Isource\NumericalIntegrationLib\NumericalIntegration\NumericalIntegration\x64\release\ ...
    -Lsource\TileDemagTensor\TileDemagTensor\TileDemagTensor\x64\release\ -lTileDemagTensor ...
    -Isource\TileDemagTensor\TileDemagTensor\TileDemagTensor\x64\release\ ...        
    source\MagStatPrismMex\MagStatPrismMex\getMagForce_mex.f90 COMPFLAGS="$COMPFLAGS /O2 /Qopenmp /extend_source:132 /real_size:64  /fpe:0"
        
