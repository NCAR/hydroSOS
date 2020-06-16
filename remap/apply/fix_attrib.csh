#!/bin/csh

# module load nco

set inDir = ../proc/political/gadm36-1/clim/

foreach V (timeCPRC timeCRUN timeCTMP timeSRFF timeSNOW timeCOUT)
   ncatted -a _FillValue,$V,m,f,-9999.0 $inDir/model_run.gadm36-1.$V.nc
end


exit

ncatted -a units,timeCTMP,o,c,"days since 2020-03-01 00:00:00" status.timeCTMP.gadm36-1.202004.nc
  1202	22:28	ncatted -a units,timeCPRC,o,c,"days since 2020-03-01 00:00:00" status.timeCPRC.gadm36-1.202004.nc
  1203	22:28	ncatted -a units,timeCRUN,o,c,"days since 2020-03-01 00:00:00" status.timeCRUN.gadm36-1.202004.nc
  1204	22:28
