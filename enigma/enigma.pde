// NOTE: DOWNLOAD CONTROLP5 LIBRARY
import controlP5.*;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.Map;

ControlP5 cp5;
int counter = 0;
String curMessage = "";
String modified = "";
boolean stepping = false;

String plaintext = "MY FUNNY PLAINTEXT A B";

String rotor1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
String rotor2 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
String rotor3 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

int rotor1initial, rotor2initial, rotor3initial = 0;
int rotor1pos = rotor1initial;
int rotor2pos = rotor2initial;
int rotor3pos = rotor3initial;

String reflector = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

Map<Character, Character> plugboard = new Hashtable<>();

void setup() {
  print("yo soy setup");
  size(1000,1000);
  cp5 = new ControlP5(this);
  plugboard.put('A', 'B');
  plugboard.put('B', 'A');
  plugboard(plaintext);
  PImage start_button = loadImage("togedepressed.png");
  PImage activate_button = loadImage("steg test.png");
     
  cp5.addButton("activate")
     .setValue(0)
     .setPosition(200,400)
     //.setImage(activate_button)
     .setSize(300,50)
     ;
     
  cp5.addButton("step")
     .setValue(0)
     .setPosition(200,450)
     .setSize(300,50)
     ;
     
  cp5.addTextfield("input")
     .setPosition(20,100)
     .setSize(200,40)
     .setFocus(true)
     .setColor(color(255,0,0))
     ;
     
  cp5.addButton("progress")
     .setValue(0)
     .setPosition(600,400)
     .setImage(start_button)
     .setSize(300,50)
     ;
}

// activate stepping mode
public void activate() {
  stepping = true;
  println("Stepping status: " + stepping);
}

// go step by step
public void step() {
  if (stepping) {
    counter++;
  }
}

// reset
public void progress() {
  curMessage = "";
  modified = "";
  counter = 0;
  stepping = false;
}

public void input(String text) {
    curMessage = text;
}

void draw() {
  //println("je suis draw");
  background(color(0));
  noStroke();
  
  textSize(25);
  text("Clear textbox before stepping through another input!", 400, 50);
  text("Click togedepressed.png to reset last input", 400, 100);
  String liveInput = cp5.get(Textfield.class,"input").getText();
  text("Input: " + liveInput, 400, 150);
  modified = testCipher(liveInput);
  if (stepping) {
    if (counter < modified.length()) {
      text("Stepping input: "+modified.substring(0,counter), 400,200);
    } else {
      text("Stepping input: "+modified+" (steps complete)", 400,200); 
    }
  } else {
    text("Stepping not activated", 400,200);
  }
  text("Modified: " + modified, 400,250);
  text("Stepping status: " + stepping, 400, 300);
}

// temp rot13 cipher for testing
String testCipher(String sbeve) {
  String modInput = "";
  for (int i = 0; i < sbeve.length(); i++) {
    int newInt = Character.toLowerCase(sbeve.charAt(i))+13;
    if (newInt > 122) {
      newInt -= 26;
    }
    modInput = modInput + (char)newInt;
  }
  return modInput;
}

String clean(String str) {
  return str.replaceAll("[^a-zA-Z0-9]", "");  
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

String rotors(String ptext) {
  StringBuilder str = new StringBuilder();
  str.append(ptext);
  for (int i = 0; i < plaintext.length(); i++) {
    // currently being refactored to classes to better manage ring settings and all of that
    rotor1pos = (rotor1pos + 1) % 26;
    if (rotor1pos == 0) rotor2pos = (rotor2pos + 1) % 26;
    if (rotor2pos == 0) rotor3pos = (rotor3pos + 1) % 26;
    
    // first rotor runthru 1->3
    str.setCharAt(i, rotor1.charAt((str.charAt(i) - 65 + rotor1pos) % 26));
    str.setCharAt(i, rotor2.charAt((str.charAt(i) - 65 + rotor2pos) % 26));
    str.setCharAt(i, rotor3.charAt((str.charAt(i) - 65 + rotor3pos) % 26));
    
    // reflect
    str.setCharAt(i, reflector.charAt((str.charAt(i) - 65) % 26));
    
    // and go back through 3->1
    str.setCharAt(i, rotor3.charAt((str.charAt(i) - 65 + rotor3pos) % 26));
    str.setCharAt(i, rotor2.charAt((str.charAt(i) - 65 + rotor2pos) % 26));
    str.setCharAt(i, rotor1.charAt((str.charAt(i) - 65 + rotor1pos) % 26));
  }
  // physical layout: reflector 3 2 1
  // run shift w rotor1
  // if at certain pos, shift rotor2
  // run shift with rotor2
  // if at certain pos, shift rotor3
  // run shift with rotor3
  // reflect and do the same thing in other direction
  // TODO: split into function w classes later w sig runRotor(Rotor rotor, Rotor nextrotor) with nextrotor sometimes being null (if on r3)
  // reset rotor positions to settings for next encode
  rotor1pos = rotor1initial;
  rotor2pos = rotor2initial;
  rotor3pos = rotor3initial;
  return ptext;
}

String enigma(String ptext) {
  ptext = plugboard(ptext);
  ptext = rotors(ptext);
  ptext = plugboard(ptext);
  return ptext;
}
