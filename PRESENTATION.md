# This document is required.
Our project is a digital model of the Enigma machine. It was a cipher machine used in World War Two by Nazi Germany and was eventually cracked by the Allies. Here’s how it works:
There are multiple layers of encryption. The first is a plugboard, where pairs of connected letters are swapped when inputted. For example, if A and B were connected, if A was the input character, it would be turned into a B.
The second layer is the rotors. In our model, there are three rotors, labeled 3, 2, 1. Each rotor has a jumbled alphabet on it and one of the letters is the notch. When a key is pressed, the rightmost rotor (in this case, 3), is rotated. If it hits the notch, the next rotor is rotated, and the same goes for the next.
The character being encoded is caesar-shifted based on the current position of the rotor. 
insert more info about enigma machine idk
	To start off, we’ll be demonstrating with a simple “hello.” The cipher automatically converts it to uppercase and spits out the Enigma cipher-encoded result, “ILBDA.” Here we have our rotors. Here’s the information about the ciphertext.
	Activating the stepping function resets the rotor display. As you can see, the first character being encoded is H and we are on step 1 of the Enigma cipher. 
Onto step 2. The character hasn’t changed, but rotor 3 rotated, switching from B to D. D isn’t rotor 3’s notched letter, so rotor 2 is unaffected.
Onto step 3. The character is rotated to Q beeeecause (rotor 3 is D)
Onto step 4. The character is not rotated because rotor 2 is on A.
Onto step 5. The character is rotated to X because explain br (rotor 1 is E)
Onto step 6. The character is reflected to J from X.
Onto step 7. The character is put back through the rotors and is rotated to Z
Onto step 8. The character is rotated to S
Onto step 9. The character is rotated to I, and this is the final step of the enigma cipher.
The plugboard swap is applied automatically before the first step and after the last step.
When you step again, it moves onto the E in HELLO. This process repeats until the final character is finished, and you’ll see that you get the encoded result “ILBDA.”
Clicking on togedepressed.png to reset, let’s try this with a longer string.
As you can see, “Hello there. General Kenobi, you are a bold one,” results in changes to rotor 2 as well as rotor 3. The notch for rotor 2 wasn’t reached, so rotor 1 remains unaffected. 
conclusion
