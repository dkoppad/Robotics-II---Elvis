% Hamed Mirlohi
% ECE 510
% 4x4 Tic-Tac-Toe

use_module(library(random)).

% WRITE OUT THE GAME INTRO AND PASS ON THE BOARD AND WINNING BOARD OF OPPONENT.
start :- write('Do you want to go first?   1.Yes    2.No'),nl,read(N),nl,nl,  ((1 == N -> (startUp,strtPlayer([a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a],[b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b]))) ; (2 == N -> (startUp,strtComputer([a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a],[b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b])))).

startUp :- write('ECE 510 Prolog Project'),nl,write('Developed by Hamed Mirlohi'),
nl,
nl,
nl,
write('Enter position number followed by a period: '),
nl,
nl,
display([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]).

% DISPLAYING PLAYING BOARD
display([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P]) :-
write('|'),
write([A,B,C,D]),
write('|              |'),write([1,2,3,4]),write('|'),
nl,
write('|'),
write([E,F,G,H]),
write('|              |'),write([5,6,7,8]),write('|'),
nl,
write('|'),
write([I,J,K,L]),
write('|              |'),write([9,10,11,12]),write('|'),
nl,
write('|'),
write([M,N,O,P]),
write('|              |'),write([13,14,15,16]),write('|'),
nl,
nl,
nl.

% FOR DEBUGGING PURPOSES, YOU CAN OBSERVE THE WINNING BOARD.
displayWinBoard([B1,B2,B3,B4,B5,B6,B7,B8,B9,B10,B11,B12,B13,B14,B15,B16,B17,B18,B19,B20,B21,B22,B23,B24,B25,B26,B27,B28,B29,B30,B31,B32,B33,B34,B35,B36,B37,B38,B39,B40,B41,B42,B43,B44]) :-
write('|'),
write([B1,B2,B3,B4,B5,B6,B7,B8,B9,B10,B11,B12,B13,B14,B15,B16,B17,B18,B19,B20,B21,B22,B23,B24,B25,B26,B27,B28,B29,B30,B31,B32,B33,B34,B35,B36,B37,B38,B39,B40,B41,B42,B43,B44]),
nl.

% CHECK IF BOARD IS FULL, IF SO CALCULATE SCORE AND DETERMINE THE WINNER
strtPlayer(Board, _) :- not(boardNotFull(Board)),
write('       SCORE REPORT: '),
nl,
nl,
calculateScore(Board, FinalPlayerScore, x, o),
calculateScore(Board, FinalOpponentScore, o, x),
write('Final Player Score: '),
write(FinalPlayerScore),
nl,
write('Final Opponent Score: '),
write(FinalOpponentScore),
nl,
declareWinner(FinalPlayerScore,FinalOpponentScore).


% READ A NUMBER FROM USER, PUTTING A 'x' ON BOARD, DISPLAYING THE UPDATED BOARD,COMPUTER MAKES A MOVE, UPDATEDS THE BOARD AND PASS THE UPDATED BOARDS TO strt AGAIN.

strtPlayer(Board,WinBoard) :- read(N),
playerMove(Board, N, NewBoard),display(NewBoard),
(computerPlay(NewBoard, NewNewBoard, WinBoard, WinWinBoard),(display(NewNewBoard),nl,strtPlayer(NewNewBoard,WinWinBoard))  ; ((computerPlay(NewBoard,NewNewBoard)),display(NewNewBoard),nl,strtPlayer(NewNewBoard,WinBoard))).


strtComputer(Board, _) :- not(boardNotFull(Board)),
write('       SCORE REPORT: '),
nl,
nl,
calculateScore(Board, FinalPlayerScore, x, o),
calculateScore(Board, FinalOpponentScore, o, x),
write('Final Player Score: '),
write(FinalPlayerScore),
nl,
write('Final Opponent Score: '),
write(FinalOpponentScore),
nl,
declareWinner(FinalPlayerScore,FinalOpponentScore).

strtComputer(Board,WinBoard) :- (computerPlay(Board, NewBoard, WinBoard, WinWinBoard),display(NewBoard),read(N),playerMove(NewBoard, N, NewNewBoard),display(NewNewBoard),strtComputer(NewNewBoard,WinWinBoard))  ;
(computerPlay(Board,NewBoard),display(NewBoard),read(N),playerMove(NewBoard, N, NewNewBoard),display(NewNewBoard),strtComputer(NewNewBoard,WinBoard)).


