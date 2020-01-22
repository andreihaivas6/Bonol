
void initOnce()
{
  surface.setSize(resolution[rezolutie][0], resolution[rezolutie][1]);
  surface.setLocation(-2, 0);
  myFont = loadFont("font.vlw");
  textFont(myFont);
  strokeWeight(2);
  stroke(0);
  fileMusic = new SoundFile(this,sketchPath("music.wav"));
  filePiece = new SoundFile(this, sketchPath("soundPiece.wav"));
  fileButton = new SoundFile(this, sketchPath("soundButton.wav"));
  fileWin = new SoundFile(this, sketchPath("soundWin.wav"));
  fileMusic.loop();
}

void loadImages()
{
  for(i = 0; i < nrTotalPagini; ++i)
    for(j = 0; j < 3; ++j)
    {
      tutorialImages[i][j] = loadImage("a"+i+j+".png");
      tutorialImages[i][j].resize(3 * width / 4, 5 * height / 9);
    }
}

void initialisation() // pt schimbare rezolutie
{
  surface.setSize(resolution[rezolutie][0], resolution[rezolutie][1]);
  surface.setLocation(-2, 0);
  dim = height / 12;
  textSize(dim);
  
  initBoard();   //Alex 
  initButtons();
  initLabels();
  initArrows();
  name[0] = playerName[0][language];
  name[1] = playerName[1][language];
  initNames();
  loadImages(); 
}

void initButtons()
{
  initButtonsSize();
  
  for(i = 1; i <= 4; ++i)
  {
    buttonCoord[i][1] = (float)i / 5 * height;
    buttonCoord[i][0] = width / 4 - buttonCoord[i][2] / 2; 
  }
  
  buttonCoord[5][0] = 2.8 / 4 * width;
  buttonCoord[5][1] = 4.0 / 5 * height;
  buttonCoord[0][0] = 3.0 / 4 * width;
  buttonCoord[0][1] = 4.2 / 5 * height;
  
  for(i = 6; i <= 12; ++i)
     buttonCoord[i][0] = width / 2 - buttonCoord[i][2] / 2; //centrare pe mijloc
  
  buttonCoord[6][1] = buttonCoord[8][1] = height / 4;
  buttonCoord[7][1] = buttonCoord[9][1] = height / 2;
  
  buttonCoord[10][1] = 1 * height / 6;
  buttonCoord[11][1] = 2 * height / 6;
  buttonCoord[12][1] = 3 * height / 6;
  
  buttonCoord[13][0] = width / 20;
  buttonCoord[14][0] = 0.93 * width - buttonCoord[14][2];
  buttonCoord[13][1] = buttonCoord[14][1] = 0.5 / 10 * height;
  
  buttonCoord[15][0] = width / 2 - buttonCoord[15][2] / 2;
  buttonCoord[15][1] = buttonCoord[0][1];
  
  buttonCoord[16][0] = buttonCoord[17][0] = 3.0 / 4 * width;
  buttonCoord[16][1] = buttonCoord[17][1] = 0.61 * height;

  buttonCoord[18][0] = board_pos[0] + sq_size / 2;
  buttonCoord[19][0] = board_pos[0] + 2.8 * sq_size;
  buttonCoord[18][1] = buttonCoord[19][1] = board_pos[1] + 2.2 * sq_size;
}

void initButtonsSize()
{
  dimLitera = dim / 1.66; 
  for(i = 0; i <= 19; ++i)
  {
    txt = buttonName[i][language];
    buttonCoord[i][2] = dimLitera * txt.length() + dim * 2 / 5;
    buttonCoord[i][3] = dim;
  }
}

void initLabels()
{
  labelCoord[0][0] = labelCoord[1][0] = width / 2;
  labelCoord[0][1] = height / 4 + height / 40;
  labelCoord[1][1] = height / 2.5;
  
  labelCoord[13][0] = buttonCoord[6][0] + width / 40;
  labelCoord[14][0] = buttonCoord[7][0] + width / 40;
  labelCoord[13][1] = labelCoord[14][1] = height / 8;
  
  labelCoord[2][0] = 0.75 * width;
  labelCoord[2][1] = 0.3 * height;
  
  labelCoord[15][0] = board_pos[0] + sq_size ;
  labelCoord[15][1] = board_pos[1] + 3.0 / 2 * sq_size;
  
  for(i = 5; i <= 8; ++i)
  {
    labelCoord[i][0] = labelCoord[i + 4][0] = width / 8;
    labelCoord[i][1] = (float)(i - 4) / 6 * height;
  }
  for(i = 9; i <= 12; ++i)
    labelCoord[i][1] = (float)(i - 8) / 8 * height;
}

void initArrows()
{
  for(i = 0; i < 17; i = i + 2)
  {
    arrowCoord[i][2] = 0;
    arrowCoord[i + 1][2] = 1;
  }
  
  arrowCoord[0][0] = width / 2 - 2 * dim;
  arrowCoord[1][0] = width / 2 + 2 * dim;
  arrowCoord[0][1] = arrowCoord[1][1] = 4 * height / 6;
  
  for(i = 2; i <= 16; i = i + 2)
  {
    arrowCoord[i][0] = 3.0 / 4 * width - 2 * dim;
    arrowCoord[i + 1][0] = 3.0 / 4 * width + 2 * dim;
    arrowCoord[i][1] = arrowCoord[i + 1][1] = labelCoord[i / 2 + 4][1] - dim / 2;
  }
  arrowCoord[8][0] -= 1.5 * dim;
  arrowCoord[9][0] += 1.5 * dim;
  
}

void initArrowsValues()
{
  arrowValue[0][0] = 1;
  arrowValue[0][1] = 6;
  
  arrowValue[1][0] = volumSound;
  arrowValue[2][0] = volumMusic;
  arrowValue[3][0] = language;
  arrowValue[4][0] = rezolutie;
  arrowValue[5][0] = colorBg;
  arrowValue[6][0] = colorP1;
  arrowValue[7][0] = colorP2;
  arrowValue[8][0] = colorP3;
  
  arrowValue[1][1] = arrowValue[2][1] = 6;
  arrowValue[3][1] = 3;
  arrowValue[4][1] = 4;
  for(i = 5; i <=8; ++i)
    arrowValue[i][1] = 3;
}

void initNames()
{
  nameCoord[0][0] = width / 2 - dimLitera * name[0].length() / 2;
  nameCoord[1][0] = width / 2 - dimLitera * name[1].length() / 2;
  nameCoord[0][1] = 5.0 / 8 * height;
  nameCoord[1][1] = 6.0 / 8 * height;
}

void reInitBoard()
{
  for(i = 0; i < 4; ++i)
    for(j = 0; j < 4; ++j)
      board[i][j] = auxBoard[i][j];
  step = 1;
  turn = 1;
  nr = selected = 0;
  scor1 = scor2 = 0;
  inGame = false;
  isGameOver = false;
  contor = 2;
  ok = false;
}
