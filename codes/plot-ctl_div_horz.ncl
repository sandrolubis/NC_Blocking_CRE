
load"./lat-lon_labels.ncl"
print("Reading File ...")

  f1 = addfile("../../NatComm_CRE_Bocking_Lubis/Figure3/div_horz.lag-3.nc", "r")
  f2 = addfile("../../NatComm_CRE_Bocking_Lubis/Figure3/div_horz.lag-2.nc", "r")
  f3 = addfile("../../NatComm_CRE_Bocking_Lubis/Figure3/div_horz.lag-1.nc", "r")
  f4 = addfile("../../NatComm_CRE_Bocking_Lubis/Figure3/div_horz.lag0.nc", "r")
  
  g1 = addfile("../../NatComm_CRE_Bocking_Lubis/Figure3/z500.anom.lag-3.nc", "r")
  g2 = addfile("../../NatComm_CRE_Bocking_Lubis/Figure3/z500.anom.lag-2.nc", "r")
  g3 = addfile("../../NatComm_CRE_Bocking_Lubis/Figure3/z500.anom.lag-1.nc", "r")
  g4 = addfile("../../NatComm_CRE_Bocking_Lubis/Figure3/z500.anom.lag0.nc", "r")
  
 x3 = f1->div_horz
 x2 = f2->div_horz
 x1 = f3->div_horz
 x0 = f4->div_horz
 
 y3 = g1->z500_anom
 y2 = g2->z500_anom
 y1 = g3->z500_anom
 y0 = g4->z500_anom
 
 g1x = addfile("../../NatComm_CRE_Bocking_Lubis/Figure3/fx.lag-3.nc", "r")
 g2x = addfile("../../NatComm_CRE_Bocking_Lubis/Figure3/fx.lag-2.nc", "r")
 g3x = addfile("../../NatComm_CRE_Bocking_Lubis/Figure3/fx.lag-1.nc", "r")
 g4x = addfile("../../NatComm_CRE_Bocking_Lubis/Figure3/fx.lag0.nc", "r")
 
 g1y = addfile("../../NatComm_CRE_Bocking_Lubis/Figure3/fy.lag-3.nc", "r")
 g2y = addfile("../../NatComm_CRE_Bocking_Lubis/Figure3/fy.lag-2.nc", "r")
 g3y = addfile("../../NatComm_CRE_Bocking_Lubis/Figure3/fy.lag-1.nc", "r")
 g4y = addfile("../../NatComm_CRE_Bocking_Lubis/Figure3/fy.lag0.nc", "r")
 
 fx3 = g1x->fx
 fx2 = g2x->fx
 fx1 = g3x->fx
 fx0 = g4x->fx
 
 fy3 = g1y->fy
 fy2 = g2y->fy
 fy1 = g3y->fy
 fy0 = g4y->fy
 
;************************************************************
; OUTPUT
;************************************************************
  pltDir  = "./"
  pltType = "pdf"          
  pltName = "3-CTL_DIV_HORZ-SL"
  
;************************************************************
; PLOT
;************************************************************

  print("let's plot ...")
  
  pltPath = pltDir+pltName
  wks     = gsn_open_wks(pltType, pltPath)  
  plot1 = new(4, "graphic")
  plot2 = new(4, "graphic")
  