% COMPARING SCORES TO DETERMINE THE WINNER.
declareWinner(FinalPlayerScore, FinalOpponentScore) :- (FinalPlayerScore == FinalOpponentScore -> (nl,write('DRAW GAME !'),nl)).
declareWinner(FinalPlayerScore, FinalOpponentScore) :- (FinalPlayerScore > FinalOpponentScore -> (nl,write('PLAYER WINS !!'),nl);(write('COMPUTER WINS.'),nl)).

% CALCULATE SCORES FOR EACH ROW, COLUMN AND CROSSES
calculateScore(Board, FinalScore, Player, Opponent) :-
(row1Score(Player,Opponent,Board,Score1);row1Score(Player,Board,Score1);row1Score(Board,Score1)),
(row2Score(Player,Opponent,Board,Score2);row2Score(Player,Board,Score2);row2Score(Board,Score2)),
(row3Score(Player,Opponent,Board,Score3);row3Score(Player,Board,Score3);row3Score(Board,Score3)),
(row4Score(Player,Opponent,Board,Score4);row4Score(Player,Board,Score4);row4Score(Board,Score4)),
(column1Score(Player,Opponent,Board,Score5);column1Score(Player,Board,Score5);column1Score(Board,Score5)),
(column2Score(Player,Opponent,Board,Score6);column2Score(Player,Board,Score6);column2Score(Board,Score6)),
(column3Score(Player,Opponent,Board,Score7);column3Score(Player,Board,Score7);column3Score(Board,Score7)),
(column4Score(Player,Opponent,Board,Score8);column4Score(Player,Board,Score8);column4Score(Board,Score8)),
(diagonal1Score(Player,Opponent,Board,Score9);diagonal1Score(Player,Board,Score9);diagonal1Score(Board,Score9)),
(diagonal2Score(Player,Opponent,Board,Score10);diagonal2Score(Player,Board,Score10);diagonal2Score(Board,Score10)),
write('FirstRow: '),
write(Score1),
nl,
write('SecondRow: '),
write(Score2),
nl,
write('ThirdRow: '),
write(Score3),
nl,
write('FourthRow: '),
write(Score4),
nl,
nl,
write('FirstColumn: '),
write(Score5),
nl,
write('SecondColumn: '),
write(Score6),
nl,
write('ThirdColumn: '),
write(Score7),
nl,
write('FourthColumn: '),
write(Score8),
nl,
nl,
write('FirstDiagonal: '),
write(Score9),
nl,
write('SecondDiagonal: '),
write(Score10),
nl,
nl,
FinalScore is Score1+Score2+Score3+Score4+Score5+Score6+Score7+Score8+Score9+Score10.


row1WinCondition1(Board, Player, WinBoard, WinWinBoard) :- Board = [Player,Player,Player,_,_,_,_,_,_,_,_,_,_,_,_,_],updateWinBoard1(WinBoard,WinWinBoard).
row1WinCondition2(Board, Player, WinBoard, WinWinBoard) :- Board = [_,Player,Player,Player,_,_,_,_,_,_,_,_,_,_,_,_],updateWinBoard2(WinBoard,WinWinBoard).
row2WinCondition1(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,_,Player,Player,Player,_,_,_,_,_,_,_,_,_],updateWinBoard3(WinBoard,WinWinBoard).
row2WinCondition2(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,_,_,Player,Player,Player,_,_,_,_,_,_,_,_],updateWinBoard4(WinBoard,WinWinBoard).
row3WinCondition1(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,_,_,_,_,_,Player,Player,Player,_,_,_,_,_],updateWinBoard5(WinBoard,WinWinBoard).
row3WinCondition2(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,_,_,_,_,_,_,Player,Player,Player,_,_,_,_],updateWinBoard6(WinBoard,WinWinBoard).
row4WinCondition1(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,_,_,_,_,_,_,_,_,_,Player,Player,Player,_],updateWinBoard7(WinBoard,WinWinBoard).
row4WinCondition2(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,_,_,_,_,_,_,_,_,_,_,Player,Player,Player],updateWinBoard8(WinBoard,WinWinBoard).

