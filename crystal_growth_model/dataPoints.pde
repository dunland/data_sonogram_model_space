class DataPoint
{

  int xpos;
  int ypos;


  DataPoint(int x, int y)
  {
    xpos = x;
    ypos = y;
  }
  
  void draw()
  {
    pushStyle();
    fill(255);
    ellipse(xpos, ypos, 10, 10);
    popStyle();
  }
}
