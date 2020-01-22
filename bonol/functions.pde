//verifica daca mouse-ul se afla in interiorul unui buton (butonul de play,exit...)

boolean hover(PImage img,int[] img_pos) //irimia alex
{
  if(mouseX<=img_pos[0]+img.width && mouseX>=img_pos[0])
    if(mouseY<=img_pos[1]+img.height && mouseY>=img_pos[1])
      return true;
  return false;
}

/*verifica daca mai sunt modalitati de a muta piesa in forma de L pe tabla de joc
daca nu se mai poate muta e returneaza true,adica e game over,alfel returneaza false
*/

boolean gameOver()//irimia alex
{
  //selected=4;
  int possible_moves=0;
  /*
  sunt 2 moduri de a aranja L-ul:0          0
                                 0   sau    0   retinute in possible_shapes,pe care le tot roteste si verifica in fiecare loc de pe tabla de joc 
                                 00        00   daca pozitia respectiva poate fi folosita
                               
  */
  int[][][] possible_shapes={{{0,0},{0,1},{0,2},{1,2}},{{0,0},{0,1},{0,2},{-1,2}}};
  for(int e=0;e<2;++e)
  for(int i=0;i<4;++i)
    for(int j=0;j<4;++j)
    if(board[i][j]==0 || board[i][j]==turn)
    {
      for(int q=0;q<4;++q)
      {
      int ok=1;
      for(int k=0;k<4;++k)
        {
          selected_sq[k][0]=possible_shapes[e][k][0]+i;
          selected_sq[k][1]=possible_shapes[e][k][1]+j;
          //verifica daca pozitia curenta poate fi folosita,daca nu poate ok=0
          if(selected_sq[k][0]<0 || selected_sq[k][0]>=4 || selected_sq[k][1]<0 || selected_sq[k][1]>=4 || !(board[selected_sq[k][0]][selected_sq[k][1]]==0 || board[selected_sq[k][0]][selected_sq[k][1]]==turn))
            ok=0;
          int x=-possible_shapes[e][k][1],y=possible_shapes[e][k][0];//roteste piesa de joc dupa o formula
          possible_shapes[e][k][0]=x; 
          possible_shapes[e][k][1]=y;
        }
      if(ok==1)
        {
          ++possible_moves;//daca pozitia curenta poate fi folosita creste nr de miscari posibile
        }
      }
    }
    //selected=0;
    if(possible_moves==1)//daca nr de miscari posibile e 1,adica pozitia in care se afla deja piesa,e game over
      return true;
    return false;
}

//cand s-a terminat tura unui jucator,se trece la tura celuilalt
void nextTurn() //irimia alex
{
  step=1;
  if(turn==1)
    turn=2;
  else{
    turn=1;
    ok = true;  // mod_Special
  }
  if(gameOver()){
    fileWin.play();
    isGameOver=true;
  }
}

//verifica daca figura trasata e in forma de L,nu prea functioneaza,o sa o modific
boolean isValid()//irimia alex
{
  if(selected!=4)//forma de L trebuie sa aibe 4 patratele
    return false;
  int q=0;
  for(int i=0;i<4;++i)
    if(selected_sq[i][2]==turn)//forma trasata nu trebuie sa fie aceeasi cu pozitia in care se afla deja piesa
      ++q;
  if(q==4)
    return false;
  for(int i=1;i<4;++i)
    if(abs(selected_sq[i][0]-selected_sq[i-1][0])+abs(selected_sq[i][1]-selected_sq[i-1][1])!=1)//asta rezolva problema pe care ai gasit-o
      return false;
  int[] cntx={0,0,0,0},cnty={0,0,0,0};
  for(int i=0;i<4;++i)
  {
      ++cntx[selected_sq[i][0]];
      ++cnty[selected_sq[i][1]];
  }
  for(int i=0;i<4;++i)
    if(cntx[i]==3 || cnty[i]==3)//forma de L are 3 patratele pe aceeasi linie sau coloana
        if(abs(selected_sq[0][0]-selected_sq[3][0])+abs(selected_sq[0][1]-selected_sq[3][1])==3)
            return true;
  return false;
}

//pasul 2 e cel in care jucatorul muta cercul
void step2()//irimia alex
{
  if(mouse_pressed && step==2)
  {
    //verifica daca s-a selectat ceva din interiorul tablei de joc,daca nu fac asta da crash programu
    if(!(mouseX<=board_pos[0] || mouseX>=board_pos[0]+4*sq_size))
        if(!(mouseY<=board_pos[1] || mouseY>=board_pos[1]+4*sq_size))
        {
          int x=(mouseX-board_pos[0])/sq_size;
          int y=(mouseY-board_pos[1])/sq_size;
          //verifica daca s-a selectat un cerc
          if(board[y][x]==-1)
            {
              selected_sq[0][0]=y;
              selected_sq[0][1]=x;
              board[y][x]=-2;
              step=3;
            }
        }
  }
  //in cazul in care deja s-a selectat un cerc,acum trebuie sa ii schimbam pozitia,ar veni un fel de pas 3,alta idee n-am avut
  else if(mouse_pressed && step==3)
    {
      if(!(mouseX<=board_pos[0] || mouseX>=board_pos[0]+4*sq_size))
        if(!(mouseY<=board_pos[1] || mouseY>=board_pos[1]+4*sq_size))
        {
          int x=(mouseX-board_pos[0])/sq_size;
          int y=(mouseY-board_pos[1])/sq_size;
          //daca s-a selectat un spatiu liber se muta cercul
          if(board[y][x]==0)
            {
              board[selected_sq[0][0]][selected_sq[0][1]]=0;
              board[y][x]=-1;
              filePiece.play();
              nextTurn();
            }
          //daca se selecteaza din nou acelasi cerc face un undo si jucatorul poate alege din nou cercul pe care vrea sa il mute,se trece din nou la pasul 2
          else if(board[y][x]==-2)
            {
              board[y][x]=-1;
              step=2;
            }
          //daca se selecteaza celalalt cerc,jucatorul alege practic sa mute celalalt cerc
          else if(board[y][x]==-1)
          {
            board[selected_sq[0][0]][selected_sq[0][1]]=-1;
            selected_sq[0][0]=y;
            selected_sq[0][1]=x;
            board[y][x]=-2;
          }
        }
    }
    mouse_pressed = mouse_released = false;
}

