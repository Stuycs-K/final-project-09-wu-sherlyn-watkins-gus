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
    rotorParts[0] = rotorLetters.substring(0,curLetterPos);
    rotorParts[1] = Character.toString(rotorLetters.charAt(curLetterPos));
    rotorParts[2] = rotorLetters.substring(curLetterPos+1);
    //println("notntter: " + rotorParts[0] + rotorParts[1] + rotorParts[2]);
  return rotorParts;
}

// prints a rotor with greentext
void rotorPrinter(String[] rotorVisuals, int text_height, char curChar) {
  text(rotorVisuals[0],300,text_height);
  fill(0,255,0);
  text(rotorVisuals[1],300+(15*rotorVisuals[0].length()),text_height);
  fill(255,255,255);
  text(rotorVisuals[2],300+(15*rotorVisuals[0].length()+15),text_height);
  //println("sum of rotorVisual arrays: " + (int) (rotorVisuals[0].length()+1+rotorVisuals[2].length()));
}
