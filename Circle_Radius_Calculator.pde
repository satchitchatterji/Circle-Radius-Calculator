//import image
//calibrate
//choose 3 points
//calculate radius
//display radius
//reset points

PImage img;

void setup() {
  //img = loadImage("cc.png");
  size(1920, 1080);
  calibrate();
}
void draw() {
  background(0);
  //image(img, 0,0);
  drawScale();
  drawCalPoints();
  drawPoints();
  drawCircle();
}
void keyPressed() {
  if (key == 'c') {
    calibrate();
  }
  if (key == 'r') {
    record();
  }
}


boolean recorded = false;
float rad = 0;
float centerX = 0, centerY = 0;
void calculateRadius() {
  if (recorded) {
    float x1 = pts[0].x;
    float y1 = pts[0].y;
    float x2 = pts[1].x;
    float y2 = pts[1].y;
    float x3 = pts[2].x;
    float y3 = pts[2].y;
    //http://www.ambrsoft.com/trigocalc/circle3d.htm
    float A = x1*(y2-y3)-y1*(x2-x3)+x2*y3-x3*y2;
    float B = (x1*x1+y1*y1)*(y3-y2)+(x2*x2+y2*y2)*(y1-y3)+(x3*x3+y3*y3)*(y2-y1);
    float C = (x1*x1+y1*y1)*(x3-x2)+(x2*x2+y2*y2)*(x1-x3)+(x3*x3+y3*y3)*(x2-x1);
    float D = (x1*x1+y1*y1)*(x3*y2-x2*y3)+(x2*x2+y2*y2)*(x1*y3-x3*y1)+(x3*x3+y3*y3)*(x2*y1-x1*y2);
    rad = sqrt((B*B+C*C-4*A*D)/(4*A*A));
    centerX = -B/(2*A);
    centerY = C/(2*A);
    println("Cirle Radius = ", rad, "pixels");
    println("Cirle Radius = ", rad/calibrationDistance, "cm");
  }
}
