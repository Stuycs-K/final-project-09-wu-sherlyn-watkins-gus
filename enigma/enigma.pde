// NOTE: DOWNLOAD CONTROLP5 LIBRARY

import controlP5.*;

ControlP5 cp5;
int counter = 0;

void setup() {
  size(1000,1000);
  cp5 = new ControlP5(this);
  
  PImage start_button = loadImage("togedepressed.png");
  
  cp5.addButton("leCounter")
     .setValue(0)
     .setPosition(400,400)
     .setImage(start_button)
     .setSize(300,50)
     ;
}

public void leCounter() {
  println("I've been pressed");
  counter++;
}

void draw() {
  background(color(0));
  noStroke();
  
  text("Number of times clicked: " + counter, 400, 100);
  
  /**
  // Old button code
  fill(105);
  
  fill(color(155,155,155));
  boolean clicked = false;
  // if mouse is over button, light up the button
  if (1050 < mouseX && mouseX < 1450 && 850 < mouseY && mouseY < 950) {
    fill(color(255));
    clicked = true;
  }
  rect(1050,850,400,100);
  if (clicked) {
    fill(color(255));
    text("Bazinga!", 1050, 300);
  }
  
    
  // Draws the dialogue to the box
  fill(color(255));
  textSize(25);
  text("Click to progress machine :)", 1050, 200);
  **/
}