column1WinCondition1(Board, Player, WinBoard, WinWinBoard) :- Board = [Player,_,_,_,Player,_,_,_,Player,_,_,_,_,_,_,_],updateWinBoard9(WinBoard,WinWinBoard).
column1WinCondition2(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,_,Player,_,_,_,Player,_,_,_,Player,_,_,_],updateWinBoard10(WinBoard,WinWinBoard).
column2WinCondition1(Board, Player, WinBoard, WinWinBoard) :- Board = [_,Player,_,_,_,Player,_,_,_,Player,_,_,_,_,_,_],updateWinBoard11(WinBoard,WinWinBoard).
column2WinCondition2(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,_,_,Player,_,_,_,Player,_,_,_,Player,_,_],updateWinBoard12(WinBoard,WinWinBoard).
column3WinCondition1(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,Player,_,_,_,Player,_,_,_,Player,_,_,_,_,_],updateWinBoard13(WinBoard,WinWinBoard).
column3WinCondition2(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,_,_,_,Player,_,_,_,Player,_,_,_,Player,_],updateWinBoard14(WinBoard,WinWinBoard).
column4WinCondition1(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,Player,_,_,_,Player,_,_,_,Player,_,_,_,_],updateWinBoard15(WinBoard,WinWinBoard).
column4WinCondition2(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,_,_,_,_,Player,_,_,_,Player,_,_,_,Player],updateWinBoard16(WinBoard,WinWinBoard).

diagonal1WinCondition1(Board, Player, WinBoard, WinWinBoard) :- Board = [Player,_,_,_,_,Player,_,_,_,_,Player,_,_,_,_,_],updateWinBoard17(WinBoard,WinWinBoard).
diagonal1WinCondition2(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,_,_,Player,_,_,_,_,Player,_,_,_,_,Player],updateWinBoard18(WinBoard,WinWinBoard).
diagonal2WinCondition1(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,Player,_,_,Player,_,_,Player,_,_,_,_,_,_],updateWinBoard19(WinBoard,WinWinBoard).
diagonal2WinCondition2(Board, Player, WinBoard, WinWinBoard) :- Board = [_,Player,_,_,_,_,Player,_,_,_,_,Player,_,_,_,_],updateWinBoard20(WinBoard,WinWinBoard).
diagonal3WinCondition1(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,_,Player,_,_,_,_,Player,_,_,_,_,Player,_],updateWinBoard21(WinBoard,WinWinBoard).
diagonal3WinCondition2(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,Player,_,_,Player,_,_,Player,_,_,_,_,_,_,_],updateWinBoard22(WinBoard,WinWinBoard).
diagonal4WinCondition1(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,_,_,_,_,Player,_,_,Player,_,_,Player,_,_],updateWinBoard23(WinBoard,WinWinBoard).
diagonal4WinCondition2(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,_,_,_,Player,_,_,Player,_,_,Player,_,_,_],updateWinBoard24(WinBoard,WinWinBoard).

borderRow1WinCondition1(Board, Player, WinBoard, WinWinBoard) :- Board = [Player,Player,_,Player,_,_,_,_,_,_,_,_,_,_,_,_],updateWinBoard25(WinBoard,WinWinBoard).
borderRow1WinCondition2(Board, Player, WinBoard, WinWinBoard) :- Board = [Player,_,Player,Player,_,_,_,_,_,_,_,_,_,_,_,_],updateWinBoard26(WinBoard,WinWinBoard).
borderRow2WinCondition1(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,_,Player,Player,_,Player,_,_,_,_,_,_,_,_],updateWinBoard27(WinBoard,WinWinBoard).
borderRow2WinCondition2(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,_,Player,_,Player,Player,_,_,_,_,_,_,_,_],updateWinBoard28(WinBoard,WinWinBoard).
borderRow3WinCondition1(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,_,_,_,_,_,Player,Player,_,Player,_,_,_,_],updateWinBoard29(WinBoard,WinWinBoard).
borderRow3WinCondition2(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,_,_,_,_,_,Player,_,Player,Player,_,_,_,_],updateWinBoard30(WinBoard,WinWinBoard).
borderRow4WinCondition1(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,_,_,_,_,_,_,_,_,_,Player,Player,_,Player],updateWinBoard31(WinBoard,WinWinBoard).
borderRow4WinCondition2(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,_,_,_,_,_,_,_,_,_,Player,_,Player,Player],updateWinBoard32(WinBoard,WinWinBoard).

