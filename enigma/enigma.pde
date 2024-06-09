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
int stepNum = 9; // CHANGE THIS, tracks how many steps the cipher requires
String prevInput = ""; // previous input to prevent multiple calls
int prevCounter = -1; // previous counter to prevent multiple calls
String[][][] enigmaPackets = new String[10][9][4]; // global list of enigma packets, 10 is a placeholder
int globalChar = 0; // char # Stepping is currently on
boolean stepping = false;

// cipher parts
// physical layout: reflector 1 2 3
Rotor rotor1, rotor2, rotor3;
Rotor[] rotors = {rotor3,rotor2,rotor1};
String ukwb = "YRUHQSLDPXNGOKMIEBFZCWVJAT";
String reflector = ukwb;
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
  rotor3.reset();
  rotor2.reset();
  rotor1.reset();
  stepping = true;
  println("Stepping status: " + stepping);
}

// go step by step
public void step() {
  if (stepping) {
    //println("step increase");
    stepState++;
    if (stepState >= stepNum) {
      stepState = 0;
    }
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
  enigmaPackets = new String[10][9][4];
  globalChar = 0;
  rotor3.reset();
  rotor2.reset();
  rotor1.reset();
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
  
  // text("test", 600, 90);
  //plugboard.put('A', 'B');
  //plugboard.put('B', 'A');
  //plugboard.put('Z', 'C');
  //plugboard.put('C', 'Z');
  // assuming plugboard connections are always 2-way, and that entries are next to each other
  int plugboardloc = 0;
  for (Map.Entry<Character, Character> entry : plugboard.entrySet()) {
    println("in", plugboardloc);
    if (plugboardloc % 2 != 0) {
      plugboardloc++;
      continue;
    };
    text(entry.getKey() + "<->" + entry.getValue(), 600, 70 + 10 * plugboardloc);
    plugboardloc++;
  }
  
  //String curMessage = cp5.get(Textfield.class,"input").getText();
  text("Input: " + curMessage, 400, 775);
  
  // if stepping
  if (stepping) {
    if (counter < curMessage.length()*stepNum) {
      if (prevCounter != counter) {
      //print("printing enigma packet: ");
      //printEnigmaPacket(enigmaPackets[counter/stepNum][stepState]);
      //printEnigmaPackets(enigmaPackets[counter/stepNum]);
      stepMod = enigmaPackets[counter/stepNum][stepState][0].charAt(0);
      println("stepmod: " + stepMod);
      prevCounter = counter;
      }
      text("Stepping input: "+modified.substring(0,counter/stepNum)+stepMod, 400,825);
      text("Step: "+(counter%stepNum+1), 400, 875);
    } else {
      text("Stepping input: "+modified+" (steps complete)", 400,825); 
    }
  } 
  
  // if not stepping
  else {
    if (prevInput.compareTo(curMessage) != 0) {
      enigmaPackets = new String[curMessage.length()][9][4]; // reset the packets
      curMessage = curMessage.toUpperCase();
      modified = enigmaCipher(curMessage,999);
      //modified = testStepCipher(curMessage,999);
      prevInput = curMessage;
      //for (int i = 0; i < curMessage.length(); i++) {
        //printEnigmaPackets(enigmaPackets[i]);
      //}
    }
    text("Stepping not activated", 400,825);
  }
  text("Modified: " + modified, 400,925);
  text("Stepping status: " + stepping, 400, 975);
  
  // for reference: stepMod = enigmaPackets[counter/stepNum][stepState][0].charAt(0);
  // prints rotors
  String[] rotorVisuals = rotorSplitter(rotor3);
  text("Rotor 3: ",200,420 + 100*0);
  if (modified.length() > 0) {
    rotorPrinter(rotorVisuals,420,modified.charAt(modified.length()-1));
  } else {
    text("Rotor 3: " + rotor3.letters(), 200,420);
  }
  rotorVisuals = rotorSplitter(rotor2);
  text("Rotor 2: ",200,520);
  if (modified.length() > 0) {
    rotorPrinter(rotorVisuals,520,modified.charAt(modified.length()-1));
  } else {
    text("Rotor 2: " + rotor2.letters(), 200,520);
  }
  rotorVisuals = rotorSplitter(rotor1);
  text("Rotor 1: ",200,620);
  if (modified.length() > 0) {
    rotorPrinter(rotorVisuals,620,modified.charAt(modified.length()-1));
  } else {
    text("Rotor 1: " + rotor1.letters(), 200,620);
  }
}

String clean(String str) {
  return str.replaceAll("[^a-zA-Z0-9]", "");  
}

Character plugboard(Character pchar) {
    if (plugboard.get(pchar) != null) return plugboard.get(pchar);
    return pchar;
}

Character rotors(Character pchar) {
   String[][] enigmaPacket = new String[9][4];
   // format: current character, rotor3 position, rotor2 position, rotor1 position
   // 0 - initial
   // 1 - rotors rotate
   // 2-4 - character is put through rotors
   // 5 - character is reflected
   // 6-8 - character is put through rotors
   
   enigmaPacket[0] = new String[] {String.valueOf(pchar),String.valueOf(rotor3.rotorpos),String.valueOf(rotor2.rotorpos),String.valueOf(rotor1.rotorpos)};
   
   rotor3.rotate();
   if (rotor3.onNotch()) {
     rotor2.rotate();
     if (rotor2.onNotch()) {
       rotor1.rotate();
     }
   }
   println("Rotors Position: ", (char)(rotor1.rotorpos + 65), (char)(rotor2.rotorpos + 65), (char)(rotor3.rotorpos + 65));
   enigmaPacket[1] = new String[] {String.valueOf(pchar),String.valueOf(rotor3.rotorpos),String.valueOf(rotor2.rotorpos),String.valueOf(rotor1.rotorpos)};
   
   pchar = rotor3.forward(pchar);
   println("Wheel 3 Encryption: ", pchar);
   enigmaPacket[2] = new String[] {String.valueOf(pchar),String.valueOf(rotor3.rotorpos),String.valueOf(rotor2.rotorpos),String.valueOf(rotor1.rotorpos)};
   pchar = rotor2.forward(pchar);
   println("Wheel 2 Encryption: ", pchar);
   enigmaPacket[3] = new String[] {String.valueOf(pchar),String.valueOf(rotor3.rotorpos),String.valueOf(rotor2.rotorpos),String.valueOf(rotor1.rotorpos)};
   pchar = rotor1.forward(pchar);
   println("Wheel 1 Encryption: ", pchar);
   enigmaPacket[4] = new String[] {String.valueOf(pchar),String.valueOf(rotor3.rotorpos),String.valueOf(rotor2.rotorpos),String.valueOf(rotor1.rotorpos)};

   pchar = reflector.charAt(pchar - 65);
   println("Reflector: ", pchar);
   enigmaPacket[5] = new String[] {String.valueOf(pchar),String.valueOf(rotor3.rotorpos),String.valueOf(rotor2.rotorpos),String.valueOf(rotor1.rotorpos)};
      
   pchar = rotor1.backward(pchar);
   println("Wheel 1 Encryption: ", pchar);
   enigmaPacket[6] = new String[] {String.valueOf(pchar),String.valueOf(rotor3.rotorpos),String.valueOf(rotor2.rotorpos),String.valueOf(rotor1.rotorpos)};
   pchar = rotor2.backward(pchar);
   println("Wheel 2 Encryption: ", pchar);
   enigmaPacket[7] = new String[] {String.valueOf(pchar),String.valueOf(rotor3.rotorpos),String.valueOf(rotor2.rotorpos),String.valueOf(rotor1.rotorpos)};
   pchar = rotor3.backward(pchar);
   println("Wheel 3 Encryption: ", pchar);
   enigmaPacket[8] = new String[] {String.valueOf(pchar),String.valueOf(rotor3.rotorpos),String.valueOf(rotor2.rotorpos),String.valueOf(rotor1.rotorpos)};
   for (int i = 0; i < 9; i++) {
     //println("enter packet assigning");
     enigmaPackets[globalChar][i] = enigmaPacket[i];
   }
   globalChar++;
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
