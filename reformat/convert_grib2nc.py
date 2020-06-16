import xarray as xr
gribfn='/glade/work/eriddle/hydrosos/data/ecmwf/ecmwf_test.grib'
ncfn='/glade/work/eriddle/hydrosos/data/ecmwf/ecmwf_test.nc'
f=xr.open_dataset(gribfn,engine='pynio')
f.to_netcdf(path=ncfn)