borderColumn1WinCondition1(Board, Player, WinBoard, WinWinBoard) :- Board = [Player,_,_,_,Player,_,_,_,_,_,_,_,Player,_,_,_],updateWinBoard33(WinBoard,WinWinBoard).
borderColumn1WinCondition2(Board, Player, WinBoard, WinWinBoard) :- Board = [Player,_,_,_,_,_,_,_,Player,_,_,_,Player,_,_,_],updateWinBoard34(WinBoard,WinWinBoard).
borderColumn2WinCondition1(Board, Player, WinBoard, WinWinBoard) :- Board = [_,Player,_,_,_,Player,_,_,_,_,_,_,_,Player,_,_],updateWinBoard35(WinBoard,WinWinBoard).
borderColumn2WinCondition2(Board, Player, WinBoard, WinWinBoard) :- Board = [_,Player,_,_,_,_,_,_,_,Player,_,_,_,Player,_,_],updateWinBoard36(WinBoard,WinWinBoard).
borderColumn3WinCondition1(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,Player,_,_,_,Player,_,_,_,_,_,_,_,Player,_],updateWinBoard37(WinBoard,WinWinBoard).
borderColumn3WinCondition2(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,Player,_,_,_,_,_,_,_,Player,_,_,_,Player,_],updateWinBoard38(WinBoard,WinWinBoard).
borderColumn4WinCondition1(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,Player,_,_,_,Player,_,_,_,_,_,_,_,Player],updateWinBoard39(WinBoard,WinWinBoard).
borderColumn4WinCondition2(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,Player,_,_,_,_,_,_,_,Player,_,_,_,Player],updateWinBoard40(WinBoard,WinWinBoard).

borderDiagonal1WinCondition1(Board, Player, WinBoard, WinWinBoard) :- Board = [Player,_,_,_,_,Player,_,_,_,_,_,_,_,_,_,Player],updateWinBoard41(WinBoard,WinWinBoard).
borderDiagonal1WinCondition2(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,Player,_,_,_,_,_,Player,_,_,Player,_,_,_],updateWinBoard42(WinBoard,WinWinBoard).
borderDiagonal2WinCondition1(Board, Player, WinBoard, WinWinBoard) :- Board = [Player,_,_,_,_,_,_,_,_,_,Player,_,_,_,_,Player],updateWinBoard43(WinBoard,WinWinBoard).
borderDiagonal2WinCondition2(Board, Player, WinBoard, WinWinBoard) :- Board = [_,_,_,Player,_,_,Player,_,_,_,_,_,Player,_,_,_],updateWinBoard44(WinBoard,WinWinBoard).

