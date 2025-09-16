
load"./lat-lon_labels.ncl"
begin
print("Reading File ...")

  f1 = addfile("../../NatComm_CRE_Bocking_Lubis/Figure4/CLOCK/lwa.tend.lag-3to-1.nc", "r")
  
  g1 = addfile("../../NatComm_CRE_Bocking_Lubis/Figure4/CLOCK/z500.anom.lag-3to-1.nc", "r")
  
  
 x1 = f1->lwa_tend
 
 y1 = g1->z500_anom
 
 g1x = addfile("../../NatComm_CRE_Bocking_Lubis/Figure4/CLOCK/fx.lag-3to-1.nc", "r")
 g1y = addfile("../../NatComm_CRE_Bocking_Lubis/Figure4/CLOCK/fy.lag-3to-1.nc", "r")
 
 fx1 = g1x->fx
 
 fy1 = g1y->fy
 
;************************************************************
; OUTPUT
;************************************************************
  pltDir  = "./"
  pltType = "pdf"          
  pltName = "clock_lwa_TEND_DAYS-3to-1-SL1"
  ;exit

;************************************************************
; PLOT
;************************************************************

  print("let's plot ...")
  
  pltPath = pltDir+pltName
  wks     = gsn_open_wks(pltType, pltPath)  
  plot1 = new(1, "graphic")
  plot2 = new(1, "graphic")
  
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
      
color=read_colormap_file("MPL_RdBu")
  ;color=read_colormap_file("MPL_BrBG")
  res@cnFillPalette             = color(::-1,:)    
  res@cnLevelSelectionMode      = "ManualLevels"   
  res@cnMinLevelValF            =  -6.0
  res@cnMaxLevelValF            =   6.0
  res@cnLevelSpacingF           =   1.
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
  res@txFontHeightF = 1.0

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
 
 res@gsnCenterString  = "(days -3 to -1)"
 res@gsnLeftString    = ""
 plot1(0)   = gsn_csm_contour_map(wks,x1,res)
 
;*******************************************************
 
  plot = new ( 1, "graphic")
  
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
  
  bootstrap1 = bootstrap_stat(x1, stat, nBoot, nDim, opt)
  
  xBoot1lat     = bootstrap1[0]
  
  xBoot1 = dim_avg_n_Wrap(xBoot1lat, 1)
  
  delete(bootstrap1)

xBootLow1 = bootstrap_estimate(xBoot1, 0.005, False)

xBootHi1 = bootstrap_estimate(xBoot1, 0.995, False)

print(xBootLow1)

;************************************************
; stippling
;************************************************

print("strippling...")

 plot(0)   = gsn_csm_contour(wks,x1,res1)

  opt              = True
  opt@gsnShadeFillType = "pattern"
  ;opt@gsnShadeMid = 17 
  opt@gsnShadeLow  = 17
  opt@gsnShadeHigh = 17
  opt@gsnShadeFillScaleF = 1.
  opt@gsnShadeFillDotSize = 0.005
  
 plot(0) = gsn_contour_shade(plot(0),xBootLow1,xBootHi1,opt)

 overlay(plot1(0), plot(0))

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
  
 plot2(0)   = gsn_csm_contour(wks,y1,res2)
 
 overlay(plot1(0), plot2(0))

;********************************************************

 plot3 = new ( 1, "graphic")
  
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
  fres@vcRefAnnoOrthogonalPosF   = -1.0  
  fres@vcRefAnnoArrowLineColor   = "black" 
  fres@vcRefAnnoArrowUseVecColor = False  
  fres@vcRefAnnoString2On        = False
  fres@vcRefAnnoPerimOn          = False
  
  fres@gsnLeftString   = " "              
  fres@gsnRightString  = " "
  plot3(0)    = gsn_csm_vector(wks,fx1,fy1,fres)
  
  overlay(plot1(0), plot3(0))
  
  res_lines                   = True                  
  res_lines@gsLineDashPattern = 0.                   
  res_lines@gsLineThicknessF  = 6.                   
  res_lines@gsLineColor       = "red3"
  ypl1 = (/ 65.0, 65.0, 40.0, 40.0, 65.0/)
  xpl1 = (/-60.0, -15.0, -15.0, -60.0,-60.0/)
  ;plo1 = gsn_add_polyline(wks,plot1,xpl1,ypl1,res_lines)
  
  res_lines@gsLineColor       = "black"
  ypts2 = (/ 60.0, 60.0, 35.0, 35.0, 60.0/) 
  xpts2 = (/5.0, -20.0, -20.0, 5.0,5.0/)
  ;plo2 = gsn_add_polyline(wks,plot1,xpts2,ypts2,res_lines)
  
;***********************************************************
 lat_spacing = 20  
 lon_spacing = 30
 
 minlat      =  25. 
 maxlat      =  70.
 minlon      =  -90.
 maxlon      =  30.
 
 ;add_lc_labels(wks,plot1(0),minlat,maxlat,minlon,maxlon,lat_spacing,lon_spacing)
 
gsn_panel(wks,plot1,(/4,1/),resP)

 
print("Finished ...")
end 
  
  
  
  
  
  
  
  
  
  
  
  
  

