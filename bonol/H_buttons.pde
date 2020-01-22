
void drawLabels()
{
  for(i = 1; i <= labelOnWindow[window][0]; ++i)
    drawLabel(labelOnWindow[window][i]);
}

void drawLabel(int k)
{
  fill(0);
  if(window == 0)
    textSize(1.5 * dim);
  else
    textSize(dim);
  txt = labelName[k][language];
  text(txt, labelCoord[k][0], labelCoord[k][1]);
}

void drawButtons()
{
  for(i = 1; i <= buttonOnWindow[window][0]; ++i)
    drawButton(buttonOnWindow[window][i]);
  if(window == 4 && nrPagina > 0)
    drawButton(13);
  if(window == 4 && nrPagina < nrTotalPagini - 1)
    drawButton(14);
  if(7 <= window && window <=9)
    if(step == 2 && !(window == 9 && turn == 2))
      drawButton(16);
    else
      if(isGameOver)
        drawButton(17);
}

void drawButton(int k)
{
  if(hoverButton(k))
    fill(colHover);
  else
    fill(colNotHover);
  rect(buttonCoord[k][0], buttonCoord[k][1], buttonCoord[k][2], buttonCoord[k][3]);
  fill(0);
  txt = buttonName[k][language];
  textSize(dim);
  text(txt, buttonCoord[k][0] + dim / 5, buttonCoord[k][1] + buttonCoord[k][3] - dim / 10);
}

boolean hoverButton(int k)
{
  if(buttonCoord[k][0] <= mouseX && mouseX <= buttonCoord[k][0] + buttonCoord[k][2] 
  && buttonCoord[k][1] <= mouseY && mouseY <= buttonCoord[k][1] + buttonCoord[k][3])
    return true;
  return false;
}

void cursor_()
{
  cursorHand = false;
  if(hoverButtons() != -1)
    cursorHand = true;
  if(hoverArrows() != -1)
    cursorHand = true;
  if((hoverName(0) || hoverName(1)) && window == 6)
    cursorHand = true;
  if(cursorHand)
    cursor(HAND);
  else
    cursor(ARROW);
}

int hoverButtons()
{
  for(i = 1; i <= buttonOnWindow[window][0]; ++i)
    if(hoverButton(buttonOnWindow[window][i]))
      return buttonOnWindow[window][i];
  if(window == 4 && nrPagina > 0 && hoverButton(13))
    return 13;
  if(window == 4 && nrPagina < nrTotalPagini - 1 && hoverButton(14))
    return 14;
  if(7 <= window && window <=9 && !youSure) 
    if(step == 2 && hoverButton(16))
      return 16;
    else
      if(isGameOver && hoverButton(17))
        return 17;
  if(youSure && hoverButton(18))
    return 18;
  if(youSure && hoverButton(19))
    return 19;
  return -1;
}

void pressButton()
{
  if(mouseIsPressed && mouseIsReleased){
    int aux = hoverButtons();
    if(aux != -1){
      fileButton.play();
      mouseIsPressed = mouseIsReleased = false;
      switch(aux)
      {
        case -1: 
          break;
        case 0: 
          if((window == 5 || window == 6) && !aplied)
            initArrowsValues();
          if(window <= 6)
            window = 0;
            //reInitBoard();
          else
            youSure = true;
          break;
        case 1:
          window = 1;
          break;
        case 2:
          window = 4;
          nrPagina = 0;
          break;
        case 3:
          aplied = false;
          window = 5;
          break;
        case 4:
          aplied = false;
          name[0] = playerName[0][language];
          name[1] = playerName[1][language];
          window = 6;
          break;
        case 5:
          exit();
        case 6:
          window = 2;
          break;
        case 7:
          window = 3;
          break;
        case 8:
          window = 7;
          reInitBoard();
          inGame = true;
          startTime = millis();
          break;
        case 9:
          window = 8;
          reInitBoard();
          inGame = true;
          startTime = millis();
          break;
        case 10:
          window = 9;
          reInitBoard();
          inGame = true;
          startTime = millis();
          dificultate = 0;
          break;
        case 11:
          window = 9;
          reInitBoard();
          inGame = true;
          startTime = millis();
          dificultate = 5;
          break;
        case 12:
          window = 9;
          reInitBoard();
          inGame = true;
          startTime = millis();
          dificultate = arrowValue[0][0];
          break;
        case 13:
          if(window == 4)
            nrPagina--;
          else
            if(window == 1)
              window = 0;
            else
              window = 1;
          break;
        case 14:
          nrPagina++;
          break;
        case 15:
          //apply
          applyChanges();
          initialisation();
          aplied = true;
          break;
        case 16:
          nextTurn();
          if(window == 9){
            find = false;
            drawBoard();
          }
          break;
        case 17:
          int aux1 = scor1;
          int aux2 = scor2;
          reInitBoard();
          scor1 = aux1;
          scor2 = aux2;
          startTime = millis();
          inGame = true;
          break;
        case 18:
          youSure = false;
          inGame = true;
          if(isGameOver) // repara cv
            if(turn == 1)
              scor2--;
            else
              scor1--;
          break;
        case 19:
          youSure = false;
          window = 0;
          reInitBoard();
          break;
        default: 
          break;
      }
    }
  }
}

