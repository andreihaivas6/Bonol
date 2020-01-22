
void Window()
{
  switch(window)
  {
    case 4:
      tutorial();
      break;
    case 6:
      changeName();
      break;
    case 7:
      playPvPNormal();
      printScore();
      timer();
      areYouSure();
      break;
    case 8:
      playPvPNormal();
      neutralPiece();
      printScore();
      timer();
      areYouSure();
      break;
    case 9:
      PlayPvC();
      printScore();
      timer();
      areYouSure();
      break;
    default:
      break;
  }
}

void tutorial()
{
  image(tutorialImages[nrPagina][language], 0.25 / 2 * width, 0.4 / 2 * height);
}

void playPvPNormal()
{
  drawBoard();
  if(inGame)
  {
    if(step==1)
      step1();
    else
      step2();
    if(isGameOver)
    {
      inGame = false;
      if(turn == 1){
        scor2++;
        txt1 = playerName[1][language] + " " + labelName[4][language]; 
      }
      else{
        scor1++;
        txt1 = playerName[0][language] + " " + labelName[4][language]; 
      }
      turn = 0;
    }
    else
      txt1 = labelName[3][language] + " " + playerName[turn - 1][language];
  }  
  fill(0);
  text(txt1, height / 8, height / 12);
}

void printScore()
{
  fill(0);
  float aux;
  if(rezolutie == 3)
    aux = labelCoord[2][0];
  else
    aux = board_pos[0] + 4 * sq_size + 0.05 * width;
  textSize(2.5 / 4 * dim);
  txt =  playerName[0][language] + ": " + String.valueOf(scor1);
  text(txt, aux, 0.4 * height);
  if(window == 7 || window == 8)
    txt = playerName[1][language] + ": " + String.valueOf(scor2);
  else
    txt = "PC: " + String.valueOf(scor2);;
  text(txt, aux, 0.5 * height);
}

void timer()
{
  time = millis() - startTime;
  if(!isGameOver) // sa se opreasca timer la gamaOver
  {
    miliSec = (int)time % 1000 / 10;
    time = (int)time / 1000 ;
    min = (int)time / 60;
    sec = (int)time % 60;
  }
  txt = "";
  if(min < 10)
    txt += "0";
  txt += String.valueOf((int)min) + ":";
  if(sec < 10)
    txt += "0";
  txt += String.valueOf((int)sec) + ":";
  if(miliSec < 10)
    txt += "0";
  txt += String.valueOf((int)miliSec);
  fill(0);
  textSize(2.5 / 4 * dim);
  text(txt, labelCoord[2][0], height / 5.5);
}

void areYouSure()
{
 if(youSure)
 {
   inGame = false;
   fill(240);
   rect(board_pos[0] , board_pos[1] + sq_size, 4 * sq_size, 2 * sq_size);
   fill(0);
   textSize(dim);
   txt = labelName[15][language];
   if(language != 1)
     text(txt, labelCoord[15][0], labelCoord[15][1]);
   else
     text(txt, labelCoord[15][0] - sq_size / 2, labelCoord[15][1]);
   drawButton(18);
   drawButton(19);
 }
}

void changeName()
{
  initNames(); 
  fill(255);
  if(index == 0 || index == 1)
    rect(0, nameCoord[index][1] - 0.9 * dim, width, dim);
  fill(0);
  for(i = 0; i <= 1; ++i)
  {
    if(hoverName(i) && mousePressed)
      index = i;
    text(name[i], nameCoord[i][0], nameCoord[i][1]);
  }
  boolean ok = false;
  if(hoverName(0) || hoverName(1))
    ok = true;
  if(!ok && mousePressed && mouseButton == LEFT)
    index = -1;
}

boolean hoverName(int k)
{
  if(0 <= mouseX && mouseX <= width && nameCoord[k][1] - dim * 0.9 <= mouseY && mouseY <= nameCoord[k][1] + dim * 0.1)
    return true;
  return false;
}

void keyPressed()
{
  if(window == 6 && (index == 0 || index == 1))
    if((('A' <= key && key <= 'z') || ('1' <= key && key <= '9') || key == ' ') && name[index].length() < 8)
      name[index] += key;
    else
      if(key == BACKSPACE && name[index].length() > 0)
        name[index] = name[index].substring(0, name[index].length() - 1);
}

