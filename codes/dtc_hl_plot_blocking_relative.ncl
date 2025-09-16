begin
pwdir     = "./"

f1         = addfile("../../NatComm_CRE_Bocking_Lubis/Figure7/dtc.blocking-relative.merra2.nc", "r")
f2         = addfile("../../NatComm_CRE_Bocking_Lubis/Figure7/dtc.blocking-relative.ctl.nc", "r")
f3         = addfile("../../NatComm_CRE_Bocking_Lubis/Figure7/dtc.blocking-relative.clock.nc", "r")
f4         = addfile("../../NatComm_CRE_Bocking_Lubis/Figure7/dtc.blocking-relative.lwoff.nc", "r")

blk1m = f1->dtc
blk1c = f2->dtc
blk1k = f3->dtc
blk1l = f4->dtc
  
wks  = gsn_open_wks("pdf","hl_dtc_lag_relative_blocking_-3-0-SL")   

  res                     = True          ; plot mods desired
  res@gsnMaximize  = True
  res@gsnDraw         = False
  res@gsnFrame        = False

  res@vpWidthF = 0.2
  res@vpHeightF = 0.1

  res@cnFillOn            = True          ; turn on color
  res@lbLabelBarOn              = False             
  res@tiMainOn                  = False

  res@cnFillPalette             = "NCV_blue_red" ;"temp_19lev"      
  res@cnLevelSelectionMode      = "ManualLevels"   
  res@cnMinLevelValF            =   -4
  res@cnMaxLevelValF            =   4
  res@cnLevelSpacingF           =   .5
  res@cnOutOfRangeFillScaleF    =   2 
  res@cnInfoLabelOn             = False    
  res@cnLinesOn                 = False    
  res@cnLineLabelsOn            = False 

  ; res@tmEqualizeXYSizes = True
  res@gsnLeftString    = ""
  res@tmXBMode        = "Explicit"
  res@tmXBValues      = fspan(-60, 60, 7)
  ; print(fspan(-20, 20, 21))
  res@tmXBLabels      = "" + res@tmXBValues

  res@tmYLMinorOn    = False
  res@tmYRBorderOn   = True    
  res@tmXTBorderOn   = True
  res@tmYROn               = False
  res@tmXTOn               = False
  res@tmYRMode = "Automatic"
  
  res@tiYAxisString = "Level [hPa]"
  res@tiXAxisString = "Relative Lon."
  
  res@trYReverse = True
  res@tmYLMode = "Explicit"
  res@tmYLValues = (/950.0, 800.0, 700.0, 600.0, 500.0, 400.0, 300.0, 200.0 /)
  res@tmYLLabels = (/"950", "800", "700", "600", "500", "400", "300", "200" /)
res@tmYLLabelsOn    = True
; print(fspan(-20, 20, 21))
;res@tmYLLabels      = "" + res@tmYLValues

res@vpWidthF            = 0.45           
res@vpHeightF           = 0.5

  res@tmXBLabelFontHeightF = 0.035           ; resize tick labels
  res@tmYLLabelFontHeightF = 0.035
  res@tiXAxisFontHeightF = 0.03
  res@tiYAxisFontHeightF = 0.03
  res@gsnCenterStringFontHeightF = 0.02
  
res@gsnMaximize         = True         
res@tmXBLabelStride     = 1
res@tmYLLabelStride      = 1


blk_plot  = blk1m ;/100
copy_VarCoords(blk1m, blk_plot)

plot = new(4, graphic)
res@gsnCenterString    = "";Blocking Composite [dtcond] [lag -6]"
plot(0) = gsn_csm_pres_hgt(wks,blk1m,res) 
  res@tiYAxisString = " "
res@gsnCenterString    = "";Blocking Composite [dtcond] [lag -3]"
plot(1) = gsn_csm_pres_hgt(wks,blk1c,res) 
res@gsnCenterString    = "";Blocking Composite [dtcond] [lag 0]"
plot(2) = gsn_csm_pres_hgt(wks,blk1k,res) 
res@gsnCenterString    = "";Blocking Composite [dtcond] [lag 0]"
plot(3) = gsn_csm_pres_hgt(wks,blk1l,res) 

nvalues = 2
dum1 = new(nvalues,graphic)
dum2 = new(nvalues,graphic)
dum3 = new(nvalues,graphic)
dum4 = new(nvalues,graphic)

plres = True
plx = (/0., 0./)
ply = (/950., 200./)

plres@gsLineColor = "black"
plres@gsLineThicknessF = 1
plres@gsLineDashPattern  = 0

