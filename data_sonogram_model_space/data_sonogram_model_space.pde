import processing.sound.*;

// PGraphics offscreen;

//SIGNAL VARIABLES
ArrayList<Signal> list_of_signals = new ArrayList<Signal>();
int maxSignalExtent;
int signalGrowthSpeed = 2;

// TABLE DISPLAY
int space_top = 80;
int space_bottom = 40;
int space_left = 80;
int space_right = 40;

// INPUT DATA VARIABLES
Table table;
float tableCellWidth;
float tableCellHeight;
double tableMaxValue = Double.NEGATIVE_INFINITY;
int dataColumn = 1; // TODO: get right column automatically
float dataStep = 1;
// DATA TO SOUND
float data_to_freq_ratio; // maps tableMaxValue to 1000 Hertz
int max_freq = 1000; // in Hertz
float loudness = 0.7; // loudness for sound playback

void setup()
{
        size(800,600, P2D);
        // offscreen = createGraphics(800,600);
        maxSignalExtent = width/3;

        //-------------------------- SETUP THE INPUT DATA
        // table = loadTable("data.csv", "header");
        table = loadTable("sea_ice_northpole_2018.csv", "header");
        tableCellWidth = (width - (space_left + space_right)) / float(table.getRowCount());

        // dataStep = (table.getRowCount() > 1000) ? table.getRowCount() / 1000 : 1;
        println("dataStep = " + dataStep);

        for (TableRow row : table.rows())
        {
                try {
                        println(row.getInt(dataColumn));
                        tableMaxValue = (row.getInt(dataColumn) > tableMaxValue) ? row.getInt(dataColumn) : tableMaxValue;
                } catch(Exception e) {
                        println("Error:" + e);
                }
        }
        tableCellHeight = (height - (space_top + space_bottom)) / (float) tableMaxValue;
        println("max value in table is ", tableMaxValue);
        println("tableCellWidth = ", tableCellWidth, "tableCellHeight = ", tableCellHeight);
        data_to_freq_ratio = max_freq / (float)tableMaxValue;


//-------------------- DATAPOINT OBJECTS ---------------------------------------
        int color_r = 63;
        int color_g = 58;
        int color_b = 223;
        for (int column = 0; column<table.getColumnCount(); column++)
        {
                // TODO: color allocation for multiple columns
                color[] colorList = new color[table.getColumnCount()];
                // colorList[0] = color((color_r + 140)%255, color_g, color_b);
                for (int x = 0; x<table.getRowCount(); x+=dataStep)
                {
                        // TableRow row = table.getRow(x);
                        try {
                                int y = table.getRow(x).getInt(dataColumn);
                                allDataPoints.add(new Datapoint(space_left + x * tableCellWidth, height - (space_bottom + y * tableCellHeight), y));
                                // allDataPoints.get(allDataPoints.size()-1).defaultColor = colorList[column];
                                // println(allDataPoints.get(allDataPoints.size() - 1).xPos + " " + allDataPoints.get(allDataPoints.size() - 1).yPos);
                        } catch(Exception e) {
                                println(e);
                        }
                }
        }
        println(allDataPoints.size() + " data points found.");

}

void draw()
{
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
        if (list_of_signals.size() > 0) {

                // draw signals
                for (Signal sig : list_of_signals) {
                        sig.propagateSignal();
                        sig.checkIntersection();
                        sig.drawSignal();
                }


                // destroy signals that have reached limit
                for (int i = 0; i<list_of_signals.size(); i++)
                {
                        if (list_of_signals.get(i).signal_magnitude > maxSignalExtent) {
                                list_of_signals.remove(i);
                        }
                }
        }


// ------------------------ DRAW AXIS-------------------------------------------

        // ---------------------------x-axis:
        // base line
        stroke(255,255,255, 50);
        line(space_left, height - space_bottom, width - space_right, height - space_bottom);

        // ticks
        int x_spacer = table.getRowCount() / 20;
        for (int x_tick = 0; x_tick<table.getRowCount(); x_tick+= x_spacer)
        {
                stroke(255, 255, 255,50);
                line(space_left + x_tick*tableCellWidth, space_top, space_left + x_tick*tableCellWidth, height - space_bottom);

                // tick labels
                fill(255,255,255,150);
                textAlign(CENTER, CENTER);
                text(x_tick, space_left+x_tick*tableCellWidth, height - space_bottom + 10);
        }

        // ---------------------------y-axis:
        stroke(255,255,255,50);
        int y_spacer = (int)tableMaxValue / 10;
        for (int y_tick = 0; y_tick<tableMaxValue; y_tick+=y_spacer) {
                line(space_left, height - space_bottom - y_tick*tableCellHeight, width - space_right, height - space_bottom - y_tick*tableCellHeight);

                // tick labels
                textAlign(RIGHT, CENTER);
                text(y_tick, space_left, height - space_bottom - y_tick * tableCellHeight);
        }


// ------------------------ DRAW DATA-------------------------------------------
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
        // offscreen.beginDraw();
        for (Datapoint dp : allDataPoints ) {
                dp.draw();
        }
        // offscreen.endDraw();
        for (Datapoint adp : selectedDatapoints ) {
                adp.cooldown();
        }
//------------------------------- DRAW MOUSE ACTION ----------------------------

        if (list_of_signals.size() == 0)
        {

                noFill();
                stroke(255);
                ellipse(mouseX, mouseY, maxSignalExtent, maxSignalExtent);
        }
}

void mousePressed()
{
        list_of_signals.add(new Signal(mouseX, mouseY));

        for (Datapoint datap : allDataPoints)
        {
                if (PVector.dist(datap.position, list_of_signals.get(list_of_signals.size()-1).position) <= maxSignalExtent * 2)
                {
                        selectedDatapoints.add(datap);
                }
        }
}

void mouseWheel(MouseEvent event)
{
        if (event.getCount() > 0 && maxSignalExtent > 0) maxSignalExtent -= 10;
        if (event.getCount() < 0) maxSignalExtent += 10;
}
