# module load python/3.6.8; ncar_pylib

import pandas as pd
import xarray as xr

# input data particulars
inDir    = '../smhi/hindcast_202004/init_states/'
outDir   = inDir                        # might differ
Vars     = ['CPRC', 'CTMP', 'CRUN']
varTypes = ['mean', 'mean', 'mean']       # used only in filename for now

for varType,var in zip(varTypes, Vars):

    print("processing variable %s" % var)
    inTxtFile = inDir + varType + '_time' + var + '.txt'
    outNcFile = outDir + 'time' + var + '.nc'

    # read text file input, convert to an xarray object, rename dimensions and variable, write
    df = pd.read_csv(inTxtFile, header=1, sep='\t', index_col=0, parse_dates=[0])
    xdf = xr.DataArray(df, name=('time'+var)).astype(float)
    xdf = xdf.rename({'DATE':'time', 'dim_1':'subid'})
    xdf.to_netcdf(outNcFile)
    print(" -- wrote %s" % outNcFile)
    

    # can add attributes (in place) with
    # xdf.('time'+var).attrs['units'] = 'x units'

# old testing time syntax
#import datetime
#print("%s: read data" % datetime.datetime.now().time())
