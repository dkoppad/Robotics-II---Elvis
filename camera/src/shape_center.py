# -*- coding: utf-8 -*-
"""
Created on Thu Jan 26 22:47:34 2019

@author: Rakhee
"""

import cv2
import numpy as np

cap = cv2.VideoCapture('white.mp4')

while(True):
    _, bgr_image = cap.read()
    
    #bgr_image = cv2.imread('white.png', 1)
    hsv_image = cv2.cvtColor(bgr_image, cv2.COLOR_BGR2HSV)
    
    # convert the images from bgr to hsv
    #hsv_image = cv2.cvtColor(bgr_image, cv2.COLOR_BGR2HSV)
    upper_green_range0 = np.array([50,50,50], dtype = "uint8")
    upper_green_range1 = np.array([70,255,255], dtype = "uint8")
    mask4 = cv2.inRange(hsv_image,  upper_green_range0 ,upper_green_range1)

    result = cv2.bitwise_and(bgr_image, bgr_image, mask = mask4)
    gray = cv2.cvtColor(result, cv2.COLOR_BGR2GRAY)
    blurred = cv2.GaussianBlur(gray, (5, 5), 0)
    thresh = cv2.threshold(blurred,25 , 255, cv2.THRESH_BINARY)[1]

    #print("Input Image Shape is %d, %d" %(bgr_image.shape[0], bgr_image.shape[1]))

    x_start = 0
    y_start = 0
    y_end = bgr_image.shape[0]
    x_end = bgr_image.shape[1]
    x_stride = x_end/6
    y_stride = y_end/6

    x1 = x_start + x_stride
    x2 = x1 + x_stride
    x3 = x2 + x_stride
    x4 = x3 + x_stride
    x5 = x4 + x_stride

    y1 = y_start + y_stride
    y2 = y1 + y_stride
    y3 = y2 + y_stride
    y4 = y3 + y_stride
    y5 = y4 + y_stride

    #print(int(x_stride), int(y_stride))
    # Tic Tac Toe Board Construction
    cv2.line(bgr_image,(int(x1),0),(int(x1),y_end),(0,0,0),1)
    cv2.line(bgr_image,(int(x2),0),(int(x2),y_end),(0,0,0),1)
    cv2.line(bgr_image,(int(x3),0),(int(x3),y_end),(0,0,0),1)
    cv2.line(bgr_image,(int(x4),0),(int(x4),y_end),(0,0,0),1)
    cv2.line(bgr_image,(int(x5),0),(int(x5),y_end),(0,0,0),1)

    cv2.line(bgr_image,(int(x2),0),(int(x3),int(y1)),(0,0,0),2)
    cv2.line(bgr_image,(int(x3),0),(int(x4),int(y1)),(0,0,0),2)
    cv2.line(bgr_image,(int(x3),0),(int(x2),int(y1)),(0,0,0),2)
    cv2.line(bgr_image,(int(x4),0),(int(x3),int(y1)),(0,0,0),2)

    cv2.line(bgr_image,(int(x2),int(y5)),(int(x3),int(y_end)),(0,0,0),2)
    cv2.line(bgr_image,(int(x3),int(y5)),(int(x4),int(y_end)),(0,0,0),2)
    cv2.line(bgr_image,(int(x3),int(y5)),(int(x2),int(y_end)),(0,0,0),2)
    cv2.line(bgr_image,(int(x4),int(y5)),(int(x3),int(y_end)),(0,0,0),2)

    cv2.line(bgr_image,(0,int(y1)),(x_end, int(y1)),(0,0,0),1)
    cv2.line(bgr_image,(0,int(y2)),(x_end, int(y2)),(0,0,0),1)
    cv2.line(bgr_image,(0,int(y3)),(x_end, int(y3)),(0,0,0),1)
    cv2.line(bgr_image,(0,int(y4)),(x_end, int(y4)),(0,0,0),1)
    cv2.line(bgr_image,(0,int(y5)),(x_end, int(y5)),(0,0,0),1)

    cv2.putText(bgr_image, "8", (int(x_end-x_stride/2),int(y5-y5-y_stride/2)),cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 0), 1)
    cv2.putText(bgr_image, "7", (int(x_end-x_stride/2),int(y5-y_stride/2)),cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 0), 1)
    cv2.putText(bgr_image, "6", (int(x_end-x_stride/2),int(y_end-y_stride/2)),cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 0), 1)
    cv2.putText(bgr_image, "5", (int(x5-x_stride/2),int(y_end-y_stride/2)),cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 0), 1)
    cv2.putText(bgr_image, "4", (int(x1-x_stride/2),int(y4-y_stride/2)),cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 0), 1)
    cv2.putText(bgr_image, "3", (int(x1-x_stride/2),int(y5-y_stride/2)),cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 0), 1)
    cv2.putText(bgr_image, "2", (int(x1-x_stride/2),int(y_end-y_stride/2)),cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 0), 1)
    cv2.putText(bgr_image, "1", (int(x2-x_stride/2),int(y_end-y_stride/2)),cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 0), 1)

    #print(int(x_start), int(x1), int(x2), int(x3), int(x4), int(x5), int(x_end))
    #print(int(y_start), int(y1), int(y2), int(y3), int(y4), int(y5), int(y_end))

    _, contours, _ = cv2.findContours(thresh, cv2.RETR_CCOMP, cv2.CHAIN_APPROX_TC89_L1)

    #print("Number of green blocks found is %d" %len(contours))
    centres = []
    blocks_to_pick = []

    for i in range(len(contours)):
        if cv2.contourArea(contours[i]) < 100:
            print("smaller contour or bigger contour")
            continue
        else:
       
            moments = cv2.moments(contours[i])
            cX = int(moments["m10"] / moments["m00"])
            cY = int(moments["m01"] / moments["m00"])
            if cX < x1:
                if cY < y1:
                    block7 = 7
                    print("Contour area for block 7 %f" %(cv2.contourArea(contours[i])))
                    centres.append((int(moments['m10']/moments['m00']), int(moments['m01']/moments['m00'])))
                    cv2.circle(bgr_image, (cX, cY), 1, (0, 0, 0), -1)
                    print("Pick from Block 7")
                    blocks_to_pick.append(block7)
           
                elif y1 <cY < y2:
                    block6 = 6
                    print("Contour area for block 6 %f" %(cv2.contourArea(contours[i])))
                    centres.append((int(moments['m10']/moments['m00']), int(moments['m01']/moments['m00'])))
                    cv2.circle(bgr_image, (cX, cY), 1, (0, 0, 0), -1)
                    print("Pick from Block 6")
                    blocks_to_pick.append(block6)
                
                elif y2 <cY < y3:
                    block5 = 5
                    print("Contour area for block 5 %f" %(cv2.contourArea(contours[i])))
                    centres.append((int(moments['m10']/moments['m00']), int(moments['m01']/moments['m00'])))
                    cv2.circle(bgr_image, (cX, cY), 1, (0, 0, 0), -1)
                    print("Pick from Block 5")
                    blocks_to_pick.append(block5)
                
                elif y3 <cY < y4:
                    block4 = 4
                    print("Contour area for block 4 %f" %(cv2.contourArea(contours[i])))
                    centres.append((int(moments['m10']/moments['m00']), int(moments['m01']/moments['m00'])))
                    cv2.circle(bgr_image, (cX, cY), 1, (0, 0, 0), -1)
                    print("Pick from Block 4")
                    blocks_to_pick.append(block4)
                
                elif y4 <cY < y5:
                    block3 = 3
                    print("Contour area for block 3 %f" %(cv2.contourArea(contours[i])))
                    centres.append((int(moments['m10']/moments['m00']), int(moments['m01']/moments['m00'])))
                    cv2.circle(bgr_image, (cX, cY), 1, (0, 0, 0), -1)
                    print("Pick from Block 3")
                    blocks_to_pick.append(block3)
                
                elif y5 <cY < y_end:
                    block2 = 2
                    print("Contour area for block 2 %f" %(cv2.contourArea(contours[i])))
                    centres.append((int(moments['m10']/moments['m00']), int(moments['m01']/moments['m00'])))
                    cv2.circle(bgr_image, (cX, cY), 1, (0, 0, 0), -1)
                    print("Pick from Block 2")
                    blocks_to_pick.append(block2)
            elif x1< cX < x2:
                    if cY < y1:
                        block8 = 8
                        print("Contour area for block 8 %f" %(cv2.contourArea(contours[i])))
                        centres.append((int(moments['m10']/moments['m00']), int(moments['m01']/moments['m00'])))
                        cv2.circle(bgr_image, (cX, cY), 1, (0, 0, 0), -1)
                        print("Pick from Block 8")
                        blocks_to_pick.append(block8)
                    
                    if  y5 < cY < y_end:
                        block1 = 1
                        print("Contour area for block 1 %f" %(cv2.contourArea(contours[i])))
                        centres.append((int(moments['m10']/moments['m00']), int(moments['m01']/moments['m00'])))
                        cv2.circle(bgr_image, (cX, cY), 1, (0, 0, 0), -1)
                        print("Pick from Block 1")
                        blocks_to_pick.append(block1)
                    
       
    print(centres)
    print("Blocks to pick" ,blocks_to_pick)

    cv2.imshow('image', bgr_image)
    cv2.imwrite('output.png',bgr_image)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break
    
# When everything done, release the capture
cap.release()
cv2.destroyAllWindows()
