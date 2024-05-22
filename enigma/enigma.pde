void setup() {
  size(1500,1000);
}


void draw() {
  background(color(0));
  //noStroke();
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
}