;************************************************************* 
; Resource of Color Shading
;*************************************************************
  res                           = True
  res@gsnDraw                   = False             
  res@gsnFrame                  = False          
  res@gsnStringFontHeightF      = 0.015          
  res@mpProjection              = "LambertConformal"
  res@lbLabelBarOn              = False             
  res@tiMainOn                  = False
  ;res@mpLambertParallel1F  = 18.
  ;res@mpLambertParallel2F  = 64.
  res@mpGeophysicalLineColor    = "gray60"
  ;res@mpGeophysicalLineColor    = "lightsalmon4"
      
      
  color=read_colormap_file("MPL_RdBu")
  ;color=read_colormap_file("MPL_BrBG")
  res@cnFillPalette             = color(::-1,:)       
  res@cnLevelSelectionMode      = "ManualLevels"   
  res@cnMinLevelValF            =  -24.0
  res@cnMaxLevelValF            =   24.0
  res@cnLevelSpacingF           =   4.
  res@cnOutOfRangeFillScaleF    =   2 
  res@cnInfoLabelOn             = False            
  res@cnLinesOn                 = False              
  res@cnLineLabelsOn            = False       

  res@mpMinLatF                 =  25. 
  res@mpMaxLatF                 =  70.
  res@mpMinLonF                 = -90
  res@mpMaxLonF                 =  30 
  ;res@mpLambertMeridianF = (res@mpMinLonF + res@mpMaxLonF)/2
  res@cnFillOn               = True                ; color plot 
  res@cnInfoLabelOrthogonalPosF  = -0.2        ; move info label up
  res@cnLineLabelFontHeightF     = .02
  res@gsnMaskLambertConformal    = True
    
  ;res@mpShapeMode  = "FreeAspect"
  ;res@vpWidthF      = 2.3
  ;res@vpHeightF     = 1.0
  ;res@txFontHeightF = 1.0

  res@tmXBLabelFontHeightF = 0.013           ; resize tick labels
  res@tmYLLabelFontHeightF = 0.013     
  res@tmYROn               = False
  res@tmXTOn               = False
  res@gsnLeftString   = " "              
  res@gsnRightString  = " "
  
;************************************************
; resource list for panel
;************************************************
  resP                         = True                
  resP@gsnMaximize             = True              
  resP@gsnPanelLabelBar        = True               
  resP@txFontHeightF           = 1.0
  resP@lbLabelFontHeightF      = 0.005
  resP@gsnPanelMainFontHeightF = 0.02        
  
  resP@lbTitleOn               =  True          
  resP@lbTitleString           = "[m s~S~-1~N~ day~S~-1~N~]"                 
  resP@lbTitlePosition         = "Right"              
  resP@lbTitleFontHeightF      = .014                
  resP@lbTitleDirection        = "Across"
  ;resP@lbLabelStride           = 2
  
  resP@gsnPanelYWhiteSpacePercent = 1.5
  resP@gsnPanelXWhiteSpacePercent = 1.5
  resP@lbTopMarginF               = 0.1
  resP@lbBoxEndCapStyle           = "TriangleBothEnds"
  resP@pmLabelBarWidthF           = 0.37
  resP@pmLabelBarHeightF      = 0.04
  resP@lbLabelFontHeightF         = 0.014
  resP@pmLabelBarOrthogonalPosF   = -0.012
  
;********************************************************
 
 print("plot color shading ...")
 
 res@txFont                     = "helvetica-bold"  
 res@gsnCenterStringFontHeightF = 0.02
 res@gsnRightStringFontHeightF  = 0.02
 res@gsnLeftStringFontHeightF   = 0.02
 
 res@gsnCenterString  = " ";(days -3)"
 res@gsnLeftString    = ""
 plot1(0)   = gsn_csm_contour_map(wks,x3,res)
 
 res@gsnCenterString  = " ";(days -2)"
 plot1(1)   = gsn_csm_contour_map(wks,x2,res)
 
 res@gsnCenterString  = " ";(days -1)"
 plot1(2)   = gsn_csm_contour_map(wks,x1,res)
 
 res@gsnCenterString  = " ";(days 0)"
 plot1(3)   = gsn_csm_contour_map(wks,x0,res)
 
