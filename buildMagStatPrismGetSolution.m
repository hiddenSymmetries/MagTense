clear all
% mex -g -LMagStatPrismLib\MagStatPrismLib\x64\Release\ -lMagStatPrismLib ...
mex -LMagStatPrismLib\MagStatPrismLib\x64\Release\ -lMagStatPrismLib ...
    -IMagStatPrismLib\MagStatPrismLib\x64\Release\ ...
    MagStatPrismMEX\MagStatPrismMEX\magStatMEX_getSolution.f90 ...
    COMPFLAGS5="$COMPFLAGS /MT /extend_source:132 /real_size:64"