;======================================================================
; vert_cross_wind.ncl
; Vertical cross-section of wind speed across Alborz (all times, up to 10 km)
;======================================================================

load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
  ;--- Input WRF file
  f = addfile("secondcase_d03_2021-01-15_12:00:00.nc","r")

  ;--- Read Times directly (char array)
  times  = f->Times
  ntimes = dimsizes(times(:,0))

  ;--- Define cross-section endpoints
  start_lat = 36.0
  start_lon = 48.0
  end_lat   = 37.5
  end_lon   = 50.0

  ;--- Loop over all times
  do it = 12, ntimes-1
    print("Working on time: " + chartostring(times(it,:)))

    ;--- Get variables at this time
    z    = wrf_user_getvar(f,"z",it)        ; height (m)
    ua   = wrf_user_getvar(f,"ua",it)       ; u wind
    va   = wrf_user_getvar(f,"va",it)       ; v wind
    wa   = wrf_user_getvar(f,"wa",it)       ; w wind
    wspd = sqrt(ua^2 + va^2)                ; wind speed (m/s)
    th   = wrf_user_getvar(f,"th",it)       ; potential temp
    tc   = wrf_user_getvar(f,"tc",it)       ; temp

    ;--- Cross-section interpolation
    opt = True
    opt@latlon      = True
    opt@linecoords  = True
    opt@file_handle = f
    wspd_xsec = wrf_user_vert_cross(wspd, z, (/start_lon,start_lat,end_lon,end_lat/), opt)

    ;--- Limit to ~10 km (first ~40 levels)
    wspd_xsec10 = wspd_xsec(0:40,:)
    valid_time = chartostring(times(it,:))

    ;--- Open workstation: one PNG per time
    wks_name = "vertw_xsection_" + sprinti("%03i",it)
    wks = gsn_open_wks("x11", wks_name)

    ;--- Plot resources
    res                      = True
    res@gsnMaximize          = True
    res@cnFillOn             = True
    res@cnLinesOn            = False
    res@cnLineLabelsOn       = False
    res@cnFillPalette        = "MPL_viridis"
    res@cnLevelSelectionMode = "ManualLevels" ; manually set the contour levels with the following 3 resources
    res@cnMinLevelValF  = 2               ; set the minimum contour level
    res@cnMaxLevelValF  = 28                       ; set the maximum contour level
    res@cnLevelSpacingF = 2                ; set the interval between contours
    res@lbOrientation        = "Vertical"
    res@tiMainString         = "Wind Speed Cross Section ("+start_lat+","+start_lon+") to ("+end_lat+","+end_lon+") ~C~Valid: " + valid_time
  ;  res@TimeLabel            = chartostring(times(it,:))

    ;--- Label x-axis with lat/lon
    xvalues = ispan(0,dimsizes(wspd_xsec10(0,:))-1,1)
    ll_step = 15
    res@tmXBMode          = "Explicit"
    res@tmXBValues        = xvalues(::ll_step)
    res@tmXBLabels        = sprintf("%5.2f",wspd_xsec@lats(::ll_step)) + "~S~o~N~N ~C~" + \
                            sprintf("%5.2f",wspd_xsec@lons(::ll_step)) + "~S~o~N~E"

    ;--- Create plot
    plot = gsn_csm_contour(wks,wspd_xsec10,res)

  end do   ; end time loop

end
