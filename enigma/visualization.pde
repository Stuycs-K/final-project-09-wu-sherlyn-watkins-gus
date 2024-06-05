void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
    curMessage = theEvent.getStringValue();
  }
}

// splits rotor for easy printing
String[] rotorSplitter(Rotor rotor) {
  String rotorLetters = rotor.letters();
  int curLetterPos = rotor.curLetterPos();
  //println("CURLETTERPOS: " + curLetterPos);
  String[] rotorParts = new String[3];
    print("notntter: ");
    rotorParts[0] = rotorLetters.substring(0,curLetterPos);
    print(rotorParts[0]);
    rotorParts[1] = Character.toString(rotorLetters.charAt(curLetterPos));
    print(rotorParts[1]);
    rotorParts[2] = rotorLetters.substring(curLetterPos+1);
    println(rotorParts[2]);
  return rotorParts;
}

// prints a rotor with greentext
void rotorPrinter(String[] rotorVisuals, int text_height, char curChar) {
  int counter = 0;
  print("printter: ");
    while (counter < rotorVisuals[0].length()) {
      print(Character.toString((rotorVisuals[0].charAt(counter) + curChar -65)));
      text(rotorVisuals[0].charAt(counter),300+(20*counter),text_height); //default text_height: 420
      counter++;
    }
    fill(0,255,0);
    print(rotorVisuals[1]);
    text(rotorVisuals[1],300+(20*counter),text_height);
    counter++;
    fill(255,255,255);
    while (counter < rotorVisuals[2].length()) {
      print(rotorVisuals[2].charAt(counter));
      text(rotorVisuals[2].charAt(counter),300+(20*counter),text_height);
      counter++;
    }
    println();
}
