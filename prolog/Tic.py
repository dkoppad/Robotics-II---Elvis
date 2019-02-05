#!/usr/bin/env python
#
# Authors: Dhakshayini Koppad <dkoppad@pdx.edu>
#
# Date:
# Portland State University.
########################################################
import rospy
from std_msgs.msg import Int32, Float32, Float64
from std_msgs.msg import String
import time
import sys
#from pyswip import Prolog
import random
from time import sleep

#create publishers
pubPosition = rospy.Publisher('/pos',Float64, queue_size=1)

#initialize the robot node
def position():
    
    pos = 0;
    
    for x in range(8):
        pos = random.randint(1,16)
        print (pos)
        rospy.sleep(10)
    #initilize the node

#def main():
    #pro = Prolog()
    #prolog.consult("TicTacToe.pl")

if __name__ == '__main__':
    print("Tic Tac Toe robot game position")
    #initilize the node
    rospy.init_node('AI_prolog', anonymous=True)	
    try:
        position()
	#main()
	rate = rospy.Rate(10)

    except rospy.ROSInterruptException():
        pass
