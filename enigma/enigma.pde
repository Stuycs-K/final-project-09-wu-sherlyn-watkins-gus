// NOTE: DOWNLOAD CONTROLP5 LIBRARY

import controlP5.*;

ControlP5 cp5;
int counter = -1;
String curMessage = "";

void setup() {
  size(1000,1000);
  cp5 = new ControlP5(this);
  
  PImage start_button = loadImage("togedepressed.png");
  
  cp5.addButton("progress")
     .setValue(0)
     .setPosition(400,400)
     .setImage(start_button)
     .setSize(300,50)
     ;
     
  cp5.addTextfield("input")
     .setPosition(20,100)
     .setSize(200,40)
     .setFocus(true)
     .setColor(color(255,0,0))
     ;
}

public void progress() {
  curMessage = "";
  counter++;
}

public void input(String text) {
  curMessage = text;
}

void draw() {
  background(color(0));
  noStroke();
  
  textSize(25);
  text("Click togedepressed.png to reset last input", 400, 100);
  text("Last input: " + curMessage, 400, 150);
  text("Number of times clicked: " + counter, 400, 200);
  
  if (counter%10==0) {
    text("hhghhgg", 400, 300);
  }
}
