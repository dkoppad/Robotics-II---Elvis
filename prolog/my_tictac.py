#!/usr/bin/env python
#
# Authors: Dhakshayini Koppad <dkoppad@pdx.edu>
#
#Tic Tac Toe game in python
# Date:
# Portland State University.
########################################################
#import pdb; pdb.set_trace()
import rospy
from std_msgs.msg import Float32, Float64, Int32
from std_msgs.msg import String
import time
import sys
import random
from time import sleep



#create publishers for ROS
comp = rospy.Publisher('/com_pos',Int32, queue_size=1)
result = rospy.Publisher('/result',Int32, queue_size=1)

player_move=0
player_move_flag=0
restart=0

#Function to restart the game. When called, resets the game to initial position
def callback_restart(data):
    global restart
    restart=1
    rospy.loginfo("restarting or start the game")


#Function to check if the input no is an integer. If its not an 
#integer the function will return an exception( this part of code is
# optional as we are using a camera to capture the user input position).
# In the case if the user was inputing the value via keyboard, he can 
#enter ASCI charecter like a, z 1, 4 etc and this function would return 
# false in case any other value apart from no is entered.
def is_number(var):
    try:
        if var == int(var):
            return True
    except Exception:
        return False
# Callback functions for the ROS listner nodes.

def callback0_f():
    global player_move, player_move_flag
    move = player_move
    if player_move_flag ==1 and is_number(move):
        return move
    if player_move_flag ==0:
        return -1

def callback0(data):
    global player_move,player_move_flag
    buff=player_move
    player_move = data.data
    #rospy.loginfo(data)
    if buff!=player_move and player_move>0:
        player_move_flag = 1
    else:
        player_move_flag = 0

 # intializing the board. Since there are 16 possible positions considering range upto 17

board = [' ' for x in range (17)]

# Function to display the letter 'o' & 'x' on the display so the user can visually see it on the PC screen
def insertLetter(letter, pos):
    global board
    board[pos] = letter

#Function to check if there is any free space on the board. If there is no free space there are no possible moves	
	
def spaceIsFree(pos):
    return board[pos] == ' '


#This function displays the board status after every move
def printBoard(board):
    print('----------------')
    print(' ' + board[1]+ ' | '+ board[2]+ ' | ' + board[3]+ ' | '+ board[4])
    print('----------------')
    print(' ' + board[5]+ ' | '+ board[6] +' | '+ board[7]+ ' | ' + board[8])
    print('----------------')
    print(' ' + board[9]+ ' | '+ board[10]+ ' | '+ board[11] +' | ' + board[12])
    print('----------------')
    print(' ' + board[13]+ ' | '+ board[14]+ ' | '+ board[15] +' | '+ board[16])
    print('----------------')

# this function checks if there is a winner or there can be any possible winners in the next move.
# PC uses this information to see if there is a winning move for itself. If present then 
# it makes the move and game ends. If there is a winning move for the user then the PC
# blocks the winning move

def isWinner(board, le):
    return ((board[1] == le and board[2] == le and board[3] == le and board[4] == le) or
    (board[5] == le and board[6] == le and board[7] == le and board[8] == le) or
    (board[9] == le and board[10] == le and board[11] == le and board[12] == le) or
    (board[13] == le and board[14] == le and board[15] == le and board[16] == le) or
    (board[1] == le and board[5] == le and board[9] == le and board[13] == le) or
    (board[2] == le and board[6] == le and board[10] == le and board[14] == le) or
    (board[3] == le and board[7] == le and board[11] == le and board[15] == le) or
    (board[4] == le and board[8] == le and board[12] == le and board[16] == le) or
    (board[1] == le and board[6] == le and board[11] == le and board[16] == le) or
    (board[4] == le and board[7] == le and board[10] == le and board[13] == le))

# function to input the user move
def playerMove():
    global player_move, player_move_flag, restart
    move_temp=0
    run = True
    while run:
        #move_temp = input('please select your move pos from 1-16:  ')
        move=callback0_f()
	if is_number(move):
        	move_temp=int(move)

        if move_temp!=-1:
                player_move_flag=0
                #rospy.loginfo(move_temp)
	
	        if move_temp > 0 and move_temp < 17:
	            if spaceIsFree(move_temp):
		        run = False
		        insertLetter('x', move_temp)
                    else:
			pass
                        #print('Sorry Space Occupied!')
                else:
                    print('Type a no. within range!')
# function to check all the possible moves of the PC and deciding on the best move          
def compMove():
    possibleMoves = [x for x, letter in enumerate(board) if letter == ' ' and x != 0]  ##for all the indices and the value of the cells, we have a empty soace and not the zeroth position.
    pc_move = 0
    
    for let in ['o', 'x']:
        for i in possibleMoves:
            boardCopy = board[:]
            boardCopy[i] = let
            if isWinner(boardCopy, let):
                pc_move = i
                return pc_move
          
    cornerOpen = []
    for i in possibleMoves:
        if i in [1,4,13,16]:
            cornerOpen.append(i)

    if len(cornerOpen) > 0:
        pc_move = selectRandom(cornerOpen)
        return pc_move
        
          
    centerOpen = []
    for i in possibleMoves:
        if i in [6,10,7,11]:
            centerOpen.append(i)

    if len(centerOpen) > 0:
        pc_move = selectRandom(centerOpen)
        return pc_move
        
    edgesOpen = []
    for i in possibleMoves:
        if i in [5,9,2,3,8,12,14,15]:
            edgesOpen.append(i)

    if len(edgesOpen) > 0:
        pc_move = selectRandom(edgesOpen)
        return pc_move

#if there are no winning moves then a random no is generated              

def selectRandom(li):
    import random
    ln = len(li)
    r = random.randrange(0,ln)
    return li[r]


def isBoardFull(board):
    if board.count(' ') > 1:
        return False
    else:
        return True

# main part of the code seequence
def play():
    global restart
    print('welcome to tic tac toe - You play First :)')
    printBoard(board)
    
    while not(isBoardFull(board)):
        if not(isWinner(board, 'o')):
            playerMove()
            printBoard(board)
        else:
            print ('I Win!!')
            result_top=1
            result.publish(result_top)
            break
          
        if not(isWinner(board, 'x')):
            pc_move = compMove()
            comp.publish(pc_move)
            if pc_move == 0:
                print('Tie Game')
                result_top=3
                result.publish(result_top)
            else:
                insertLetter('o', pc_move)
                printBoard(board)
        else:
            print ('you win!!')
            result_top=2
            result.publish(result_top)
            break

    if isBoardFull(board):
        result_top=3
        result.publish(result_top)
        print('tie game')

if __name__ == '__main__':
    #initilize the node
    rospy.init_node('AI_prolog', anonymous=False)
    rospy.Subscriber("/human_position", Int32, callback0)
    #rospy.Subscriber("/restart",Int32,callback_restart)
    play()

while True:
    if restart==0:
        print("End of Game")
    else:
	restart=0
        board = [' ' for x in range(17)]
        play()