;*******************************************************
 
  plot = new ( 4, "graphic")
  
  res1                           = True
  res1@gsnDraw                   = False          
  res1@gsnFrame                  = False           
  res1@gsnStringFontHeightF      = 0.02     

  res1@lbLabelBarOn              = False          
  res1@tiMainOn                  = False

  res1@cnSpanFillPalette         = False
  res1@cnFillPattern             = 17
  res1@cnFillDotSizeF            = 0.00025
  res1@cnFillColor               = "white"
 
  res1@cnInfoLabelOn             = False       
  res1@cnLinesOn                 = False       
  res1@cnLineLabelsOn            = False       

  res1@cnFillOn               = True    
  res1@cnInfoLabelOrthogonalPosF  = -0.2    
  res1@cnLineLabelFontHeightF     = .02

  res1@tmXBLabelFontHeightF = 0.02    
  res1@tmYLLabelFontHeightF = 0.02     
  res1@tmYROn               = False
  res1@tmXTOn               = False
  res1@gsnLeftString   = " "              
  res1@gsnRightString  = " "
;************************************************************
; Significant Test
;************************************************************

 nBoot      = 1000          
  stat       = 0             
  nDim       = 0             
  opt        = False 
  N          = 40
  n          = N
  if (isvar("n") .and. (n.lt.N)) then
      opt   = True
      opt@sample_size = n           ; default N
  end if
  
  bootstrap1 = bootstrap_stat(x3, stat, nBoot, nDim, opt)
  bootstrap2 = bootstrap_stat(x2, stat, nBoot, nDim, opt)
  bootstrap3 = bootstrap_stat(x1, stat, nBoot, nDim, opt)
  bootstrap4 = bootstrap_stat(x0, stat, nBoot, nDim, opt)
  
  xBoot1lat     = bootstrap1[0]
  xBoot2lat     = bootstrap2[0]
  xBoot3lat     = bootstrap3[0]
  xBoot4lat     = bootstrap4[0]
  
  xBoot1 = dim_avg_n_Wrap(xBoot1lat, 1)
  xBoot2 = dim_avg_n_Wrap(xBoot2lat, 1)
  xBoot3 = dim_avg_n_Wrap(xBoot3lat, 1)
  xBoot4 = dim_avg_n_Wrap(xBoot4lat, 1)
  
  delete(bootstrap1)
  delete(bootstrap2)
  delete(bootstrap3)
  delete(bootstrap4)

xBootLow1 = bootstrap_estimate(xBoot1, 0.005, False)
xBootLow2 = bootstrap_estimate(xBoot2, 0.005, False)
xBootLow3 = bootstrap_estimate(xBoot3, 0.005, False)
xBootLow4 = bootstrap_estimate(xBoot4, 0.005, False)

xBootHi1 = bootstrap_estimate(xBoot1, 0.995, False)
xBootHi2 = bootstrap_estimate(xBoot2, 0.995, False)
xBootHi3 = bootstrap_estimate(xBoot3, 0.995, False)
xBootHi4 = bootstrap_estimate(xBoot4, 0.995, False)

print(xBootLow1)

;************************************************
; stippling
;************************************************

print("strippling...")

 plot(0)   = gsn_csm_contour(wks,x3,res1)
 plot(1)   = gsn_csm_contour(wks,x2,res1)
 plot(2)   = gsn_csm_contour(wks,x1,res1)
 plot(3)   = gsn_csm_contour(wks,x0,res1)

  opt              = True
  opt@gsnShadeFillType = "pattern"
  ;opt@gsnShadeMid = 17 
  opt@gsnShadeLow  = 17
  opt@gsnShadeHigh = 17
  opt@gsnShadeFillScaleF = 1.25
  opt@gsnShadeFillDotSize = 0.0005
  
 plot(0) = gsn_contour_shade(plot(0),xBootLow1,xBootHi1,opt)
 plot(1) = gsn_contour_shade(plot(1),xBootLow2,xBootHi2,opt)
 plot(2) = gsn_contour_shade(plot(2),xBootLow3,xBootHi3,opt)
 plot(3) = gsn_contour_shade(plot(3),xBootLow4,xBootHi4,opt)

 overlay(plot1(0), plot(0))
 overlay(plot1(2), plot(2))
 overlay(plot1(1), plot(1))
 overlay(plot1(3), plot(3))
