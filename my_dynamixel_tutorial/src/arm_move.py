#!/usr/bin/env python
import rospy
from std_msgs.msg import String, Int32, Float64
from geometry_msgs.msg import Twist
from math import radians
from time import sleep
arm1 = rospy.Publisher('/tilt_controller1/command', Float64, queue_size=1)
arm2 = rospy.Publisher('/tilt_controller2/command', Float64, queue_size=1)
arm3 = rospy.Publisher('/tilt_controller3/command', Float64, queue_size=1)
arm4 = rospy.Publisher('/tilt_controller4/command', Float64, queue_size=1)
arm5 = rospy.Publisher('/tilt_controller5/command', Float64, queue_size=1)




def pos(number):
	if number==0:
		arm1_pos=2.6
		arm2_pos=2.5
		arm3_pos=2
		arm4_pos=3
	if number==1:
		arm1_pos=3
		arm2_pos=0.97
		arm3_pos=2.6
		arm4_pos=2.57
	if number==2:
		arm1_pos=2.75
		arm2_pos=0.97
		arm3_pos=2.6
		arm4_pos=2.57
	if number==3:
		arm1_pos=2.53
		arm2_pos=0.97
		arm3_pos=2.6
		arm4_pos=2.57
	if number==4:
		arm1_pos=2.28
		arm2_pos=0.97
		arm3_pos=2.6
		arm4_pos=2.57
	if number==5:
		arm1_pos=3.1
		arm2_pos=1.45
		arm3_pos=2.5
		arm4_pos=1.3
	if number==6:
		arm1_pos=2.8
		arm2_pos=1.5
		arm3_pos=2.5
		arm4_pos=0.95
	if number==7:
		arm1_pos=2.45
		arm2_pos=1.5
		arm3_pos=2.5
		arm4_pos=0.95
	if number==8:
		arm1_pos=2.15
		arm2_pos=1.45
		arm3_pos=2.5
		arm4_pos=1.2
	if number==9:
		arm1_pos=3.29
		arm2_pos=1.9
		arm3_pos=1.8
		arm4_pos=1.1
	if number==10:
		arm1_pos=2.85
		arm2_pos=2.3
		arm3_pos=1.3
		arm4_pos=1.2
	if number==11:
		arm1_pos=2.4
		arm2_pos=2.3
		arm3_pos=1.3
		arm4_pos=1.2
	if number==12:
		arm1_pos=2
		arm2_pos=1.9
		arm3_pos=1.8
		arm4_pos=1.1
	if number==13:
		arm1_pos=3.6
		arm2_pos=2.5
		arm3_pos=1
		arm4_pos=1.3
	if number==14:
		arm1_pos=3.1
		arm2_pos=3.24
		arm3_pos=0.7
		arm4_pos=1.22
	if number==15:
		arm1_pos=2.2
		arm2_pos=3.24
		arm3_pos=0.7
		arm4_pos=1.22
	if number==16:
		arm1_pos=1.6
		arm2_pos=2.5
		arm3_pos=1
		arm4_pos=1.3



	
	
	#movement here
	arm2.publish(arm2_pos)
	arm3.publish(arm3_pos)
	arm4.publish(arm4_pos)
	if number==0:
		rospy.sleep(1)

	arm1.publish(arm1_pos)
	rospy.sleep(3)

	
rospy.init_node('arm_move',anonymous=True)
#pos(0)
#pos(9)

for i in range(1,17):
	pos(0)
	pos(i)