void applyChanges()
{
  if(window == 5)
  {
    volumSound = arrowValue[1][0];
    volumMusic = arrowValue[2][0];
    language = arrowValue[3][0];
    rezolutie = arrowValue[4][0];
  }
  else
    if(window == 6)
    {
      colorBg = arrowValue[5][0];
      colorP1 = arrowValue[6][0];
      colorP2 = arrowValue[7][0];
      colorP3 = arrowValue[8][0];
      if(name[0] != playerName[0][language])
        for(i = 0; i < 3; ++i)
          playerName[0][i] = name[0];
      if(name[1] != playerName[1][language])
        for(i = 0; i < 3; ++i)
          playerName[1][i] = name[1];
    }
}

void drawArrows()
{
  if(window == 3)
  {
    drawArrow(0);
    drawArrow(1);
  }
  else 
    if(window == 5)
      for(i = 2; i <= 9; ++i)
        drawArrow(i);
    else
      if(window == 6)
        for(i = 10; i <= 17; ++i)
          drawArrow(i);
}

void drawArrow(int k)
{
  if(arrowCoord[k][2] == 0)
  {
    if(arrowValue[k / 2][0] > 0)
    {
      fill(0);
      rect(arrowCoord[k][0], arrowCoord[k][1] - dim / 2, dim, dim);
      if(hoverArrow(k))
        fill(colHover);
      else
        fill(colNotHover);
      triangle(arrowCoord[k][0], arrowCoord[k][1], 
      arrowCoord[k][0] + dim, arrowCoord[k][1] - dim / 2, 
      arrowCoord[k][0] + dim, arrowCoord[k][1] + dim / 2);
    }
  }
  else
    if(arrowValue[k / 2][0] < arrowValue[k / 2][1] - 1)
    {
      fill(0);
      rect(arrowCoord[k][0] - dim, arrowCoord[k][1] - dim / 2, dim, dim);
      if(hoverArrow(k))
        fill(colHover);
      else
        fill(colNotHover);
      triangle(arrowCoord[k][0], arrowCoord[k][1], 
      arrowCoord[k][0] - dim, arrowCoord[k][1] - dim / 2, 
      arrowCoord[k][0] - dim, arrowCoord[k][1] + dim / 2);
    }
}

void drawArrowValues()
{
  if(window == 3)
    drawArrowValue(0);
  if(window == 5)
    for(i = 2 / 2; i <= 9 / 2; ++i)
      drawArrowValue(i);
  if(window == 6)
    for(i = 10 / 2; i <= 17 / 2; ++i)
      drawArrowValue(i);
}

void drawArrowValue(int k)
{
  if(k <= 2)
  {
    txt = String.valueOf(arrowValue[k][0]);
    fill(0);
    text(txt, arrowCoord[2 * k][0] + 1.75 * dim, arrowCoord[2 * k][1] + dim / 2 - dim / 10);
  }
  else
    if(k == 3)
    {
      txt = Language[arrowValue[3][0]];
      fill(0);
      text(txt, arrowCoord[2 * k][0] + 1.4 * dim, arrowCoord[2 * k][1] + dim / 2 - dim / 10);
    }
    else
      if(k == 4)
      {
        float aux_ = 0;
        if(arrowValue[k][0] < 2)
          aux_ = 0.35 * dim;
        txt = String.valueOf(resolution[arrowValue[k][0]][0]) + "x" + String.valueOf(resolution[arrowValue[k][0]][1]);
        text(txt, arrowCoord[2 * k][0] + dim + aux_, arrowCoord[2 * k][1] + dim / 2 - dim / 10);
      }
      else
      {
        if(k == 5)
          fill(ColorBg[arrowValue[k][0]]);
        else
          if(k == 6)
            fill(ColorP1[arrowValue[k][0]]);
          else
            if(k == 7)
              fill(ColorP2[arrowValue[k][0]]);
            else
              if(k == 8)
                fill(ColorP3[arrowValue[k][0]]);
         rect(arrowCoord[2 * k][0] + dim + dim / 4, arrowCoord[2 * k][1] - dim / 2, 1.5 * dim, dim);
      }
}

boolean hoverArrow(int k)
{
  if(arrowCoord[k][2] == 0 && arrowValue[k / 2][0] > 0)
    if(arrowCoord[k][0] <= mouseX && mouseX <= arrowCoord[k][0] + dim &&
       arrowCoord[k][1] - dim / 2 <= mouseY && mouseY <= arrowCoord[k][1] + dim / 2)
         return true;
  if(arrowCoord[k][2] == 1 && arrowValue[k / 2][0] < arrowValue[k / 2][1] - 1)
    if(arrowCoord[k][0] - dim <= mouseX && mouseX <= arrowCoord[k][0] &&
       arrowCoord[k][1] - dim / 2 <= mouseY && mouseY <= arrowCoord[k][1] + dim / 2)
         return true;
  return false;
}

int hoverArrows()
{
  if(window == 3)
    for(i = 0; i <= 1; ++i)
      if(hoverArrow(i))
        return i;
  if(window == 5)
    for(i = 2; i <= 9; ++i)
      if(hoverArrow(i))
        return i;
  if(window == 6)
    for(i = 10; i <= 17; ++i)
      if(hoverArrow(i))
        return i;
  return -1;
}

void pressArrow()
{
  if(mouseIsPressed && mouseIsReleased){ 
    mouseIsPressed = mouseIsReleased = false;
    int aux = hoverArrows();
    if(aux != -1)
    {
      fileButton.play();
      
      if(arrowCoord[aux][2] == 0)
        arrowValue[aux / 2][0]--;
      else
        arrowValue[aux / 2][0]++;
    }
  }
}