dum1(0) = gsn_add_polyline(wks, plot(0), plx, ply, plres)
;dum1(1) = gsn_add_polyline(wks, plot(0), plx(2:3), ply(2:3), plres)

dum2(0) = gsn_add_polyline(wks, plot(1), plx, ply, plres)
;dum2(1) = gsn_add_polyline(wks, plot(1), plx(2:3), ply(2:3), plres)

dum3(0) = gsn_add_polyline(wks, plot(2), plx, ply, plres)
;dum3(1) = gsn_add_polyline(wks, plot(2), plx(2:3), ply(2:3), plres)

dum4(0) = gsn_add_polyline(wks, plot(3), plx, ply, plres)

;-------------------------------------------------

fname1al    = "../../blocking_relative/blocking_relative_composite/NCFORCE/MERRA2/lon_lev_composite/mst_output/blocking_relative_mst_lag-3.nc"
fname2al    = "../../blocking_relative/blocking_relative_composite/NCFORCE/MERRA2/lon_lev_composite/mst_output/blocking_relative_mst_lag0.nc"

fname1bl    = "../../blocking_relative/blocking_relative_composite/NCFORCE/CTL/lon_lev_composites/dtc_output/blocking_relative_dtc_lag-3.nc"
fname2bl    = "../../blocking_relative/blocking_relative_composite/NCFORCE/CTL/lon_lev_composites/dtc_output/blocking_relative_dtc_lag0.nc"

fname1cl    = "../../blocking_relative/blocking_relative_composite/NCFORCE/CLOCK/lon_lev_composite/dtc_output/blocking_relative_dtc_lag-3.nc"
fname2cl    = "../../blocking_relative/blocking_relative_composite/NCFORCE/CLOCK/lon_lev_composite/dtc_output/blocking_relative_dtc_lag0.nc"

fname1dl    = "../../blocking_relative/blocking_relative_composite/NCFORCE/LWOFF/lon_lev_composite/blocking_relative_dtc_lag-3.nc"
fname2dl    = "../../blocking_relative/blocking_relative_composite/NCFORCE/LWOFF/lon_lev_composite/blocking_relative_dtc_lag0.nc"

f1l         = addfile(fname1al, "r")
f2l         = addfile(fname2al, "r")

g1l         = addfile(fname1bl, "r")
g2l         = addfile(fname2bl, "r")

h1l         = addfile(fname1cl, "r")
h2l         = addfile(fname2cl, "r")

i1l         = addfile(fname1dl, "r")
i2l         = addfile(fname2dl, "r")

blk1ml      = dim_avg_n_Wrap(f1l->block(:,{-10:10},{-62:62}), 1)
blk2ml      = dim_avg_n_Wrap(f2l->block(:,{-10:10},{-62:62}), 1)

blk1ml = (blk1ml + blk2ml)/2
blk1ml = blk1ml*24*60*60

blk1cl      = dim_avg_n_Wrap(g1l->block(:,{-10:10},{-62:62}), 1)
blk2cl      = dim_avg_n_Wrap(g2l->block(:,{-10:10},{-62:62}), 1)

blk1cl = (blk1cl + blk2cl)/2
blk1cl = blk1cl*24*60*60

blk1kl      = dim_avg_n_Wrap(h1l->block(:,{-10:10},{-62:62}), 1)
blk2kl      = dim_avg_n_Wrap(h2l->block(:,{-10:10},{-62:62}), 1)

blk1kl = (blk1kl + blk2kl)/2
blk1kl = blk1kl*24*60*60

blk1ll      = dim_avg_n_Wrap(i1l->block(:,{-10:10},{-62:62}), 1)
blk2ll      = dim_avg_n_Wrap(i2l->block(:,{-10:10},{-62:62}), 1)

blk1ll = (blk1ll + blk2ll)/2
blk1ll = blk1ll*24*60*60