% 'b' BECOMES 'c' IF WINNING SITUATION IS ENCOUNTERED.
updateWinBoard1([b,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[c,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard2([A,b,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,c,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard3([A,B,b,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,c,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard4([A,B,C,b,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,c,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard5([A,B,C,D,b,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,c,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard6([A,B,C,D,E,b,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,c,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard7([A,B,C,D,E,F,b,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,c,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard8([A,B,C,D,E,F,G,b,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,c,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard9([A,B,C,D,E,F,G,H,b,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,c,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard10([A,B,C,D,E,F,G,H,I,b,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,c,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard11([A,B,C,D,E,F,G,H,I,J,b,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,c,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard12([A,B,C,D,E,F,G,H,I,J,K,b,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,c,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard13([A,B,C,D,E,F,G,H,I,J,K,L,b,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,c,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard14([A,B,C,D,E,F,G,H,I,J,K,L,M,b,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,c,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard15([A,B,C,D,E,F,G,H,I,J,K,L,M,N,b,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,c,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard16([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,b,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,c,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard17([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,b,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,c,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard18([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,b,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,c,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard19([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,b,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,c,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard20([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,b,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,c,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard21([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,b,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,c,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard22([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,b,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,c,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard23([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,b,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,c,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard24([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,b,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,c,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard25([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,b,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,c,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard26([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,b,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,c,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard27([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,b,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,c,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard28([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,b,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,c,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard29([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,b,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,c,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard30([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,b,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,c,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard31([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,b,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,c,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard32([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,b,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,c,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard33([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,b,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,c,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard34([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,b,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,c,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard35([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,b,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,c,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard36([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,b,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,c,Kk,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard37([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,b,Ll,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,c,Ll,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard38([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,b,Mm,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,c,Mm,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard39([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,b,Nn,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,c,Nn,Oo,Pp,Qq,Rr]).
updateWinBoard40([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,b,Oo,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,c,Oo,Pp,Qq,Rr]).
updateWinBoard41([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,b,Pp,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,c,Pp,Qq,Rr]).
updateWinBoard42([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,b,Qq,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,c,Qq,Rr]).
updateWinBoard43([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,b,Rr],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,c,Rr]).
updateWinBoard44([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,b],[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Aa,Bb,Cc,Dd,Ee,Ff,Gg,Hh,Ii,Jj,Kk,Ll,Mm,Nn,Oo,Pp,Qq,c]).


% BOARD IS NOT FULL IF ANY OF THE CELLS CONTAIN 'a'
boardNotFull(Board) :- Board = [a,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_];
Board = [_,a,_,_,_,_,_,_,_,_,_,_,_,_,_,_];
Board = [_,_,a,_,_,_,_,_,_,_,_,_,_,_,_,_];
Board = [_,_,_,a,_,_,_,_,_,_,_,_,_,_,_,_];
Board = [_,_,_,_,a,_,_,_,_,_,_,_,_,_,_,_];
Board = [_,_,_,_,_,a,_,_,_,_,_,_,_,_,_,_];
Board = [_,_,_,_,_,_,a,_,_,_,_,_,_,_,_,_];
Board = [_,_,_,_,_,_,_,a,_,_,_,_,_,_,_,_];
Board = [_,_,_,_,_,_,_,_,a,_,_,_,_,_,_,_];
Board = [_,_,_,_,_,_,_,_,_,a,_,_,_,_,_,_];
Board = [_,_,_,_,_,_,_,_,_,_,a,_,_,_,_,_];
Board = [_,_,_,_,_,_,_,_,_,_,_,a,_,_,_,_];
Board = [_,_,_,_,_,_,_,_,_,_,_,_,a,_,_,_];
Board = [_,_,_,_,_,_,_,_,_,_,_,_,_,a,_,_];
Board = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,a,_];
Board = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,a].


%%% ---- MY FACTS ---- %%%%


row1Score(Player,[Player,Player,Player,Player,_,_,_,_,_,_,_,_,_,_,_,_],4).
row1Score(Player,Opponent,[Player,Player,Player,Opponent,_,_,_,_,_,_,_,_,_,_,_,_],1).
row1Score(Player,Opponent,[Opponent,Player,Player,Player,_,_,_,_,_,_,_,_,_,_,_,_],1).
row1Score(Player,Opponent,[Player,Opponent,Player,Player,_,_,_,_,_,_,_,_,_,_,_,_],1).
row1Score(Player,Opponent,[Player,Player,Opponent,Player,_,_,_,_,_,_,_,_,_,_,_,_],1).
row1Score([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],0).
row2Score(Player,[_,_,_,_,Player,Player,Player,Player,_,_,_,_,_,_,_,_],4).
row2Score(Player,Opponent,[_,_,_,_,Player,Player,Player,Opponent,_,_,_,_,_,_,_,_],1).
row2Score(Player,Opponent,[_,_,_,_,Opponent,Player,Player,Player,_,_,_,_,_,_,_,_],1).
row2Score(Player,Opponent,[_,_,_,_,Player,Opponent,Player,Player,_,_,_,_,_,_,_,_],1).
row2Score(Player,Opponent,[_,_,_,_,Player,Player,Opponent,Player,_,_,_,_,_,_,_,_],1).
row2Score([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],0).
row3Score(Player,[_,_,_,_,_,_,_,_,Player,Player,Player,Player,_,_,_,_],4).
row3Score(Player,Opponent,[_,_,_,_,_,_,_,_,Player,Player,Player,Opponent,_,_,_,_],1).
row3Score(Player,Opponent,[_,_,_,_,_,_,_,_,Opponent,Player,Player,Player,_,_,_,_],1).
row3Score(Player,Opponent,[_,_,_,_,_,_,_,_,Player,Opponent,Player,Player,_,_,_,_],1).
row3Score(Player,Opponent,[_,_,_,_,_,_,_,_,Player,Player,Opponent,Player,_,_,_,_],1).
row3Score([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],0).
row4Score(Player,[_,_,_,_,_,_,_,_,_,_,_,_,Player,Player,Player,Player],4).
row4Score(Player,Opponent,[_,_,_,_,_,_,_,_,_,_,_,_,Player,Player,Player,Opponent],1).
row4Score(Player,Opponent,[_,_,_,_,_,_,_,_,_,_,_,_,Opponent,Player,Player,Player],1).
row4Score(Player,Opponent,[_,_,_,_,_,_,_,_,_,_,_,_,Player,Opponent,Player,Player],1).
row4Score(Player,Opponent,[_,_,_,_,_,_,_,_,_,_,_,_,Player,Player,Opponent,Player],1).
row4Score([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],0).

column1Score(Player,[Player,_,_,_,Player,_,_,_,Player,_,_,_,Player,_,_,_],4).
column1Score(Player,Opponent,[Player,_,_,_,Player,_,_,_,Player,_,_,_,Opponent,_,_,_],1).
column1Score(Player,Opponent,[Opponent,_,_,_,Player,_,_,_,Player,_,_,_,Player,_,_,_],1).
column1Score(Player,Opponent,[Player,_,_,_,Opponent,_,_,_,Player,_,_,_,Player,_,_,_],1).
column1Score(Player,Opponent,[Player,_,_,_,Player,_,_,_,Opponent,_,_,_,Player,_,_,_],1).
column1Score([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],0).
column2Score(Player,[_,Player,_,_,_,Player,_,_,_,Player,_,_,_,Player,_,_],4).
column2Score(Player,Opponent,[_,Player,_,_,_,Player,_,_,_,Player,_,_,_,Opponent,_,_],1).
column2Score(Player,Opponent,[_,Opponent,_,_,_,Player,_,_,_,Player,_,_,_,Player,_,_],1).
column2Score(Player,Opponent,[_,Player,_,_,_,Opponent,_,_,_,Player,_,_,_,Player,_,_],1).
column2Score(Player,Opponent,[_,Player,_,_,_,Player,_,_,_,Opponent,_,_,_,Player,_,_],1).
column2Score([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],0).
column3Score(Player,[_,_,Player,_,_,_,Player,_,_,_,Player,_,_,_,Player,_],4).
column3Score(Player,Opponent,[_,_,Player,_,_,_,Player,_,_,_,Player,_,_,_,Opponent,_],1).
column3Score(Player,Opponent,[_,_,Opponent,_,_,_,Player,_,_,_,Player,_,_,_,Player,_],1).
column3Score(Player,Opponent,[_,_,Player,_,_,_,Opponent,_,_,_,Player,_,_,_,Player,_],1).
column3Score(Player,Opponent,[_,_,Player,_,_,_,Player,_,_,_,Opponent,_,_,_,Player,_],1).
column3Score([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],0).
column4Score(Player,[_,_,_,Player,_,_,_,Player,_,_,_,Player,_,_,_,Player],4).
column4Score(Player,Opponent,[_,_,_,Player,_,_,_,Player,_,_,_,Player,_,_,_,Opponent],1).
column4Score(Player,Opponent,[_,_,_,Opponent,_,_,_,Player,_,_,_,Player,_,_,_,Player],1).
column4Score(Player,Opponent,[_,_,_,Player,_,_,_,Opponent,_,_,_,Player,_,_,_,Player],1).
column4Score(Player,Opponent,[_,_,_,Player,_,_,_,Player,_,_,_,Opponent,_,_,_,Player],1).
column4Score([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],0).

diagonal1Score(Player,[Player,_,_,_,_,Player,_,_,_,_,Player,_,_,_,_,Player],4).
diagonal1Score(Player,Opponent,[Player,_,_,_,_,Player,_,_,_,_,Player,_,_,_,_,Opponent],1).
diagonal1Score(Player,Opponent,[Opponent,_,_,_,_,Player,_,_,_,_,Player,_,_,_,_,Player],1).
diagonal1Score(Player,Opponent,[Player,_,_,_,_,Opponent,_,_,_,_,Player,_,_,_,_,Player],1).
diagonal1Score(Player,Opponent,[Player,_,_,_,_,Player,_,_,_,_,Opponent,_,_,_,_,Player],1).
diagonal1Score([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],0).
diagonal2Score(Player,[_,_,_,Player,_,_,Player,_,_,Player,_,_,Player,_,_,_],4).
diagonal2Score(Player,Opponent,[_,_,_,Player,_,_,Player,_,_,Player,_,_,Opponent,_,_,_],1).
diagonal2Score(Player,Opponent,[_,_,_,Opponent,_,_,Player,_,_,Player,_,_,Player,_,_,_],1).
diagonal2Score(Player,Opponent,[_,_,_,Player,_,_,Opponent,_,_,Player,_,_,Player,_,_,_],1).
diagonal2Score(Player,Opponent,[_,_,_,Player,_,_,Player,_,_,Opponent,_,_,Player,_,_,_],1).
diagonal2Score([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],0).

computerMove([a,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P], 1, [o,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P]).
computerMove([A,a,C,D,E,F,G,H,I,J,K,L,M,N,O,P], 2, [A,o,C,D,E,F,G,H,I,J,K,L,M,N,O,P]).
computerMove([A,B,a,D,E,F,G,H,I,J,K,L,M,N,O,P], 3, [A,B,o,D,E,F,G,H,I,J,K,L,M,N,O,P]).
computerMove([A,B,C,a,E,F,G,H,I,J,K,L,M,N,O,P], 4, [A,B,C,o,E,F,G,H,I,J,K,L,M,N,O,P]).
computerMove([A,B,C,D,a,F,G,H,I,J,K,L,M,N,O,P], 5, [A,B,C,D,o,F,G,H,I,J,K,L,M,N,O,P]).
computerMove([A,B,C,D,E,a,G,H,I,J,K,L,M,N,O,P], 6, [A,B,C,D,E,o,G,H,I,J,K,L,M,N,O,P]).
computerMove([A,B,C,D,E,F,a,H,I,J,K,L,M,N,O,P], 7, [A,B,C,D,E,F,o,H,I,J,K,L,M,N,O,P]).
computerMove([A,B,C,D,E,F,G,a,I,J,K,L,M,N,O,P], 8, [A,B,C,D,E,F,G,o,I,J,K,L,M,N,O,P]).
computerMove([A,B,C,D,E,F,G,H,a,J,K,L,M,N,O,P], 9, [A,B,C,D,E,F,G,H,o,J,K,L,M,N,O,P]).
computerMove([A,B,C,D,E,F,G,H,I,a,K,L,M,N,O,P], 10, [A,B,C,D,E,F,G,H,I,o,K,L,M,N,O,P]).
computerMove([A,B,C,D,E,F,G,H,I,J,a,L,M,N,O,P], 11, [A,B,C,D,E,F,G,H,I,J,o,L,M,N,O,P]).
computerMove([A,B,C,D,E,F,G,H,I,J,K,a,M,N,O,P], 12, [A,B,C,D,E,F,G,H,I,J,K,o,M,N,O,P]).
computerMove([A,B,C,D,E,F,G,H,I,J,K,L,a,N,O,P], 13, [A,B,C,D,E,F,G,H,I,J,K,L,o,N,O,P]).
computerMove([A,B,C,D,E,F,G,H,I,J,K,L,M,a,O,P], 14, [A,B,C,D,E,F,G,H,I,J,K,L,M,o,O,P]).
computerMove([A,B,C,D,E,F,G,H,I,J,K,L,M,N,a,P], 15, [A,B,C,D,E,F,G,H,I,J,K,L,M,N,o,P]).
computerMove([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,a], 16, [A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,o]).

playerMove([a,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P], 1, [x,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P]).
playerMove([A,a,C,D,E,F,G,H,I,J,K,L,M,N,O,P], 2, [A,x,C,D,E,F,G,H,I,J,K,L,M,N,O,P]).
playerMove([A,B,a,D,E,F,G,H,I,J,K,L,M,N,O,P], 3, [A,B,x,D,E,F,G,H,I,J,K,L,M,N,O,P]).
playerMove([A,B,C,a,E,F,G,H,I,J,K,L,M,N,O,P], 4, [A,B,C,x,E,F,G,H,I,J,K,L,M,N,O,P]).
playerMove([A,B,C,D,a,F,G,H,I,J,K,L,M,N,O,P], 5, [A,B,C,D,x,F,G,H,I,J,K,L,M,N,O,P]).
playerMove([A,B,C,D,E,a,G,H,I,J,K,L,M,N,O,P], 6, [A,B,C,D,E,x,G,H,I,J,K,L,M,N,O,P]).
playerMove([A,B,C,D,E,F,a,H,I,J,K,L,M,N,O,P], 7, [A,B,C,D,E,F,x,H,I,J,K,L,M,N,O,P]).
playerMove([A,B,C,D,E,F,G,a,I,J,K,L,M,N,O,P], 8, [A,B,C,D,E,F,G,x,I,J,K,L,M,N,O,P]).
playerMove([A,B,C,D,E,F,G,H,a,J,K,L,M,N,O,P], 9, [A,B,C,D,E,F,G,H,x,J,K,L,M,N,O,P]).
playerMove([A,B,C,D,E,F,G,H,I,a,K,L,M,N,O,P], 10, [A,B,C,D,E,F,G,H,I,x,K,L,M,N,O,P]).
playerMove([A,B,C,D,E,F,G,H,I,J,a,L,M,N,O,P], 11, [A,B,C,D,E,F,G,H,I,J,x,L,M,N,O,P]).
playerMove([A,B,C,D,E,F,G,H,I,J,K,a,M,N,O,P], 12, [A,B,C,D,E,F,G,H,I,J,K,x,M,N,O,P]).
playerMove([A,B,C,D,E,F,G,H,I,J,K,L,a,N,O,P], 13, [A,B,C,D,E,F,G,H,I,J,K,L,x,N,O,P]).
playerMove([A,B,C,D,E,F,G,H,I,J,K,L,M,a,O,P], 14, [A,B,C,D,E,F,G,H,I,J,K,L,M,x,O,P]).
playerMove([A,B,C,D,E,F,G,H,I,J,K,L,M,N,a,P], 15, [A,B,C,D,E,F,G,H,I,J,K,L,M,N,x,P]).
playerMove([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,a], 16, [A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,x]).

% IN THE CASE THE BOARD DIDNT CHANGE, ISSUE THE ERROR MESSAGE.
playerMove(Board, _, Board) :-
write('Invalid Move, Try Again.'),nl.

% CHECK IF COMPUTER CAN MAKE A MOVE THAT COMPUTER WINS. THERE ARE 44 WAYS TO WIN.
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), row1WinCondition1(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), row1WinCondition2(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), row2WinCondition1(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), row2WinCondition2(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), row3WinCondition1(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), row3WinCondition2(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), row4WinCondition1(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), row4WinCondition2(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), column1WinCondition1(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), column1WinCondition2(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), column2WinCondition1(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), column2WinCondition2(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), column3WinCondition1(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), column3WinCondition2(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), column4WinCondition1(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), column4WinCondition2(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), diagonal1WinCondition1(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), diagonal1WinCondition2(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), diagonal2WinCondition1(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), diagonal2WinCondition2(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), diagonal3WinCondition1(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), diagonal3WinCondition2(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), diagonal4WinCondition1(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), diagonal4WinCondition2(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), borderRow1WinCondition1(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), borderRow1WinCondition2(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), borderRow2WinCondition1(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), borderRow2WinCondition2(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), borderRow3WinCondition1(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), borderRow3WinCondition2(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), borderRow4WinCondition1(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), borderRow4WinCondition2(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), borderColumn1WinCondition1(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), borderColumn1WinCondition2(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), borderColumn2WinCondition1(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), borderColumn2WinCondition2(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), borderColumn3WinCondition1(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), borderColumn3WinCondition2(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), borderColumn4WinCondition1(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), borderColumn4WinCondition2(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), borderDiagonal1WinCondition1(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), borderDiagonal1WinCondition2(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), borderDiagonal2WinCondition1(NewBoard, o, WinBoard, WinWinBoard).
computerPlay(Board,NewBoard, WinBoard, WinWinBoard) :- computerMove(Board,_,NewBoard), borderDiagonal2WinCondition2(NewBoard, o, WinBoard, WinWinBoard).

% GENERATE A RANDOM NUMBER FROM 1 TO 16 AND COMPUTER MAKE A MOVE
computerPlay(Board,NewBoard) :- random(1, 17, N),
computerMove(Board, N, NewBoard).

% IF RANDOM GENERATOR ISSUES AN INVALID NUMBER WHICH IS ALREADY TAKEN, PICK ANY AVAILABLE CELL
computerPlay(Board,NewBoard) :-
computerMove(Board,_,NewBoard).






