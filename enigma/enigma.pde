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
// physical layout: reflector 1 2 3
Rotor rotor1, rotor2, rotor3;

String reflector = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

Map<Character, Character> plugboard = new Hashtable<>();

void setup() {
  print("yo soy setup");
  size(1000,1000);
  cp5 = new ControlP5(this);
  // plugboard.put('A', 'B');
  // plugboard.put('B', 'A');
  rotor1 = new Rotor(1, 0, 0);
  rotor2 = new Rotor(2, 0, 0);
  rotor3 = new Rotor(3, 0, 0);
  enigma('A');  
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
  modified = testStepCipher(liveInput);
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

// temp two-step cipher: first the char goes through rot13, then the char goes through rot1
String testStepCipher(String sbeve) {
  String modInput = "";
  for (int i = 0; i < sbeve.length(); i++) {
    // first step
    int newInt = Character.toLowerCase(sbeve.charAt(i))+13;
    if (newInt > 122) {
      newInt -= 26;
    }
    // second step
    newInt = newInt+1;
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

Character plugboard(Character pchar) {
    if (plugboard.get(pchar) != null) return plugboard.get(pchar);
    return pchar;
}

Character rotors(Character pchar) {
   rotor3.rotate();
   if (rotor3.onNotch()) {
     rotor2.rotate();
     if (rotor2.onNotch()) {
       rotor1.rotate();
     }
   }
   println("Rotors Position: ", (char)(rotor1.rotorpos + 65), (char)(rotor2.rotorpos + 65), (char)(rotor3.rotorpos + 65));
  
   pchar = rotor3.apply(pchar);
   println("Wheel 3 Encryption: ", pchar);
   pchar = rotor2.apply(pchar);
   println("Wheel 2 Encryption: ", pchar);
   pchar = rotor1.apply(pchar);
   println("Wheel 1 Encryption: ", pchar);
   // TODO: reflect
   return pchar;
}

Character enigma(Character pchar) {
  println("Keyboard Input: ", pchar);
  pchar = plugboard(pchar);
  println("Plugboard Encryption: ", pchar);
  pchar = rotors(pchar);
  pchar = plugboard(pchar);
  return pchar;
}
