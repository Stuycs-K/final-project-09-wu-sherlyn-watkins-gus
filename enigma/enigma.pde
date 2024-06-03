// NOTE: DOWNLOAD CONTROLP5 LIBRARY
import controlP5.*;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.Map;

ControlP5 cp5;
int counter = 0;
String curMessage = ""; // tracks plaintext input
String modified = ""; // tracks modified input
char stepMod; // tracks stepping modified input
int stepState = 0; // tracks what step it's on
int stepNum = 2; // CHANGE THIS, tracks how many steps the cipher requires
String prevInput = ""; // previous input to prevent multiple calls
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
  //enigma('A');  
  PImage start_button = loadImage("togedepressed.png");
  
     
  cp5.addButton("activate")
     .setValue(0)
     .setPosition(100,150)
     //.setImage(activate_button)
     .setSize(300,50)
     ;
     
  cp5.addButton("step")
     .setValue(0)
     .setPosition(100,200)
     .setSize(300,50)
     ;
     
  cp5.addTextfield("input")
     .setPosition(100,100)
     .setSize(200,40)
     .setFocus(true)
     .setColor(color(255,0,0))
     ;
     
  cp5.addButton("progress")
     .setValue(0)
     .setPosition(300,100)
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
    //println("step increase");
    counter++;
  }
}

// reset
public void progress() {
  curMessage = "";
  modified = "";
  stepMod = 0;
  counter = 0;
  stepping = false;
}

public void input(String text) {
    curMessage = text;
}

void draw() {
  background(color(0));
  noStroke();
  PImage UIdes = loadImage("enigma.png"); 
  image(UIdes, 0, 0);
  
  textSize(25);
  text("Type a message to encrypt and press enter to confirm", 400, 675);
  text("Click togedepressed.png to reset last input", 400, 725);
  //String curMessage = cp5.get(Textfield.class,"input").getText();
  text("Input: " + curMessage, 400, 775);
  if (stepping) {
    if (counter < curMessage.length()*stepNum) {
      int tempInt = (char)enigmaTemp(curMessage.charAt(counter/stepNum),counter%stepNum);
      //int tempInt = (char)testStepCipherChar(curMessage.charAt(counter/stepNum),counter%stepNum);
      stepMod = (char)tempInt;
      text("Stepping input: "+modified.substring(0,counter/stepNum)+stepMod, 400,825);
      text("Step: "+(counter%stepNum+1), 400, 875);
    } else {
      text("Stepping input: "+modified+" (steps complete)", 400,825); 
    }
  } else {
    if (prevInput.compareTo(curMessage) != 0) {
      modified = enigmaCipher(curMessage,999);
      //modified = testStepCipher(curMessage,999);
      prevInput = curMessage;
    }
    text("Stepping not activated", 400,825);
  }
  text("Modified: " + modified, 400,925);
  text("Stepping status: " + stepping, 400, 975);
  text("Rotor 3: " + rotor1.letters(), 200,420);
  text("Rotor 2: " + rotor2.letters(), 200,520);
  text("Rotor 1: " + rotor3.letters(), 200,620);
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
    curMessage = theEvent.getStringValue();
  }
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

// temp two-step cipher: first the char goes through rot12, then the char goes through rot1
String testStepCipher(String sbeve, int stepPart) {
  String modInput = "";
  for (int i = 0; i < sbeve.length(); i++) {
      int newInt = testStepCipherChar(sbeve.charAt(i),stepPart);
      modInput = modInput + (char)newInt;
  }
  return modInput;
}

// temp char by char for the cipher: first the char goes through rot12, then the char goes through rot1
int testStepCipherChar(char sbeve, int stepPart) {
  // immediately returns newInt if it's not a letter
  if (!Character.isLetter(sbeve)) {
    return sbeve;
  }
  int newInt = Character.toLowerCase(sbeve);
      // first step
      if (stepPart >= 0) {
      newInt+=12;
      if (newInt > 122) {
        newInt -= 26;
      }
      } if (stepPart >= 1) {
      // second step
      newInt+=1;
      if (newInt > 122) {
        newInt -= 26;
      }
      }
  return newInt;
}


// temporary enigma cipher for testing
String enigmaCipher(String sbeve, int stepPart) {
  String modInput = "";
  println("am inside");
  for (int i = 0; i < sbeve.length(); i++) {
      int newInt = enigmaTemp(sbeve.charAt(i),stepPart);
      modInput = modInput + (char)newInt;
  }
  return modInput;
}

// temp cipher 2: electric boogaloo
int enigmaTemp(Character pchar, int stepPart) {
  // immediately returns newInt if it's not a letter
  if (!Character.isLetter(pchar)) {
    return pchar;
  }
  if (stepPart >= 0) {
  pchar = plugboard(pchar);
  } if (stepPart >= 1) {
  pchar = rotors(pchar);
  } if (stepPart >= 2) {
  pchar = plugboard(pchar);
  }
  return pchar;
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
