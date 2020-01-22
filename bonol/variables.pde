int[] WHITE={255,255,255},PLAYER1={255,0,0},PLAYER2={0,0,255},BLACK={0,0,0},GREEN={0,255,0};

PImage play,exit,bg,skip;//imaginile fiecarui buton si a background-ului
PFont font;
int[] play_pos={0,0},exit_pos={0,0},skip_pos={0,0};//pozitiile butoanelor pe ecran
boolean inGame,mouse_pressed=false,mouse_released=false,mouse_hold=false,isGameOver=false;

int[][] board={{-1,2,2,0},{0,1,2,0},{0,1,2,0},{0,1,1,-1}},selected_sq=new int[20][3];
int sq_size,board_pos[]={160,60},alpha=90,turn=1,step=1,nr=0,selected=0;
int[] current_sq={0,0};

//sq_size = dimensiunea unui patrat de pe tabla de joc
//turn = 1 daca e tura jucatorului 1 ,si 2 pt jucatorul 2
//selected = nr de spatii selectate cand se traseaza figura in pasul 1
//current_sq = spatiul care tocmai a fost selectat cand se traseaza figura in pasul 1
