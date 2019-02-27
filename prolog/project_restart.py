#!/usr/bin/env python
#
# Authors: Dhakshayini Koppad <dkoppad@pdx.edu>
#
#Tic Tac Toe game in python
# Date:
# Portland State University.
########################################################
#import rospy
#from std_msgs.msg import Int32, Float32, Float64
#from std_msgs.msg import String
#import time
#import sys
#import random
#from time import sleep

#create publishers
#comp = rospy.Publisher('/com_pos',Int32, queue_size=1)
#result = rospy.Publisher('/result',String, queue_size=1)
board = [' ' for x in range (17)]


def insertLetter(letter, pos):
    global board
    board[pos] = letter

def spaceIsFree(pos):
    return board[pos] == ' '

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


def playerMove():
    #rospy.Subscriber("/human_position", Range, callback0)
    run = True
    while run:
        move = input('please select your move pos from 1-16:  ')
        try:
            move = int(move)
            if move > 0 and move < 17:
                if spaceIsFree(move):
                    run = False
                    insertLetter('x', move)
                else:
                    print('Sorry Space Occupied!')
            else:
                print('Type a no. within range!')
        except:
            print('Please type a no.')
          
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

def playAgain():
    print('Do you want to play again? (yes or no)')
    return raw_input().lower().startswith('y')


def play():
    print('welcome to tic tac toe - You play First :)')
    printBoard(board)

    while not(isBoardFull(board)):
        if not(isWinner(board, 'o')):
            playerMove()
            printBoard(board)
        else:
            print ('I Win!!')
            break
          
        if not(isWinner(board, 'x')):
            pc_move = compMove()
            if pc_move == 0:
                print('Tie Game')
            #result.publish('Tie game')
            else:
                insertLetter('o', pc_move)
                printBoard(board)
        else:
            print ('you win!!')
            break

        

    if isBoardFull(board):
        #result.publish('Tie game')
        print('tie game')

if __name__ == '__main__':
    #initilize the node
    #rospy.init_node('AI_prolog', anonymous=True)
    play()

while True:
    if not(playAgain()):
        print("End of Game")
        break
    else:
        board = [' ' for x in range(17)]
        play()
