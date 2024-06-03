class Rotor {
  
  public String letters;
  public String notchedletters;
  public int rotorpos;
  public int ringpos;
  
  public Rotor(String letters, String notches, int rotorpos, int ringpos) {
    this.letters = letters;
    this.rotorpos = rotorpos;
    this.ringpos = ringpos;
    this.notchedletters = notches;
  }
  public Rotor(int rotornum, int rotorpos, int ringpos) {
    println("rotornum", rotornum);
    this.rotorpos = rotorpos;
    this.ringpos = ringpos;
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
      default:
        //throw new IndexOutOfBoundsException("Invalid rotor number!");
      // todo: other special rotors (notchedletters >1 etc)
    }
    
  }
  
  // accessor method
  public String letters() {
    return this.letters;
  }
  
  public Boolean onNotch() {
    return notchedletters.indexOf(letters.charAt(rotorpos)) != -1;
  }
  
  public void rotate() {
    rotorpos = (rotorpos + 1) % 26;
  }
  
  public Character apply(Character c) {
    println("Applying rotor with char ", c, (int)c, " and rotorpos ", rotorpos);
    println(letters);
    return letters.charAt((c - 65 + rotorpos + ringpos) % 26);
  }
}
