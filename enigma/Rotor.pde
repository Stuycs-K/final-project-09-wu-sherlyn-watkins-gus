class Rotor {
  
  String letters;
  String notchedletters;
  int rotorpos;
  int ringpos;
  
  public Rotor(String letters, int rotorpos, int ringpos) {
    this.letters = letters;
    this.rotorpos = rotorpos;
    this.ringpos = ringpos;
  }
  public Rotor (int rotornum, int rotorpos, int ringpos) {
    switch (rotornum) {
      case 1:
        letters = "EKMFLGDQVZNTOWYHXUSPAIBRCJ";
        notchedletters = "Q";
      case 2:
        letters = "AJDKSIRUXBLHWTMCQGZNPYFVOE";
        notchedletters = "E";
      case 3:
        letters = "BDFHJLCPRTXVZNYEIWGAKMUSQO";
        notchedletters = "V";
      case 4:
        letters = "ESOVPZJAYQUIRHXLNFTGKDCMWB";
        notchedletters = "J";
      case 5:
        letters = "VZBRGITYUPSDNHLXAWMJQOFECK";
        notchedletters = "Z";
      // todo: other special rotors (notchedletters >1 etc)
    }
  }
}
