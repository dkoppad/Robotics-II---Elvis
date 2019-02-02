#!/usr/bin/env python
import rospy
import screeninfo
import numpy as np
import cv2
from std_msgs.msg import Float32
from std_msgs.msg import String
from std_msgs.msg import Int32
from geometry_msgs.msg import Twist
msg=Twist()
import boto3
from pygame import mixer

mixer.init()

polly_client = boto3.Session(
        aws_access_key_id="AKIAIL3HNQSM7GQ5L6RA",                     
        aws_secret_access_key="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",
        region_name='us-west-2').client('polly')

def listener():

    # In ROS, nodes are uniquely named. If two nodes with the same
    # name are launched, the previous one is kicked off. The
    # anonymous=True flag means that rospy will choose a unique
    # name for our 'listener' node so that multiple listeners can
    # run simultaneously.
   
    rospy.init_node('y_coordinate', anonymous=True)

    rospy.Subscriber('coordinates', Float32, callback)

    # spin() simply keeps python from exiting until this node is stopped
    
    rospy.spin()

def callback(data):
    
    rospy.loginfo(rospy.get_caller_id() + "I heard %f", data.data)
    #pub=rospy.Publisher('turtle1/cmd_vel',Twist,queue_size=10)
    if(data.data>130):
        #msg.linear.x= (0.8)
        #print("Robot detected on right")
        response = polly_client.synthesize_speech(TextType= 'ssml', VoiceId='Ivy',
                OutputFormat='mp3', 
                Text = '<speak> Robot detected on right</speak>')

        file = open('right.mp3', 'w')
        file.write(response['AudioStream'].read())
        file.close()
        mixer.music.load('right.mp3')
        mixer.music.play()
       
        rospy.sleep(5)
        
    elif(data.data<130):
        #msg.linear.x= -(0.8)
        #print("Robot detected on left")
        response = polly_client.synthesize_speech(TextType= 'ssml', VoiceId='Ivy',
                OutputFormat='mp3', 
                Text = '<speak> Robot detected on left</speak>')

        file = open('left.mp3', 'w')
        file.write(response['AudioStream'].read())
        file.close()
        mixer.music.load('left.mp3')
        mixer.music.play()
        
        """
        cv2.imshow(window_name, image1)
        cv2.waitKey(0) 
        cv2.destroyAllWindows()
        """
        rospy.sleep(5)
        
    else:
        #msg.linear.x=0
        #print("Robot detected on front")
        response = polly_client.synthesize_speech(TextType= 'ssml', VoiceId='Ivy',
                OutputFormat='mp3', 
                Text = '<speak> Robot detected on front</speak>')

        file = open('front.mp3', 'w')
        file.write(response['AudioStream'].read())
        file.close()
        mixer.music.load('front.mp3')
        mixer.music.play()
        
        """
        cv2.imshow(window_name, image1)
        cv2.waitKey(0) 
        cv2.destroyAllWindows()
        """
        rospy.sleep(5)
    
    


if __name__ == '__main__':
    
    #initialize Global Variables
    screen_id = 0
    # get the size of the screen
    screen = screeninfo.get_monitors()[screen_id]
    width, height = screen.width, screen.height

    # create image
    
    image1 = cv2.imread('unamused.png', 1)
    window_name = 'projector'
    cv2.namedWindow(window_name, cv2.WND_PROP_FULLSCREEN)
    cv2.moveWindow(window_name, screen.x - 1, screen.y - 1)
    cv2.setWindowProperty(window_name, cv2.WND_PROP_FULLSCREEN,cv2.WINDOW_FULLSCREEN)
    cv2.imshow(window_name, image1)
    cv2.waitKey(0)
    listener()
    