//pasul 1 e cel in care jucatorul muta piesa in forma de L
void step1()//irimia alex
{
  if(mouse_hold)
    {
      if(!(mouseX<=board_pos[0] || mouseX>=board_pos[0]+4*sq_size))
        if(!(mouseY<=board_pos[1] || mouseY>=board_pos[1]+4*sq_size))
        {
          int x=(mouseX-board_pos[0])/sq_size;
          int y=(mouseY-board_pos[1])/sq_size;
          if(board[y][x]==turn || board[y][x]==0)
            {
              //coordontale figurii trasate sunt salvate in selected_sq pentru a se putea vedea mai tarziu daca formeaza un L
              selected_sq[selected][0]=y;
              selected_sq[selected][1]=x;
              selected_sq[selected][2]=board[y][x];
              ++selected;
              board[y][x]=3;
            }
          else if(board[y][x]==3 && (selected_sq[selected-1][0]!=y || selected_sq[selected-1][1]!=x))
            {
               --selected;
               board[selected_sq[selected][0]][selected_sq[selected][1]]=selected_sq[selected][2];
            }
        }
    }
  //daca jucatorul nu mai tine mouse-ul apasat se verifica daca a trasat un L
  else if(isValid())
    {
      for(int i=0;i<4;++i)
      for(int j=0;j<4;++j)
        if(board[i][j]==turn)
          board[i][j]=0;
        else if(board[i][j]==3)
          board[i][j]=turn;
     selected=0;
     step=2;
     filePiece.play();
    }
        else
        {
          for(int i=0;i<selected;++i)
            board[selected_sq[i][0]][selected_sq[i][1]]=selected_sq[i][2];
          selected=0;
        }
        
}

//se deseneaza tabla de joc dupa matricea board[][] astfel:
//valoarea 0 = spatiu liber
//valoarea 1 = spatiu ce face parte din piesa jucatorului 1
//valoarea 2 = spatiu ce face parte din piesa jucatorului 2
//valoarea 3 = daca in pasul 1 se selecteaza un spatiu,valoarea acestuia devine 3
//valoarea -1 = cerc
//valoarea -2 = cerc ce a fost selectat in pasul 2
void drawBoard()//irimia alex
{
  fill(255);
  rect(board_pos[0], board_pos[1], 4 * sq_size, 4 * sq_size);
  for(int i=0;i<4;++i)
    for(int j=0;j<4;++j)
    {
       switch(board[i][j])
       {
         case -2:
           fill(GREEN);
           break;
         case -1:
           break;
         case 0:
           fill(WHITE);
           break;
         case 1:
           if(turn==1 && step==1)
             fill(ColorP1[colorP1],alpha);
           else
             fill(ColorP1[colorP1]);
           break;
         case 2:
           if(turn==2 && step==1)
             fill(ColorP2[colorP2],alpha);
           else
             fill(ColorP2[colorP2]);
           break;
         case 3:
           if(turn==1)
             fill(ColorP1[colorP1]);
           else
             fill(ColorP2[colorP2]);
           break;
       }
      rect(board_pos[0]+j*sq_size,board_pos[1]+i*sq_size,sq_size-1,sq_size-1);
      if(board[i][j]<0)
        {
          fill(ColorP3[colorP3]);
          ellipse(board_pos[0]+j*sq_size+sq_size/2,board_pos[1]+i*sq_size+sq_size/2,sq_size/1.1,sq_size/1.1);
        }
      fill(WHITE);
    }
}

//nu stiu ce face,cred ca am scris-o,dupa n-am mai folosit-o si am uitat sa o sterg,o las momentan sa nu stric cv
void reset_sq(int x)//irimia alex
{
  for(int i=0;i<4;++i)
    for(int j=0;j<4;++j)
    {
      if(board[i][j]==x)
        board[i][j]=0;
    }
}
void initBoard()//irimia alex
{
  inGame = false;
  sq_size=min(width,height)/5;
  board_pos[0]=(width-4*sq_size)/2-width/10;
  board_pos[1]=(height-4*sq_size)/2;
}


//varianta mai uo=soara a functiei fill() ca sa scriem direct un vector ,in loc de 3 valori pt culoare,alpha inseamna transparenta
void fill(int[] COLOR,int alpha)//irimia alex
{
  fill(COLOR[0],COLOR[1],COLOR[2],alpha);
}

//la fel ca mai sus dar fara alpha ca java nu suporta valori default pentru parametri
void fill(int[] COLOR)//irimia alex
{
  fill(COLOR[0],COLOR[1],COLOR[2]);
}
