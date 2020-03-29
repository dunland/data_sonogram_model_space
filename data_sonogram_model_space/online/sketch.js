// import processing.sound.*;

//SIGNAL VARIABLES
var list_of_signals;

let maxSignalExtent;
let signalGrowthSpeed;

// TABLE DISPLAY
let space_top;
let space_bottom;
let space_left;
let space_right;

// INPUT DATA VARIABLES
Table table;
let tableCellWidth;
let tableCellHeight;
let tableMaxValue = Double.NEGATIVE_INFINITY;
// DATA TO SOUND
let data_to_freq_ratio; // maps tableMaxValue to 1000 Hertz
let max_freq = 1000; // in Hertz

function setup() {
  list_of_signals = [];
  signalGrowthSpeed = 2;
  space_top = 80;
  space_bottom = 40;
  space_left = 80;
  space_right = 40;

  createCanvas(800, 600);
  maxSignalExtent = width * 2 / 3;

  //-------------------------- SETUP THE INPUT DATA
  table = loadTable("data.csv", "header");
  tableCellWidth = (width - (space_left + space_right)) / float(table.getRowCount());

  for (TableRow row: table.rows()) {
    try {
      print(row.getInt(0));
      tableMaxValue = (row.getInt(0) > tableMaxValue) ? row.getInt(0) : tableMaxValue;
    } catch (Exception e) {
      print("Error:" + e);
    }
  }
  tableCellHeight = (height - (space_top + space_bottom)) / (float) tableMaxValue;
  print("max value in table is ", tableMaxValue);
  print("tableCellWidth = ", tableCellWidth, "tableCellHeight = ", tableCellHeight);
  data_to_freq_ratio = max_freq / (float) tableMaxValue;


  //-------------------- DATAPOINT OBJECTS ---------------------------------------
  int color_r = 63;
  int color_g = 58;
  int color_b = 223;
  for (int column = 0; column < table.getColumnCount(); column++) {
    // TODO: color allocation for multiple columns
    color[] colorList = new color[table.getColumnCount()];
    // colorList[0] = color((color_r + 140)%255, color_g, color_b);
    for (int x = 0; x < table.getRowCount(); x++) {
      // TableRow row = table.getRow(x);
      try {
        int y = table.getRow(x).getInt(0);
        allDataPoints.add(new Datapoint(space_left + x * tableCellWidth, height - (space_bottom + y * tableCellHeight), y));
        // allDataPoints.get(allDataPoints.size()-1).defaultColor = colorList[column];
        // print(allDataPoints.get(allDataPoints.size() - 1).xPos + " " + allDataPoints.get(allDataPoints.size() - 1).yPos);
      } catch (Exception e) {
        print(e);
      }
    }
  }
  print(allDataPoints.size() + " data points found.");

}

