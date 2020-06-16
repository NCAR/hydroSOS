import sys
import os
sys.path.append('/glade/u/home/eriddle/hydrosos/utils/')
import poly2poly
import xarray as xr
import numpy as np
import pandas as pd
import pdb
from datetime import datetime
indir='/glade/work/andywood/hydrosos/data/smhi/'
outdir='/glade/work/eriddle/hydrosos/data/netcdf/SMHI/hindcasts/'
mappingdir='/glade/work/eriddle/hydrosos/data/mapping/'
#shpname='gadm36-1'
#shptype='political'
shpnamelist=['hybas_lev4','hybas_lev5']
shptypelist=['basins','basins']
id2indx=mappingdir+'smhi_id_index.filled.txt'
enslabels=[str(n) for n in np.arange(415,466)]
init_date=datetime(2020,4,1)
npoly=131296
stPoly=0
enPoly=3609

data=np.ma.masked_all((1000,npoly))
vars=['CPRC','CTMP','CRUN']
vartypes=['accum','inst','accum']
newens=0
for shpname,shptype in zip(shpnamelist,shptypelist):
	mappingfile=mappingdir+'mapping.smhi_to_'+shpname+'.nc'
	for vartype,var in zip(vartypes,vars):
		for ens in enslabels:
			date=[]
			txtfn=indir+'hindcast_'+init_date.strftime('%Y%m')+'/'+var+'/time'+var+'_'+ens+'.txt'
			i=0
			with open(txtfn) as f:
				for line in f:
					print(i)
					print(line.split()[0])
					if i==0:
						header=line
					elif i==1:
						polyid=np.ma.array(line.split()[1:])
					else:
						data[i-2,:]=line.split()[1:]
						date.append(line.split()[0])
					i=i+1
			pddate=pd.to_datetime(date)
			ntime=len(date)
			data_new=data[0:ntime,:]
			pcp=xr.DataArray(data=data_new,coords=[pddate,polyid],dims=['time','subid'])
			if vartype in ['accum']:
				monthlypcp=pcp.resample(time='1MS').sum('time')
			elif vartype in ['inst']:
				monthlypcp=pcp.resample(time='1MS').mean('time')
			xdata=xr.Dataset(data_vars={'time'+var:monthlypcp})
			ncfn=outdir+'basins/SMHI_original/'+init_date.strftime('%Y%m')+'/'+var+'/hindcast_SMHI_originalbasins_'+init_date.strftime('%Y%m')+'_'+var+'_ens'+str(newens)+'.nc'
			xdata.to_netcdf(path=ncfn)
			ncfn_out=outdir+shptype+'/'+shpname+'/'+init_date.strftime('%Y%m')+'/'+var+'/hindcast_SMHI_'+shpname+'_'+init_date.strftime('%Y%m')+'_'+var+'_ens'+str(newens)+'.nc'
			poly2poly.poly2poly(mappingfile,ncfn,ncfn_out,'str',id2indx,stPoly,enPoly,'time'+var)	
			newens=newens+1
