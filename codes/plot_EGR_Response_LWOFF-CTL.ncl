
begin
print("Reading file ...")

  f1 = addfile("../../for-Riski-Blocking-meanstate/LWOFF/LWOFF_EGR.mon.nc", "r")
  f2 = addfile("../../for-Riski-Blocking-meanstate/CTL/CTL_EGR.mon.nc", "r")
  
  pltDir  = "./"
  pltType = "pdf"          ; send graphics to PNG file
  pltName = "RESPONSE_EGR_LWOFF-CTL_DJF"
  
  time = f1->time
  date1 = cd_calendar(time, -1)
  iStrt = ind(date1.eq.190201)
  iLast = ind(date1.eq.191112)
  
  time1 = time(iStrt:iLast)
  date = cd_calendar(time1, 0)
  year = toint(date(:,0))
  month = toint(date(:,1))
  monWin = ind(month.eq.12 .or. month.le.2)
 
  m1 = f1->egr(monWin,:,:)
  m2 = f2->egr(monWin,:,:)
  
  x1 = dim_avg_n_Wrap(m1, 0)
  x2 = dim_avg_n_Wrap(m2, 0)
  x1 = lonFlip(x1)
  x2 = lonFlip(x2)
  x1 = x1 - x2
  
  wrf_smooth_2d(x1, 2)
  wrf_smooth_2d(x2, 2)
  
  avg1 = dim_avg_n_Wrap(m1, 0)
  avg2 = dim_avg_n_Wrap(m2, 0)
  var1 = dim_variance_n_Wrap(m1, 0)
  var2 = dim_variance_n_Wrap(m2, 0)
  num1 = dimsizes(f1->time)
  num2 = dimsizes(f2->time)
  
  printVarSummary(x1)
  printVarSummary(x2)
  
  printMinMax(x1, True)
  printMinMax(x2, True)
  ;exit
  
;************************************************************
; Plotting
;************************************************************

  pltPath = pltDir+pltName
  wks     = gsn_open_wks(pltType, pltPath)  
  plot = new ( 1, "graphic")
  plot1 = new ( 1, "graphic")
  
  res1                           = True
  res1@gsnDraw                   = False          
  res1@gsnFrame                  = False           
  res1@gsnStringFontHeightF      = 0.02     

  res1@lbLabelBarOn              = False          
  res1@tiMainOn                  = False

  res1@cnSpanFillPalette         = False
  res1@cnFillPattern             = 17
  res1@cnFillDotSizeF            = 0.0025
  res1@cnFillColor               = "black"
 
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

  
;*********************************************************************************************

  res                           = True
  res@gsnDraw                   = False             
  res@gsnFrame                  = False          
  res@gsnStringFontHeightF      = 0.02          
  
  res@lbLabelBarOn              = False             
  res@tiMainOn                  = False

  res@cnFillPalette             = "temp_19lev" ;"NCV_blu_red"     
  res@cnLevelSelectionMode = "ManualLevels"
  res@cnMinLevelValF            =   -.18
  res@cnMaxLevelValF            =   .18
  res@cnLevelSpacingF           =   0.02
  res@cnOutOfRangeFillScaleF    =   2 
  res@cnInfoLabelOn             = False         
  res@cnLinesOn                 = False            
  res@cnLineLabelsOn            = False          

  res@mpMinLatF                 =  20. 
  res@mpMaxLatF                 =  80.
  res@mpMinLonF                 = -100.
  res@mpMaxLonF                 = 30.
  res@mpCenterLonF             =  (res@mpMaxLonF + res@mpMinLonF)/2
  res@gsnMajorLonSpacing        =  30
  res@cnFillOn            	 = True         
  res@cnInfoLabelOrthogonalPosF  = -0.2        
  res@cnLineLabelFontHeightF     = .02        
  
  res@mpShapeMode  = "FreeAspect"
  res@vpWidthF      = 5.
  res@vpHeightF     = 2.5
  res@txFontHeightF = 1.0
  
  ;res@mpDataBaseVersion    = "LowRes"
  
  res@tmXBLabelFontHeightF = 0.12           
  res@tmYLLabelFontHeightF = 0.12      
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
  resP@gsnPanelMainFontHeightF = 0.02        
  
  resP@lbTitleOn               =  True          
  resP@lbTitleString           = "EGR [day~S~-1~N~]"                
  resP@lbTitlePosition         = "Right"              
  resP@lbTitleFontHeightF      = .018                
  resP@lbTitleDirection        = "Across"
  
  resP@lbLabelStride=3

  resP@gsnPanelYWhiteSpacePercent = 2.5
  resP@gsnPanelXWhiteSpacePercent = 2.5 
  resP@lbBoxEndCapStyle           = "TriangleBothEnds"
  resP@pmLabelBarWidthF           = 0.65
  resP@pmLabelBarHeightF   	  = 0.06
  resP@lbLabelFontHeightF         = 0.015
  resP@cnConstFLabelOrthogonalPosF= 0.5
  
;************************************
 res@txFont         = "helvetica-bold"
 res@gsnCenterStringFontHeightF = 0.15
 res@gsnRightStringFontHeightF  = 0.15
 res@gsnLeftStringFontHeightF   = 0.15
 res@gsnLeftString   = ""
 res@gsnCenterString   = "Cloud OFF LW - Control"
 plot1(0)   = gsn_csm_contour_map(wks,x1,res)
 res@gsnLeftString   = ""
 
;gsn_panel(wks,plot1,(/1,1/),resP)
;exit
;************************************************************
; Significant T-Test
;************************************************************
 ttest1 = ttest(avg1, var1, num1, avg2, var2, num2, 0, 0)
  print(num(ttest1.lt.0.05))
  ttest1!0 = "lat"
  ttest1!1 = "lon"
  ttest1&lat = x1&lat
  ttest1&lon = x1&lon
  
  x1 = where(ttest1.lt.0.05, x1, x1@_FillValue)
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
  opt@gsnShadeFillScaleF = 2.
  opt@gsnShadeFillDotSize = 0.0005
  
 ;plot(0) = gsn_contour_shade(plot(0),xBootLow1,xBootHi1,opt)
 plot(0) = gsn_contour_shade(plot(0),0.,0.,opt)

 overlay(plot1(0), plot(0))
 
 ;gsn_panel(wks,plot1,(/1,1/),resP)
 ;exit
print("Line...")
  
;************************************************
; Resource for Contour Line
;************************************************
  plot2 = new ( 1, "graphic")
  
  res2                      = True
  res2@gsnDraw              = False             
  res2@gsnFrame             = False
  res2@cnLevelSelectionMode = "ManualLevels"   
  res2@cnMinLevelValF       =  0.             
  res2@cnMaxLevelValF       =  5.           
  res2@cnLevelSpacingF      =  0.2          
  res2@cnLineLabelsOn       = False
  res2@gsnContourZeroLineThicknessF = 0 	
  res2@gsnContourNegLineDashPattern = 1
  res2@gsnContourLineThicknessesScale = 4.0
  res2@cnInfoLabelOn             = False
  res2@gsnLeftString    = ""
  res2@gsnRightString   = ""

  plot2(0)   = gsn_csm_contour(wks,x2,res2)
 
 overlay(plot1(0), plot2(0))
  
gsn_panel(wks,plot1,(/1,1/),resP)
 
print("Finished")
end
  
  
  
  
  
