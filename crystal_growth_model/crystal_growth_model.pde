/* data crystalization */

ArrayList<DataPoint> dataPointsList = new ArrayList<DataPoint>();

void setup()
{
  size(800, 600);
  
  for (int i = 0; i < 20; i++)
  {
    dataPointsList.add(new DataPoint(int(random(width)), int(random(height))));
  }
}

void draw()
{
  background(255);
  for (DataPoint dp : dataPointsList)
  {
    dp.draw();
  }
  incrementRadius();
}
