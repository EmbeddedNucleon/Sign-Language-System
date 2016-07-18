/**
 * Sign language interpretation system
 */

import java.awt.Rectangle;
import processing.video.*;
import gab.opencv.*;

Capture video;
OpenCV opencv;
PImage source;
ArrayList<Contour> contours;
int hue;
int count = 0;
int rangeWidth = 24;
int boundBoxDim = 25;
int numBoundingBoxes;
int[] boxXPosition;
int[] boxYPosition;
PImage output;

void setup() {
  video = new Capture(this, 640, 480);
  opencv = new OpenCV(this, video.width, video.height);
  contours = new ArrayList<Contour>();
  
  size(2*opencv.width, opencv.height, P2D);
  
  video.start();
  
  color c =  color(90,110,90);     //40,180,80);
  println("r: " + red(c) + " g: " + green(c) + " b: " + blue(c));
  hue = int(map(hue(c), 0, 255, 0, 180));
  
}

void draw() {
  
  background(50);
  
    boxXPosition = new int[20];
    boxYPosition = new int[20];
  
  if (video.available()) {
    video.read();
  }

  // Prepare openCV 
  opencv.loadImage(video);
  opencv.useColor();
  source = opencv.getSnapshot();
  opencv.useColor(HSB);
  
  // Create threshold, erosion, contours.
  findColors();
  
  // Show images
  image(source, 0, 0);
  image(output, source.width, 0);
  
  numBoundingBoxes = countBoundingBoxes();
  
  // Print number of fingers held up
  textSize(25);
  stroke(255);
  fill(255);
  text("Number of fingers held up: " + numBoundingBoxes, 10, 25);
  
  displayContoursBBoxes();
  
  if (numBoundingBoxes == 2 && Math.abs(boxXPosition[0]-boxXPosition[1]) > source.width/2 && Math.abs(boxYPosition[0]-boxYPosition[1]) < source.height/3){
    text("Surf's up, dude!",10, 50);
  }
  
  if (numBoundingBoxes == 2 && Math.abs(boxXPosition[0]-boxXPosition[1]) > source.width/5 && Math.abs(boxXPosition[0]-boxXPosition[1]) < source.width/3 && Math.abs(boxYPosition[0]-boxYPosition[1]) < source.height/4){
    text("Peace, man!",10, 50);
  }
  
  if (numBoundingBoxes == 2 && Math.abs(boxYPosition[0]-boxYPosition[1]) > source.height/3 && Math.abs(boxXPosition[0]-boxXPosition[1]) < source.width/5){
    text("Thumbs up!",10, 50);
  }
}

// Threshold, erosin, contours.

void findColors() {
 
    // Threshold
    opencv.loadImage(source);
    opencv.useColor(HSB);
    opencv.setGray(opencv.getH().clone());
    int hueToDetect = hue;
    opencv.inRange(hueToDetect-rangeWidth/2, hueToDetect+rangeWidth/2);
    
    // Background noise reduction
    opencv.erode();
    opencv.erode();
    opencv.erode();
    opencv.erode();
    // opencv.erode();
    // opencv.erode();
    
    // Save image
    output = opencv.getSnapshot();
  
    // Find contours
    if (output != null) {
      opencv.loadImage(output);
      contours = opencv.findContours(true,true);
    }
}

// Create and display bounding boxes

void displayContoursBBoxes() {
  
  for (int i=0; i<contours.size(); i++) {
    
    Contour contour = contours.get(i);
    Rectangle r = contour.getBoundingBox();
    
    if (r.width < boundBoxDim || r.height < boundBoxDim)
      continue;
    
    stroke(255, 0, 0);
    fill(255, 0, 0, 150);
    strokeWeight(2);
    rect(r.x, r.y, r.width, r.height);
    
    boxXPosition[i]=r.x;
    boxYPosition[i]=r.y;
  }
}

// Count the number of bounding boxes

int countBoundingBoxes() {
  
  int count = 0;
  
  for (int i=0; i<contours.size(); i++) {
    Contour contour = contours.get(i);
    Rectangle r = contour.getBoundingBox();
    
    if (r.width >= boundBoxDim || r.height >= boundBoxDim)
      count++;
  }
  return count;
}
