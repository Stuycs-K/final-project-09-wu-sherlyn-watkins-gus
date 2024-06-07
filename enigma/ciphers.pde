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
Character enigmaTemp(Character pchar, int stepPart) {
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
