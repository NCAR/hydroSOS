#!/bin/csh
# run p2p mapping for timeXhru netcdf hindcasts
# runs for 6 variables, for one (user specified) ensemble member

# on cheyenne, need:  module load python/2.7.15; source /glade/u/apps/opt/ncar_pylib/ncar_pylib.csh (or ncar_pylib)
# A. Wood, 2020

#set pyScript = poly2poly.map_vector_timeseries.exclvoids.py    -- triggered voids ... double check 
#set pyScript = poly2poly.map_vector_timeseries.withvoids.py   
set pyScript = poly2poly.map_vector_timeseries.devel.py   

set hcDate    = 202004
set inDir     = ../smhi/hindcast_202004/init_states/
set id2indx   = smhi_id_index.filled.txt 
set outIDtype = str

set label    = gadm36-1
#set outDir   = /glade/work/andywood/hydrosos/data/proc/political/$label/status/
set outDir   = ./
set mapping  = mapping/mapping.smhi_to_$label.nc
set stPoly   = 0      # for output dataset
set enPoly   = 9   # for output (with voids)
#set enPoly   = 3609   # for output (with voids)

#set label     = hybas_lev5
#set outDir   = /glade/work/andywood/hydrosos/data/proc/basins/$label/status/
#set mapping   = mapping/mapping.smhi_to_$label.nc
#set stPoly    = 0      # for output dataset, count starts at 0
#set enPoly    = 4733   # for output (check mapping file)  # also lev4 1341; lev3 291


# loop through variables
#foreach Var (timeSRFF timeCTMP timeCRUN timeCPRC timeCOUT timeSNOW)
#foreach Var (timeCTMP timeCRUN timeCPRC)
foreach Var (timeCRUN)

  echo "------------"
  echo running $Var 
  echo "------------"
  set inFile  = $inDir/$Var.nc
  set outFile = $outDir/status.$Var.$label.$hcDate.nc

  # run poly2poly
  echo python $pyScript $mapping $inFile $outFile $outIDtype $id2indx $stPoly $enPoly $Var
  # exit
  python $pyScript $mapping $inFile $outFile $outIDtype $id2indx $stPoly $enPoly $Var

end



# or is this: 
# first set up python env (ideally before running script)
# module load python/3.6.8 
# source /glade/u/apps/opt/ncar_pylib/ncar_pylib.csh   # ncar_pylib
