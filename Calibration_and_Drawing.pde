PVector[] pts = new PVector[3];
PVector[] cpts = new PVector[2];
boolean calibrated = false;
float calibrationDistance = 25; //pixel to cm ratio, arbitrary initial value, calculated precisely later
void calibrate() {
  if (calibrated) {
    println("Recalibrating...");
  } else {
    println("Calibrating...");
  }
  calibrated = false;
  clearPoints();
  println("Ready to calibrate!");
  println("Click on two points that are one centimeter apart in the image");
  println("Click on first calibration point...");
}
void drawScale() {
  if (calibrated) {
    stroke(255);
    line(25, height-25, 25+calibrationDistance, height-25);
    text("1cm", 35+calibrationDistance, height-20);
  } else {
    text("Not Calibrated", 35+calibrationDistance, height-20);
  }
}
float lastMouseX=0, lastMouseY=0;
void clearPoints() {
  cpts[0] = new PVector(0, 0);
  cpts[1] = new PVector(0, 0);
  pts[0] = new PVector(0, 0);
  pts[1] = new PVector(0, 0);
  pts[2] = new PVector(0, 0);
  recorded = false;
}
void drawPoints() {
  fill(0, 255, 0);
  for (PVector pt : pts) {
    if (pt.x!=0 && pt.y !=0) {
      ellipse(pt.x, pt.y, 5, 5);
    }
  }
}

void drawCircle() {
  if (recorded) {
    noFill();
    stroke(255);
    ellipse(centerX, centerY, 5, 5);
    ellipse(centerX, centerY, rad*2, rad*2);
  }
}
int currentPoint = 0;
void record() {
  println("Now recording points");
  recorded = false;
  pts[0] = new PVector(0, 0);
  pts[1] = new PVector(0, 0);
  pts[2] = new PVector(0, 0);
  currentPoint = 0;
  println("Enter first point...");
}
void drawCalPoints() {
  if (!calibrated) {
    fill(255, 0, 0);
    ellipse(cpts[0].x, cpts[0].y, 5, 5);
    ellipse(cpts[1].x, cpts[1].y, 5, 5);
  }
}
void mousePressed() {
  if (!calibrated) {
    if (cpts[0].x==0) {
      cpts[0] = new PVector(mouseX, mouseY);
      println("Recorded point ", cpts[0].x, cpts[0].y);
      println("Click on second calibration point...");
    } else {
      cpts[1] = new PVector(mouseX, mouseY);
      println("Recorded point ", cpts[1].x, cpts[1].y);
      calibrated = true;
      calibrationDistance = dist(cpts[0].x, cpts[0].y, cpts[1].x, cpts[1].y);
      println("1cm = ", calibrationDistance, "pixels");
      println("Finished Calibration!");
      println("Ready to record circle points!");
      record();
    }
  } else if (!recorded) {
    pts[currentPoint%3] = new PVector(mouseX, mouseY);
    println("Recorded point ", pts[currentPoint%3].x, pts[currentPoint%3].y);
    currentPoint++;
    if (currentPoint%3 == 0 && currentPoint != 0) {
      recorded = true;
      calculateRadius();
    }
  }
}
