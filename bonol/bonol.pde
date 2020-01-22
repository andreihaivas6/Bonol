
void setup()
{
  initOnce();
  initArrowsValues();
  initialisation();  
}
void draw()
{
  
  fill(ColorBg[colorBg]);
  rect(1, 1, width - 3, height - 3);
  
  drawButtons();
  drawLabels();
  drawArrows();
  drawArrowValues();
  cursor_();
  pressButton();
  pressArrow();
  Window();
  
  fileMusic.amp((float)volumMusic / 5);
  filePiece.amp((float)volumSound / 5);
  fileButton.amp((float)volumSound / 5);
  fileWin.amp((float)volumSound / 5);
}

void mousePressed()
{ 
  mouseIsPressed = true;
  mouse_pressed=true;
  mouse_hold=true;
}

void mouseReleased()
{
  mouseIsReleased = true;
  mouse_released=true;
  mouse_hold=false;
}
