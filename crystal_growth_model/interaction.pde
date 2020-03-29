int seedX, seedY;
int radius = 0;
int r_max = 500; // maximum radius 

void mousePressed()
{
  radius = 0;
  seedX = mouseX;
  seedY = mouseY;
}

void incrementRadius()
{
  if (radius <= r_max) 
  {
    pushStyle();
    noFill();
    stroke(0, 0, 0, (r_max-radius)/float(r_max) * 255);
    ellipse(seedX, seedY, radius++, radius++);
    popStyle();
  }
}
