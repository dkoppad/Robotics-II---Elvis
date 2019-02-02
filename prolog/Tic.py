#!/usr/bin/env python
#
# Authors: Dhakshayini Koppad <dkoppad@pdx.edu>
#
# Date:
# Portland State University.
########################################################
import rospy
from std_msgs.msg import Int32, Float32
from std_msgs.msg import String
import time
import sys
from pyswip import *
import random

p = Prolog()
#create publishers
pubMotion_Command = rospy.Publisher('/pos',Float32)

#initialize the robot node
def position():
    
    pos = 0;
    
    for x in range(8)
        pos = random.randint(1,16)
        print("%d", pos)
        rate.sleep(10)
    #initilize the node
    rospy.init.node("prolog", ananymous=True)
    #set the publishing rate
    rate = rospy.Rate(10)

if __name__ == '__main__':
    print("Tic Tac Toe robot game position")

    try:
        position()
    except rospy.ROSInterruptException():
        pass