;************************************************
; Resource for Contour Line
;************************************************
  res2                      = True
  res2@gsnDraw              = False             
  res2@gsnFrame             = False
  res2@cnLevelSelectionMode = "ManualLevels"   
  res2@cnMinLevelValF       =  1.             
  res2@cnMaxLevelValF       =  10.           
  res2@cnLevelSpacingF      =  5.          
  ;res2@cnLineLabelsOn       = False
  res2@cnLineLabelPlacementMode   = "constant"
  res2@cnLineColor          = "red3"
  res2@gsnContourZeroLineThicknessF = 0 	
  res2@gsnContourNegLineDashPattern = 1
  res2@gsnContourLineThicknessesScale = 1.0
  res2@cnInfoLabelOn             = False
  
  res2@gsnLeftString   = " "              
  res2@gsnRightString  = " "
  
  plot1 = new(4, graphic)
  plot1(0)   = gsn_csm_contour(wks,blk1ml,res2)
  plot1(1)   = gsn_csm_contour(wks,blk1cl,res2)
  plot1(2)   = gsn_csm_contour(wks,blk1kl,res2)
  plot1(3)   = gsn_csm_contour(wks,blk1ll,res2)
  

  ;overlay(plot(0), plot1(0))
  ;overlay(plot(1), plot1(1))
  ;overlay(plot(2), plot1(2))
  ;overlay(plot(3), plot1(3))

;*******************************************************
  
  res1                           = True
  res1@gsnDraw                   = False          
  res1@gsnFrame                  = False           
  res1@gsnStringFontHeightF      = 0.02     

  res1@lbLabelBarOn              = False          
  res1@tiMainOn                  = False

  res1@cnSpanFillPalette         = False
  res1@cnFillPattern             = 7
  res1@cnFillDotSizeF            = 0.005
  res1@cnFillColor               = "red4"
 
  res1@cnInfoLabelOn             = False       
  res1@cnLinesOn                 = False       
  res1@cnLineLabelsOn            = False       

  res1@cnFillOn            	  = True    
  res1@cnInfoLabelOrthogonalPosF  = -0.2    
  res1@cnLineLabelFontHeightF     = .02

  res1@tmXBLabelFontHeightF = 0.02    
  res1@tmYLLabelFontHeightF = 0.02     
  res1@tmYROn               = False
  res1@tmXTOn               = False
  res1@gsnLeftString   = " "              
  res1@gsnRightString  = " "
  
  plot2 = new(4, graphic)
  plot2(0)   = gsn_csm_contour(wks,blk1ml,res1)
  plot2(1)   = gsn_csm_contour(wks,blk1cl,res1)
  plot2(2)   = gsn_csm_contour(wks,blk1kl,res1)
  plot2(3)   = gsn_csm_contour(wks,blk1ll,res1)

  opt              = True
  opt@gsnShadeFillType = "pattern"
  ;opt@gsnShadeMid = 17 
  ;opt@gsnShadeLow  = 17
  opt@gsnShadeHigh = 7
  opt@gsnShadeFillScaleF = 0.8
  opt@gsnShadeFillDotSize = 0.0005
 
 plot2(0) = gsn_contour_shade(plot2(0),-999,res2@cnMinLevelValF,opt)
 plot2(1) = gsn_contour_shade(plot2(1),-999,res2@cnMinLevelValF,opt)
 plot2(2) = gsn_contour_shade(plot2(2),-999,res2@cnMinLevelValF,opt)
 plot2(3) = gsn_contour_shade(plot2(3),-999,res2@cnMinLevelValF,opt)

 ;overlay(plot(0), plot2(0))
 ;overlay(plot(1), plot2(1))
 ;overlay(plot(2), plot2(2))
 ;overlay(plot(3), plot2(3))
;************************************************
; resource list for panel
;************************************************
  resP                         = True                
  resP@gsnMaximize             = True              
  resP@gsnPanelLabelBar        = True               
  resP@txFontHeightF           = 1.0
  resP@lbLabelFontHeightF      = 0.005
  resP@gsnPanelMainFontHeightF = 0.02        
  resP@lbBoxLinesOn = False
  
  resP@lbTitleOn               =  True          
  resP@lbTitleString           = "[10~S~-1~N~ K day~S~-1~N~]"                
  resP@lbTitlePosition         = "bottom"              
  resP@lbTitleFontHeightF      = .007                
  resP@lbTitleDirection        = "Across"
  ;resP@lbLabelStride           = 2
  resP@lbOrientation   = "vertical"
  
  resP@gsnPanelYWhiteSpacePercent = 1.5
  resP@gsnPanelXWhiteSpacePercent = 1.5
  resP@lbTopMarginF               = 0.1
  resP@lbBoxEndCapStyle           = "TriangleBothEnds"
  resP@pmLabelBarWidthF           = 0.01
  resP@pmLabelBarHeightF   	  = 0.25
  resP@lbLabelFontHeightF         = 0.01
  resP@pmLabelBarOrthogonalPosF   = 0.0
  
gsn_panel(wks,plot,(/1,4/),resP)
print("Finished ...")
end
