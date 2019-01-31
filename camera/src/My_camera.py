#!/usr/bin/env python
# BEGIN ALL

#camera source package in github
#https://github.com/orbbec/ros_astra_camera


#RUN THIS ROSLAUNCH FIRST
#roslaunch astra_launch astra.launch
import rospy
from std_msgs.msg import String
from sensor_msgs.msg import Image
import cv2, cv_bridge
from time import sleep


class face_rec:


	def __init__(self):
		self.bridge = cv_bridge.CvBridge()
		self.image_sub = rospy.Subscriber('camera/rgb/image_raw',Image, self.image_callback)

	def image_callback(self, msg):
		rate = rospy.Rate(10) # 10hz
		image = self.bridge.imgmsg_to_cv2(msg,"bgr8")
		cv2.imshow('afterimg',image)
		cv2.waitKey(3)


rospy.init_node('My_camera')
Face_rec = face_rec()
rospy.spin()
# END ALL
