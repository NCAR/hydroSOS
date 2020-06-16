#!/bin/csh
# run p2p mapping for timeXhru netcdf hindcasts
# runs for 6 variables, for one (user specified) ensemble member
# A. Wood, 2020

set pyScript = poly2poly.map_vector_timeseries.py

#set hcDate   = 201501
set hcDate    = 199301
set inDir     = /glade/work/andywood/hydrosos/data/smhi/model_run_19810101_20151231/
set id2indx   = smhi_id_index.filled.txt 
set outIDtype = str

#set label    = gadm36-1
#set outDir   = /glade/work/andywood/hydrosos/data/proc/political/$label/hcst/$hcDate/
#set mapping  = mapping/mapping.smhi_to_$label.nc
#set stPoly   = 0      # for output dataset
#set enPoly   = 3609   # for output

set label     = hybas_lev5
#set outDir   = /glade/work/andywood/hydrosos/data/proc/basins/$label/clim/
set outDir    = ./
set mapping   = mapping/mapping.smhi_to_$label.nc
set stPoly    = 0      # for output dataset, count starts at 0
set enPoly    = 4733   # for output (check mapping file)  # also lev4 1341; lev3 291

# first set up python env (ideally before running script)
# module load python/3.6.8 
# source /glade/u/apps/opt/ncar_pylib/ncar_pylib.csh   # ncar_pylib

# loop through variables
foreach Var (timeSRFF timeCTMP timeCRUN timeCPRC timeCOUT timeSNOW)

  echo "------------"
  echo running $Var 
  echo "------------"
  set inFile  = $inDir/$Var.txt.nc
  set outFile = $outDir/model_run.$Var.$label.nc

  # run poly2poly
  echo python $pyScript $mapping $inFile $outFile $outIDtype $id2indx $stPoly $enPoly $Var
  # exit
  python $pyScript $mapping $inFile $outFile $outIDtype $id2indx $stPoly $enPoly $Var

end
