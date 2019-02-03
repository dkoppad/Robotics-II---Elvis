#Phong Nguyen
#ECE478
#Assignment2 part2

#https://planetcalc.com/5788/

import cv2
import numpy as np
cap = cv2.VideoCapture(0)

global LB1,UB1
global LB2,UB2
global fourcc, out
global recording
LB1=np.array([20,20,35])
UB1=np.array([50,30,40])

LB2=np.array([20,20,35])
UB2=np.array([50,30,40])

kernelOpen=np.ones((5,5))
kernelClose=np.ones((20,20))


recording =0
fourcc = cv2.VideoWriter_fourcc(*'XVID')
out = cv2.VideoWriter('objectfinder.avi',fourcc, 20.0, (640,480))

while(True):
    # Take each frame
    
    ret, frame = cap.read()

    #resize img 600x480
    img=cv2.resize(frame,(640,480))

    #getting hsv img
    hsv1 = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
    hsv2 = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
    #declare firstColor and secondColor values
    firstColor=img
    secondColor=img
    result=img
    cv2.imshow('user_input',img)
    aftercrop=0

    #Cropping object 1 by pressing c
    while(cv2.waitKey(1) & 0xFF ==ord('c')):
        (x1,y1,w1,h1) = cv2.selectROI('user_input',img,False,False)
        if w1>0 or h1>0:
            firstColor=img[y1:y1+h1 , x1:x1+w1]
            cv2.imshow('cropped_1',firstColor)
            firstColor = cv2.cvtColor(firstColor,cv2.COLOR_BGR2HSV)
            #plug in HSV min and max values into numpy arrays
            print('first Color: min H = {}, min S = {}, min V = {}; max H = {}, max S = {}, max V = {}\n'.format(firstColor[:,:,0].min(), firstColor[:,:,1].min(), firstColor[:,:,2].min(), firstColor[:,:,0].max(), firstColor[:,:,1].max(), firstColor[:,:,2].max()))
            LB1=np.array([firstColor[:,:,0].min(),firstColor[:,:,1].min(),firstColor[:,:,2].min()])
            UB1=np.array([firstColor[:,:,0].max(),firstColor[:,:,1].max(),firstColor[:,:,2].max()])


    while(cv2.waitKey(1) & 0xFF ==ord('v')):
        (x2,y2,w2,h2) = cv2.selectROI('user_input',img,False,False)
        if w2>0 or h2>0:
            secondColor=img[y2:y2+h2 , x2:x2+w2]
            cv2.imshow('cropped_2',secondColor)
            aftercrop=1
            #convert cropped imgages to HSV
            secondColor = cv2.cvtColor(secondColor,cv2.COLOR_BGR2HSV)
            print('second Color: min H = {}, min S = {}, min V = {}; max H = {}, max S = {}, max V = {}\n'.format(secondColor[:,:,0].min(), secondColor[:,:,1].min(), secondColor[:,:,2].min(), secondColor[:,:,0].max(), secondColor[:,:,1].max(), secondColor[:,:,2].max()))
            LB2=np.array([secondColor[:,:,0].min(),secondColor[:,:,1].min(),secondColor[:,:,2].min()])
            UB2=np.array([secondColor[:,:,0].max(),secondColor[:,:,1].max(),secondColor[:,:,2].max()])

    mask1 = cv2.inRange(hsv1, LB1, UB1)
    mask2 = cv2.inRange(hsv2, LB2, UB2)
#    cv2.imshow("mask1",mask1)
#    cv2.imshow("mask2",mask2)
    k = cv2.waitKey(5) & 0xFF


    #morphology to reduce noice
    maskOpen1=cv2.morphologyEx(mask1,cv2.MORPH_OPEN,kernelOpen)
    maskClose1=cv2.morphologyEx(maskOpen1,cv2.MORPH_CLOSE,kernelClose)
    maskFinal1=maskClose1
    cv2.imshow("maskFinal1",maskFinal1)
    
    maskOpen2=cv2.morphologyEx(mask2,cv2.MORPH_OPEN,kernelOpen)
    maskClose2=cv2.morphologyEx(maskOpen2,cv2.MORPH_CLOSE,kernelClose)
    maskFinal2=maskClose2
    cv2.imshow("maskFinal2",maskFinal2)

    #CHAIN_APPROX_NONE Translates all the points from the chain code into points.
    img2,conts1,h3=cv2.findContours(maskFinal1.copy(),cv2.RETR_EXTERNAL,cv2.CHAIN_APPROX_NONE)

    img3,conts2,h4=cv2.findContours(maskFinal2.copy(),cv2.RETR_EXTERNAL,cv2.CHAIN_APPROX_NONE)

        #draw a rectangle around the object
    for i in range(len(conts1)):
        #boundingRect calculates the up-right bounding rectangle of a point set.
        x3,y3,w3,h3=cv2.boundingRect(conts1[i])
        cv2.rectangle(result,(x3,y3),(x3+w3,y3+h3),(255,0,0), 2)
        for l in range(len(conts2)):
        #boundingRect calculates the up-right bounding rectangle of a point set.
            x4,y4,w4,h4=cv2.boundingRect(conts2[l])
            cv2.rectangle(result,(x4,y4),(x4+w4,y4+h4),(0,255,0), 2)


    #if k is ESC stop
    if k == 27:
        break
    elif k== 114: #if k is r start record
        print("Video is recorded")
        recording =1
        
    if recording ==1:
        out.write(result)
        
    cv2.imshow('result',result)


cv2.destroyAllWindows()





