;================================================
;  wrf_topo2.ncl
;  Purpose: Plot WRF terrain with cross-section line and markers
;================================================

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
  ;---------------------------------------------
  ; Open WRF output file
  ;---------------------------------------------
  f = addfile("firstcase_d03_2021-01-13_12:00:00","r")

  ;---------------------------------------------
  ; Get terrain variable
  ;---------------------------------------------
  ter = wrf_user_getvar(f,"ter",0)

  ;---------------------------------------------
  ; Open workstation
  ;---------------------------------------------
  wks = gsn_open_wks("png","wrf_terrain")

  ;=============================================
  ; Contour plot resources (terrain)
  ;=============================================
  res = True
  res@cnFillOn           = True
  res@cnLinesOn          = False
  res@cnLineLabelsOn     = False
  res@cnFillPalette      = "OceanLakeLandSnow"
  res@cnLevelSelectionMode = "ExplicitLevels"
  res@cnLevels = (/0,250,500,750,1000,1500,2000,3000,4000/)
  res@lbOrientation      = "Horizontal"
  res@gsnDraw            = False
  res@gsnFrame           = False

  ; Create contour plot (off-screen)
  contour = wrf_contour(f, wks, ter, res)

  ;---------------------------------------------
  ; Map overlay resources
  ;---------------------------------------------
  mpres = True
  mpres@mpDataBaseVersion = "MediumRes"
  
  ; Plot resources for wrf_map_overlays
  pltres = True
  pltres@PanelPlot = True      ; important: keep all overlays in one figure
  pltres@gsnDraw  = False
  pltres@gsnFrame = False

  ; Overlay terrain (returns composite plot)
  plot = wrf_map_overlays(f, wks, (/contour/), pltres, mpres)

  ;=============================================
  ; Add cross-section line
  ;=============================================
  start_lat = 36.0
  start_lon = 48.0
  end_lat   = 37.5
  end_lon   = 50.0

  lat_line = (/ start_lat, end_lat /)
  lon_line = (/ start_lon, end_lon /)

  line_res = True
  line_res@gsLineColor      = "red"
  line_res@gsLineThicknessF = 2.0
  line_res@gsLineDashPattern = 0

  ; Add polyline to the overlay
  poly = gsn_add_polyline(wks, plot, lon_line, lat_line, line_res)

  ;=============================================
  ; Add endpoint markers
  ;=============================================
  pm_res = True
  pm_res@gsMarkerIndex  = 16   ; filled circle
  pm_res@gsMarkerSizeF  = 0.005
  pm_res@gsMarkerColor  = "red"

  pm = gsn_add_polymarker(wks, plot, lon_line, lat_line, pm_res)

  ;=============================================
  ; Draw and frame final plot
  ;=============================================
  draw(plot)
  frame(wks)

end
