;========================================================
; WRF 10m wind plot with ZoomIn (proper method)
;========================================================

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
  ;-----------------------------------------------
  ; Open WRF output file
  ;-----------------------------------------------
  a = addfile("firstcase_d03_2021-01-13_12:00:00.nc","r")
  times = wrf_user_getvar(a,"times",-1)
  ntimes = dimsizes(times)

  ;-----------------------------------------------
  ; Open workspace
  ;-----------------------------------------------
  wks = gsn_open_wks("png","horizontal_psfc")
  gsn_define_colormap(wks,"BlWhRe")
;  setvalues(NhlGetWorkspaceObjectId(), "wsMaximumSize", 300000000)

  ;-----------------------------------------------
  ; Map and plot resources
  ;-----------------------------------------------
  mpres = True
  mpres@mpGeophysicalLineColor      = "Black"
  mpres@mpGridLineColor             = "Black"
  mpres@mpGeophysicalLineThicknessF = 2
  mpres@ZoomIn = True      ; Enable zoom
  mpres@Xstart = 127       ; Subdomain indices
  mpres@Xend   = 185
  mpres@Ystart = 142
  mpres@Yend   = 217

  pltres = True
  pltres@PanelPlot = True

  ;-----------------------------------------------
  ; Loop over time
  ;-----------------------------------------------
  do it = 12, ntimes-1
    print("Working on time: " + times(it))

    ; Get full U10/V10 and compute wind speed
    u10 = wrf_user_getvar(a,"U10",it)
    v10 = wrf_user_getvar(a,"V10",it)
    t2  = wrf_user_getvar(a,"T2",it)
    rh2 = wrf_user_getvar(a,"rh2",it)
    psfc = wrf_user_getvar(a,"PSFC",it)
    Psfc = psfc/ 100        ; convert from Pa to hPa    
    Psfc@units = "hPa"
    wspd = sqrt(u10^2 + v10^2)
    wspd@units = "m/s"

    ;-----------------------------------------------
    ; Contour plot of wind speed
    ;-----------------------------------------------
    res = True
    res@cnFillOn      = True
    res@cnLinesOn     = False
;    res@gsnAddCyclic  = False
    res@cnFillOpacityF = 0.8          ; make fill semi-transparent for wind visibility
    res@cnLevelSelectionMode = "ManualLevels" ; manually set the contour levels with the following 3 resources
   res@cnMinLevelValF  = 600              ; set the minimum contour level
   res@cnMaxLevelValF  = 1020                     ; set the maximum contour level
    res@cnLevelSpacingF = 20              ; set the interval between contours

    res@FieldTitle    = "Surface Pressure"
    res@TimeLabel     = times(it)   ; show valid time
;    res@TimeLabelOn   = True
    res@MainTitle     = ""          ; avoid overlap with TimeLabel
    contour = wrf_contour(a,wks,Psfc,res)

    ;-----------------------------------------------
    ; Vector plot of winds
    ;-----------------------------------------------
    vres = True
    vres@vcGlyphStyle   = "CurlyVector"
    vres@vcMinDistanceF = 0.05   ; Thinning for clarity
    vres@FieldTitle     = "10m Winds"
    vector = wrf_vector(a,wks,u10,v10,vres)

    ;-----------------------------------------------
    ; Overlay contour and vectors
    ;-----------------------------------------------
    plot = wrf_map_overlays(a,wks,(/contour, vector/),pltres,mpres)
    draw(plot)
    frame(wks)

    delete(contour)
    delete(vector)
  end do

end