void  neutralPiece()
{
  if(ok && !isGameOver)
  {
    if(contor == 1)
      addPiece();
    else
      if(contor == 4)
        takePiece();
      else
        if(random(2) < 1)
          addPiece();
        else
          takePiece();
    ok = false;
  }
}

void addPiece()
{
  searchSafeZone(0);
  if(lungS > 0)
  {
    contor++;
    int aux = (int)random(lungS);
    board[vectSafe[aux][0]][vectSafe[aux][1]] = -1;
  }
  if(gameOver())
    isGameOver=true;
}

void takePiece()
{
  searchKillerZone(-1);
  if(lungK > 0)
  {
    contor--;
    int aux = (int)random(lungK);
    board[vectKiller[aux][0]][vectKiller[aux][1]] = 0;
  }
}

void searchSafeZone(int k)
{
  lungS = 0;
  for(i = 0; i <= 3; i = i + 3)
    for(j = 0; j <= 3; j = j + 3)
      if(board[i][j] == k)
      {
        vectSafe[lungS][0] = i;
        vectSafe[lungS][1] = j;
        lungS++; 
      }
}

void searchKillerZone(int k)
{
  lungK = 0;
  for(i = 0; i <= 3; i = i + 3)
    for(j = 1; j <= 2; ++j)
    {
      if(board[i][j] == k)
      {
        vectKiller[lungK][0] = i;
        vectKiller[lungK][1] = j;
        lungK++; 
      }
      if(board[j][i] == k)
      {
        vectKiller[lungK][0] = j;
        vectKiller[lungK][1] = i;
        lungK++;
      }
    }
}

void PlayPvC()
{
  drawBoard();
  if(inGame)
  { 
    if(turn == 1)
      if(step==1)
        step1();
      else{
        step2();
        if(turn == 2){
          drawBoard();
          find = false;
        }
      }
    else{
      if(step == 1)
        step1PC();
      else
        step2PC();
    }
    if(isGameOver)
    {
      inGame = false;
      if(turn == 1){
        scor2++;
        txt1 = "PC " + labelName[4][language]; 
      }
      else{
        scor1++;
        txt1 = playerName[0][language] + " " + labelName[4][language]; 
      }
      turn = 0;
    }
    else
      if(turn == 1)
        txt1 = labelName[3][language] + " " + playerName[0][language];
      else
        txt1 = labelName[3][language] + " PC";
  }  
  fill(0);
  text(txt1, height / 8, height / 12);
}

void step1PC()
{
  if(!find)
    findMove();
  if(!isGameOver)
  {
    if(indice < 4){   // nu se actualizeaza ecranu daca era for
      board[mutare[indice][0]][mutare[indice][1]] = 3;
      ++indice;
    }
    if(indice == 4)
    {
      for(i = 0; i < 4; ++i)
        for(j = 0; j < 4; ++j)
          if(board[i][j] == 2)
            board[i][j] = 0;
          else
            if(board[i][j] == 3)
              board[i][j] = 2;
      step = 2;
      gasit = false;
    }
    drawBoard();
    delay(500);
  }
}

void findMove()
{
  nrMoves = 0;
  for(int ind = 0; ind < 2; ++ind)
    for(int k = -1; k < 3; ++k)
      for(int l = -1; l < 3; ++l)
        for(int p = 0; p < 4; ++p)
        {
          for(i = 0; i < 3; ++i)
            for(j = 0; j < 3; ++j)
              mat[i][j] = auxMat[ind][i][j];
          mat[colt[p][0]][colt[p][1]] = 3;
          int cont = 0;
          boolean cauta0 = false; // sa nu fie mutarea identica
          for(i = 0; i < 3; ++i)
            for(j = 0; j < 3; ++j)
              if(i + k >= 0 && i + k <= 3 && j + l >= 0 && j + l <= 3)
                if(mat[i][j] == 3)
                {
                   if(board[i + k][j + l] == 0)
                     cauta0 = true;
                   if(board[i + k][j + l] == 0 || board[i + k][j + l] == 2)
                     cont++;
                }
          if(cont == 4 && cauta0)
          {
            movesPC[nrMoves][0] = ind;
            movesPC[nrMoves][1] = k;
            movesPC[nrMoves][2] = l;
            movesPC[nrMoves][3] = colt[p][0];
            movesPC[nrMoves][4] = colt[p][1];
            movesPC[nrMoves][5] = 0;
            for(i = 0; i < 3; ++i)  // valoare matrice
              for(j = 0; j < 3; ++j)
                if(i + k >= 0 && i + k <= 3 && j + l >= 0 && j + l <= 3)
                  if(mat[i][j] == 3)
                    {
                      if((i + k == 1 || i + k == 2) && (j + l == 1 || j + l == 2))
                        movesPC[nrMoves][5]++;
                      if((i + k == 0 || i + k == 3) && (j + l == 0 || j + l == 3))
                        movesPC[nrMoves][5]--;
                    }
            nrMoves++;
          }
        }
  chooseMove();
  find = true;
}