function draw() {
  //------------------------ GENERAL ---------------------------------------------
  background(0);

  // help text
  fill(255);
  textAlign(LEFT, BOTTOM);
  textSize(14);
  text("DATA SONOGRAM MODEL SPACE v.1.0 by David Unland", 20, 20);
  textSize(12);
  text("press left mouse button to excite the data space", 20, 32);

  //----------------------- DRAW PROPAGATING SIGNALS -----------------------------
  if (list_of_signals.length() > 0) {

    // draw signals
    for (Signal sig: list_of_signals) {
      sig.propagateSignal();
      sig.checkIntersection();
      sig.drawSignal();
    }


    // destroy signals that have reached limit
    for (int i = 0; i < list_of_signals.length(); i++) {
      if (list_of_signals[i].signal_magnitude > maxSignalExtent) {
        list_of_signals.remove(i);
      }
    }
  }


  // ------------------------ DRAW AXIS-----------------------------------------

  // ---------------------------x-axis:
  // base line
  stroke(255, 255, 255, 50);
  line(space_left, height - space_bottom, width - space_right, height - space_bottom);

  // ticks
  int x_spacer = table.getRowCount() / 20;
  for (int x_tick = 0; x_tick < table.getRowCount(); x_tick += x_spacer) {
    stroke(255, 255, 255, 50);
    line(space_left + x_tick * tableCellWidth, space_top, space_left + x_tick * tableCellWidth, height - space_bottom);

    // tick labels
    fill(255, 255, 255, 150);
    textAlign(CENTER, CENTER);
    text(x_tick, space_left + x_tick * tableCellWidth, height - space_bottom + 10);
  }

  // ---------------------------y-axis:
  stroke(255, 255, 255, 50);
  int y_spacer = (int) tableMaxValue / 10;
  for (int y_tick = 0; y_tick < tableMaxValue; y_tick += y_spacer) {
    line(space_left, height - space_bottom - y_tick * tableCellHeight, width - space_right, height - space_bottom - y_tick * tableCellHeight);

    // tick labels
    textAlign(RIGHT, CENTER);
    text(y_tick, space_left, height - space_bottom - y_tick * tableCellHeight);
  }


  // ------------------------ DRAW DATA-----------------------------------------
  // float cell_x = space_left + tableCellWidth;
  // for (TableRow row : table.rows())
  // {
  //         float cell_y = tableCellHeight * row.getInt(0) + space_top;
  //         stroke(63, 58, 223);
  //         fill(153, 218, 238);
  //         ellipse(cell_x, height - cell_y, 5, 5);
  //         cell_x += tableCellWidth;
  //         // cell_y += tableCellHeight;
  // }
  for (Datapoint dp: allDataPoints) {
    dp.draw();
    dp.cooldown();
  }
  //------------------------------- DRAW MOUSE ACTION --------------------------

  if (list_of_signals.size() == 0) {

    noFill();
    stroke(255);
    ellipse(mouseX, mouseY, maxSignalExtent, maxSignalExtent);
  }
}

function mouseIsPressed() {
  list_of_signals.add(new Signal(mouseX, mouseY));
}

function mouseWheel(MouseEvent event) {
  if (event.getCount() > 0 && maxSignalExtent > 0) maxSignalExtent -= 10;
  if (event.getCount() < 0) maxSignalExtent += 10;
}

class Signal {
  int signal_magnitude = 0;
  PVector position;

  int xPos, yPos;
  Signal(int x_in, int y_in) {
    xPos = x_in;
    yPos = y_in;
    position = new PVector(xPos, yPos);
  }

  function propagateSignal() {
    signal_magnitude += signalGrowthSpeed;
  }

  function drawSignal() {
    noFill();
    stroke(255);
    ellipse(xPos, yPos, signal_magnitude, signal_magnitude);
  }

  function checkIntersection() {
    for (Datapoint dp: allDataPoints) {

      if (abs(PVector.dist(this.position, dp.position)) - 3 <= signal_magnitude / 2 &&
        abs(PVector.dist(this.position, dp.position)) + 3 >= signal_magnitude / 2 && !dp.alreadyIntersected) {
        activeDataPoints.add(dp);
        int countIntersections = activeDataPoints.size();
        print("active intersections: " + countIntersections);
        dp.alreadyIntersected = true;
        dp.intersectionTime = millis() + 200;
        print(millis() + " " + dp.value + " intersect!");
        dp.sound.play(dp.value * data_to_freq_ratio, 0.2);
      }


    }
  }
}

ArrayList < Datapoint > allDataPoints = new ArrayList < Datapoint > ();
ArrayList < Datapoint > activeDataPoints = new ArrayList < Datapoint > (); // holds Datapoints that play sound (i.e. they are in "cooldown")

class Datapoint {
  // data content
  let value;

  // position and graphics
  let xPos, yPos;
  PVector position;
  color defaultColor;
  color strokeColor = color(63, 58, 223);

  // intersection with signal
  boolean alreadyIntersected = false;
  int intersectionTime = 0;

  // making sound
  TriOsc sound = new TriOsc(data_sonogram_model_space.this);

  Datapoint(float x_in, float y_in, int val_in) {
    value = val_in;
    xPos = x_in;
    yPos = y_in;
    position = new PVector(xPos, yPos);
  }

  function draw() {
    stroke(color(strokeColor));
    fill(153, 218, 238);
    ellipse(xPos, yPos, 5, 5);
  }

  function cooldown() {
    if (millis() < intersectionTime) {
      strokeColor = color(58, 223, 174);
    } else {
      strokeColor = color(63, 58, 223);
      sound.stop();
      alreadyIntersected = false;
      activeDataPoints.remove(this);
    }
  }
}
