;FILES = systemfunc (" ls -1 " + "grand_daily/201806/Week2/wrfout_d02* ")  ; The WRF ARW input file.
;a = addfiles(FILES+".nc","r")
a = addfiles("firstcase_d03_2021-01-13_12:00:00.nc","r")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

i = 160     ; OIGG
j = 191

;i = 39 ; Wolfe Island
;j = 44

;lat =  37.32 ; OIGG
;lon =  49.62

;lat =  44.18122 ; Wolfe Island
;lon =  -76.47394

lat =  38.0 ; doing smaller domain
lon =  50.5


opt = True
b = wrf_user_ll_to_xy(a,lon,lat,opt)
print(b)

;file_name = "alborz_oigg.csv"
;system("rm -f " + file_name)
;write_table(file_name,"w",[/"Time","WS10","WD10","T2","TD2","P_sfc"/],"%s %s %s %s %s %s")

times = wrf_user_getvar(a,"times",-1)
ntimes = dimsizes(times)

do it = 0,ntimes-1
;    z = wrf_user_getvar(a,"z",0)
;    print(z(:,j,i))
;     z1 = wrf_user_getvar(a,"ter",0)
;    print(z1(j,i))
   U = wrf_user_getvar(a,"U10",it)
   u = U(j,i)

   V = wrf_user_getvar(a,"V10",it)
   v = V(j,i)
   ws = sqrt(u^2 +v^2)
;   ws  = ws1*3.6
;print(ws)
   wd = wind_direction(u,v,0)
;print(wd)
   T2 = wrf_user_getvar(a,"T2",it)
   t2 = T2(j,i)
   t2 = t2 - 273.15     ; in celcius

   Td2 = wrf_user_getvar(a,"td2",it)
   td2 = Td2(j,i)
   P_sfc = wrf_user_getvar(a,"PSFC",it)
   p_sfc = P_sfc(j,i)

;   rh = wrf_user_getvar(a,"rh2",it)

;write_table(file_name,"a",[/times(it),ws,wd,t2,td2,p_sfc/],"%s %f %f %f %f %f")
;end do

;print(ws)

;u1 = wrf_user_getvar(a,"U10",1)
;print(u1)


;WS = wrf_user_getvar(a,"wspd_wdir10",24)
;print(WS(0,j,i))
;b = wrf_user_xy_to_ll(a,j,i,True)
;print(b)
;timestep = -1
;times = wrf_user_getvar(a,"times",-1)
;print(times(it))
;ntimes = dimsizes(times)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