void chooseMove()
{
  if(nrMoves == 0)
  {
    isGameOver = true;
    fileWin.play();
  }
  else
  {
    if(dificultate <= random(5)) // easy
      sol = (int)random(nrMoves);
    else                        // hard
    {
      int maxim = movesPC[0][5];
      sol = 0;
      for(i = 0; i < nrMoves; ++i)
        if(movesPC[i][5] > maxim){
          maxim = movesPC[i][5];
          sol = i;
        }
    }
    createSolution();
    indice = 0;
  }
}

void createSolution()
{
  for(i = 0; i < 3; ++i)
    for(j = 0; j < 3; ++j)
      mat[i][j] = auxMat[movesPC[sol][0]][i][j];
  mat[movesPC[sol][3]][movesPC[sol][4]] = 3;
  int cont = 0;
  for(i = 0; i < 3; ++i)
    for(j = 0; j < 3; ++j)
      if(mat[i][j] == 3)
      {
        mutare[cont][0] = i + movesPC[sol][1];
        mutare[cont][1] = j + movesPC[sol][2];
        ++cont;
      }
}

void step2PC()
{
  if(!gasit)
  {
      var1 = var2 = -1;  // ramane -1 daca nu se muta un cerc
      if(dificultate <= random(5))
      {
        searchKillerZone(-1);
        searchSafeZone(0);
        if(lungS > 0 && lungK > 0)
        {
          int aux;
          aux = (int)random(lungK);
          board[vectKiller[aux][0]][vectKiller[aux][1]] = -2;
          aux = (int)random(lungS);
          var1 = vectSafe[aux][0];
          var2 = vectSafe[aux][1];
        }
      }
      else
      {
        searchPoz();
        choosePoz();
      }
    gasit = true;
  }
  else{
    if(var1 != -1)
    {
      for(i = 0; i < 4; ++i)
        for(j = 0; j < 4; ++j)
          if(board[i][j] == -2)
            board[i][j] = 0;
      board[var1][var2] = -1;
    }
    nextTurn();
  }
  delay(500);
  drawBoard();
}

void searchPoz()
{
  lung0 = lung1 = 0;
  for(i = 0; i < 4; i = i + 3)
    for(j = 0; j < 4; ++j)
      if(board[i][j] == 0)
      {
        poz0[lung0][0] = i;
        poz0[lung0][1] = j;
        lung0++;
      }
  for(i = 1; i <= 2; ++i)
    for(j = 0; j < 4; j = j + 3)
      if(board[i][j] == 0)
      {
        poz0[lung0][0] = i;
        poz0[lung0][1] = j;
        lung0++;
      }
  for(i = 0; i < 4; ++i)
    for(j = 0; j < 4; ++j)
      if(board[i][j] == -1)
      {
        poz1[lung1][0] = i;
        poz1[lung1][1] = j;
        lung1++;
      }
}

void choosePoz()
{
  int x1 = -1, y1 = -1;
  boolean gasit_ = false;
  for(j = 0; j < 2 ; ++j)
  {
    x1 = poz1[j][0];
    y1 = poz1[j][1];
    board[x1][y1] = 0;
    turn = 1;
    for(i = 0; i < lung0 && !gasit_; i++)
    {
      board[poz0[i][0]][poz0[i][1]] = -1;
      if(gameOver())
        gasit_ = true;
      board[poz0[i][0]][poz0[i][1]] = 0;
    }
    board[x1][y1] = -1;
    turn = 2;
    if(gasit_)
    {
      var1 = poz0[i - 1][0];
      var2 = poz0[i - 1][1];
      j = 2;
    }
  }
  
  if(!gasit_)
  {
    int aux = (int)random(lung0);
    var1 = poz0[aux][0];
    var2 = poz0[aux][1];
    aux = (int)random(2);
    x1 = poz1[aux][0];
    y1 = poz1[aux][1];
  }
  board[x1][y1] = -2;
}
