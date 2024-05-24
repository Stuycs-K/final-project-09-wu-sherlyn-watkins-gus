// NOTE: DOWNLOAD CONTROLP5 LIBRARY
import controlP5.*;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.Map;

ControlP5 cp5;
int counter = 0;
String curMessage = "";
String modified = "";
String plaintext = "MY FUNNY PLAINTEXT A B";
Map<Character, Character> plugboard = new Hashtable<>();

void setup() {
  print("yo soy setup");
  size(1000,1000);
  cp5 = new ControlP5(this);
  plugboard.put('A', 'B');
  plugboard.put('B', 'A');
  plugboard(plaintext);
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
  modified = "";
  counter++;
}

public void input(String text) {
  
  curMessage = text;
}

void draw() {
  //println("je suis draw");
  background(color(0));
  noStroke();
  
  textSize(25);
  text("Click togedepressed.png to reset last input", 400, 100);
  String liveInput = cp5.get(Textfield.class,"input").getText();
  if (!liveInput.isEmpty()) {
    //text("Plugboard says: " + plugboard(liveInput), 400, 300);
      modified = modified + (char)(liveInput.charAt(liveInput.length()-1) + 20);
    // issue: don't use modified = modified + format
  }
  text("Modified: " + modified, 400,200);
  text("Live input: "+liveInput, 400,150);
  text("Last input: " + curMessage, 400, 250);
  text("Number of times clicked: " + counter, 400, 300);
  
  if (counter%10==0) {
    text("hhghhgg", 400, 350);
  }
}

String plugboard(String ptext) {
    //println("Plugboard");
    //plugboard.forEach((k, v) -> {
    //  println(k + ": " + v);
    //});
    StringBuilder str = new StringBuilder();
    str.append(ptext);
    for (int i = 0; i < plaintext.length(); i++) {
      if (plugboard.containsKey(ptext.charAt(i))) {
        str.setCharAt(i,plugboard.get(ptext.charAt(i)));
      }
    }
    ptext = str.toString();
    return ptext;
}
