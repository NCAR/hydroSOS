#!/bin/csh

set hcDate  = 201501
set stEns   = 0
set enEns   = 24
set inDir   = /glade/work/andywood/hydrosos/data/from_lc/hindcast_$hcDate/
set outDir  = /glade/work/andywood/hydrosos/data/proc/political/gadm1/hcst/$hcDate/
set mapping = mapping/mapping.smhi_to_gadm36-1.nc
set id2indx = smhi_id_index.filled.txt 
set stPoly  = 0
set enPoly  = 3609

# first set up python env
# module load python/3.6.8 
# source /glade/u/apps/opt/ncar_pylib/ncar_pylib.csh   # ncar_pylib


# loop through variables
foreach Var (SRFF CTMP CRUN CPRC COUT SNOW)

  # loop through ensemble members
  set Ens = $stEns
  while ($Ens <= $enEns)

     echo "--------------------"
     echo running $Var ens $Ens
     echo "--------------------"
     set inFile  = $inDir/$Ens/time$Var.txt.nc
     set outFile = $outDir/hcst.$Var.$Ens.nc

     # run poly2poly
     python poly2poly.map_vector_timeseries.py $mapping $inDir/$Ens/timeSRFF.txt.nc $outDir/hcst.SRFF.political.$Ens.nc str \
       $id2indx $stPoly $enPoly time$Var

    @ Ens ++
  end
end


    
