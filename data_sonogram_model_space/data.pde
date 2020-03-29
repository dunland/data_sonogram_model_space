ArrayList<Datapoint> allDataPoints = new ArrayList<Datapoint>();
ArrayList<Datapoint> activeDataPoints = new ArrayList<Datapoint>(); // holds Datapoints that play sound (i.e. they are in "cooldown")
ArrayList<Datapoint> selectedDatapoints = new ArrayList<Datapoint>();

class Datapoint {
// data content
float value;

// position and graphics
float xPos, yPos;
PVector position;
color defaultColor;
color strokeColor = color(63, 58, 223);

// intersection with signal
boolean alreadyIntersected = false;
int intersectionTime = 0;

// making sound
TriOsc sound = new TriOsc(data_sonogram_model_space.this);

Datapoint(float x_in, float y_in, int val_in)
{
        value = val_in;
        xPos = x_in;
        yPos = y_in;
        position = new PVector(xPos, yPos);
}

void draw()
{
        stroke(color(strokeColor));
        fill(153, 218, 238);
        ellipse(xPos, yPos, 5, 5);
}

void cooldown()
{
        if (millis() < intersectionTime)
        {
                strokeColor = color(58, 223, 174);
                sound.play(value * data_to_freq_ratio, 0.2 + 0.8 / float(countIntersections)); // TODO: no clipping!!!
        }
        else{
                sound.stop();
                strokeColor = color(63, 58, 223);
                alreadyIntersected = false;
                activeDataPoints.remove(this);
        }
}
}