;*******************************************************
 
 print("plot contourline ...")
 
;************************************************
; Resource for Contour Line
;************************************************
  res2                      = True
  res2@gsnDraw              = False             
  res2@gsnFrame             = False
  res2@cnLevelSelectionMode = "ManualLevels"   
  res2@cnMinLevelValF       = -160.             
  res2@cnMaxLevelValF       =  160.           
  res2@cnLevelSpacingF      =  25.          
  res2@cnLineLabelsOn       = False
  res2@gsnContourZeroLineThicknessF = 0   
  res2@gsnContourNegLineDashPattern = 1
  res2@gsnContourLineThicknessesScale = 1.0
  res2@cnInfoLabelOn             = False
  
  res2@gsnLeftString   = " "              
  res2@gsnRightString  = " "
  
 plot2(0)   = gsn_csm_contour(wks,y3,res2)
 plot2(1)   = gsn_csm_contour(wks,y2,res2)
 plot2(2)   = gsn_csm_contour(wks,y1,res2)
 plot2(3)   = gsn_csm_contour(wks,y0,res2)
 
 overlay(plot1(0), plot2(0))
 overlay(plot1(1), plot2(1))
 overlay(plot1(2), plot2(2))
 overlay(plot1(3), plot2(3))

;********************************************************

 plot3 = new ( 4, "graphic")
  
  fres                           = True
  fres@vcFillArrowsOn            = True
  fres@gsnDraw                   = False             
  fres@gsnFrame                  = False 
  fres@vcMinDistanceF            = 0.035       
  fres@vcRefMagnitudeF           = 140.0    
  fres@vcRefLengthF              = 0.015
  ;fres@vcMinFracLengthF          = 0.2
  fres@vcLineArrowThicknessF     = 1.2
  fres@vcFillArrowEdgeColor      = "transparent"
  fres@vcGlyphStyle              = "FillArrow"
  fres@vcMinMagnitudeF           = 10.0 

  fres@vcRefAnnoOn               = False     
  fres@vcRefAnnoOrthogonalPosF   = -0.2  
  fres@vcRefAnnoArrowLineColor   = "black" 
  fres@vcRefAnnoArrowUseVecColor = False  
  fres@vcRefAnnoString2On        = False
  ;fres@vcRefAnnoPerimOn          = False
  
  fres@gsnLeftString   = " "              
  fres@gsnRightString  = " "
  plot3(0)    = gsn_csm_vector(wks,fx3,fy3,fres)
  plot3(1)    = gsn_csm_vector(wks,fx2,fy2,fres)
  plot3(2)    = gsn_csm_vector(wks,fx1,fy1,fres)
  
  fres@vcRefAnnoOn               = True 
  plot3(3)    = gsn_csm_vector(wks,fx0,fy0,fres)
  
  overlay(plot1(0), plot3(0))
  overlay(plot1(1), plot3(1))
  overlay(plot1(2), plot3(2))
  overlay(plot1(3), plot3(3))
  
;***********************************************************
 lat_spacing = 20  
 lon_spacing = 30
 
 minlat      =  25. 
 maxlat      =  70.
 minlon      =  -90.
 maxlon      =  30.
 
 ;add_lc_labels(wks,plot1(0),minlat,maxlat,minlon,maxlon,lat_spacing,lon_spacing)
 ;add_lc_labels(wks,plot1(1),minlat,maxlat,minlon,maxlon,lat_spacing,lon_spacing)
 ;add_lc_labels(wks,plot1(2),minlat,maxlat,minlon,maxlon,lat_spacing,lon_spacing)
 ;add_lc_labels(wks,plot1(3),minlat,maxlat,minlon,maxlon,lat_spacing,lon_spacing)
 
gsn_panel(wks,plot1,(/4,1/),resP)

 
print("Finished ...")
  
  
  
  
  
  
  
  
  
  
  
  
  
  

  
  
  
