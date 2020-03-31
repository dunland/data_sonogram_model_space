int countIntersections = 0;

class Signal
{

// int pointCounter = 0; // increments for each intersected point; makes sure that the signal does not grow beyond that.

int signal_magnitude = 0;
PVector position;


int xPos, yPos;
Signal(int x_in, int y_in)
{
        xPos = x_in;
        yPos = y_in;
        position = new PVector(xPos, yPos);
}

void propagateSignal()
{
  // if (pointCounter < selectedDatapoints.size())
        signal_magnitude += signalGrowthSpeed;
}

void drawSignal()
{
        noFill();
        stroke(255);
        ellipse(xPos, yPos, signal_magnitude, signal_magnitude);
}

void checkIntersection()
{
        for (Datapoint dp : selectedDatapoints) {

                if (abs(PVector.dist(this.position, dp.position)) - 3 <= signal_magnitude / 2
                    && abs(PVector.dist(this.position, dp.position)) + 3 >= signal_magnitude / 2 && !activeDataPoints.contains(dp))
                {
                        // dp.alreadyIntersected = true;
                        activeDataPoints.add(dp);
                        countIntersections = activeDataPoints.size() / 2;
                        println("active intersections: " + countIntersections);
                        dp.intersectionTime = millis();
                        println(millis() + " " + dp.value + " intersect!");
                        // dp.sound.play(dp.value * data_to_freq_ratio, 0.8/float(countIntersections));
                        // globalSound.add(dp.value * data_to_freq_ratio);
                        globalSound.add(0.5);
                        println("loduness = " + 0.8/float(countIntersections));
                        // pointCounter++;
                }


        }
}
}
