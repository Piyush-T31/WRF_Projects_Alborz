;FILES = systemfunc (" ls -1 " + "grand_daily/201806/Week2/wrfout_d02* ")  ; The WRF ARW input file.
;a = addfiles(FILES+".nc","r")

begin
f = addfiles("firstcase_d03_2021-01-13_12:00:00.nc","r")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;i = 160     ; OIGG
;j = 191

i = 85 ; Kermanshah
j = 79

;i = 212 ; Tehran
;j = 132


;lat =  37.32 ; OIGG
;lon =  49.62

;lat =  34.26 ; Kermanshah
;lon =  47.11

lat =  35.68 ; Tehran
lon =  51.35


;opt = True
;b = wrf_user_ll_to_xy(f,lon,lat,opt)
;print(b)

  file_name = "kerman16th_profile.csv"
  system("rm -f " + file_name)

    ;--- Header for the CSV
  write_table(file_name,"w",[/"Z(m)","WS(knots)","WD(deg)","Theta(K)","Td(C)","T(C)"/],"%s,%s,%s,%s,%s,%s")

  ;--- Choose time index
  it = 60         ; time index (change as needed)

  ;--- Get height above mean sea level
  z = wrf_user_getvar(f,"z",it)
  z_profile = z(:,j,i)

  ;--- Get 3D fields
  U = wrf_user_getvar(f,"ua",it)       ; unstaggered U (m/s)
  V = wrf_user_getvar(f,"va",it)       ; unstaggered V (m/s)
  T = wrf_user_getvar(f,"tc",it)       ; temperature (C)
  TH = wrf_user_getvar(f,"theta",it)    ; potential temperature (K)
  TD = wrf_user_getvar(f,"td",it)      ; dewpoint temperature (C)

  u_col = U(:,j,i)
  v_col = V(:,j,i)
  ws_col = sqrt(u_col^2 + v_col^2)
  ws_knots = ws_col * 1.94384          ; convert m/s into knots

  wd_col = wind_direction(u_col, v_col, 0) ; wind direction

  t_col = T(:,j,i)
  theta_col = TH(:,j,i)
  td_col = TD(:,j,i)   

  ;--- Write each level
  nz = dimsizes(z_profile)
  do k = 0, nz-1
    write_table(file_name,"a",[/z_profile(k),ws_knots(k),wd_col(k),theta_col(k),td_col(k),t_col(k)/],"%8.2f,%6.2f,%6.2f,%8.2f,%6.2f,%6.2f")
  end do
end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

