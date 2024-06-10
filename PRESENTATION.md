# This document is required.
Our project is a digital model of the Enigma machine. It was a cipher machine used in World War Two by Nazi Germany and was eventually cracked by the Allies. Here’s how it works:<br>
There are multiple layers of encryption. The first is a plugboard, where pairs of connected letters are swapped when inputted. For example, if A and B were connected, if A was the input character, it would be turned into a B.<br>
The second layer is the rotors. In our model, there are three rotors, labeled 3, 2, 1. Each rotor has a jumbled alphabet on it and one of the letters is the notch. When a key is pressed, the rightmost rotor (in this case, 3), is rotated. If it hits the notch, the next rotor is rotated, and the same goes for the next.<br>
Imagine that each character of the alphabet has a value of 0 to 25, starting from A and ending at Z.<br>
The character being encoded is caesar-shifted based on the current position of the rotor. In this case, let’s take the B with this rotor.<br>
[Displayed rotor: BDFHJLCPRTXVZNYEIWGAKMUSQO]<br>
When A was entered, the rotor rotated from B, the first letter, to D, the second letter.<br>
To apply the rotor, add the rotor position to the character. In this case, that’s position 1 plus character B, which has a value of 1. The resulting character has a value of 2. The character in the “2” slot in the rotor is F, so B becomes F.
Then, F is shifted back by the rotor position. F minus position 1 is E. <br>
To summarize, B is encrypted into E. <br>
This process is repeated for each rotor. The first one is rotor 3, so it goes through rotor 2 and rotor 1.<br>
After each rotor processes the character, it is reflected. The reflector is another alphabet.<br>
[Displayed reflector: YRUHQSLDPXNGOKMIEBFZCWVJAT]<br>
In our case with the modified character E, it gets put through the two remaining rotors and ends up as an S. S has a value of 18, so looking at the 18th letter in the reflector, it turns into an F.<br>
This F is put back through the rotors in reverse order: rotor 1, rotor 2, rotor 3.<br>
The final character is put back through the plugboard, and that’s one character encrypted. Each following character shifts the rotors, resulting in a radically different result.<br>
To demonstrate our model, we’ll be testing with a simple “hello.” The cipher automatically converts it to uppercase and spits out the Enigma cipher-encoded result, “ILBDA.” The plugboard information is displayed at the top right. The rotors are displayed in the middle. Information about the ciphertext is displayed at the bottom.<br>
Activating the stepping function resets the rotor display. As you can see, the first character being encoded is H and we are on step 1 of the Enigma cipher.<br>
Onto step 2. The character hasn’t changed, but rotor 3 rotated, switching from B to D. D isn’t rotor 3’s notched letter, so rotor 2 is unaffected.<br>
Onto step 3. The character is rotated to Q because rotor 3 is on D.<br>
Onto step 4. The character is not rotated because rotor 2 is on A.<br>
Onto step 5. The character is rotated to X because rotor 1 is on E.<br>
Onto step 6. The character is reflected to J from X.<br>
Onto step 7. The character is put back through the rotors and is rotated to Z<br>
Onto step 8. The character is rotated to S<br>
Onto step 9. The character is rotated to I, and this is the final step of the enigma cipher.<br>
The plugboard swap is applied automatically before the first step and after the last step.<br>
When you step again, it moves onto the E in HELLO. This process repeats until the final character is finished, and you’ll see that you get the encoded result “ILBDA.”<br>
Clicking on togedepressed.png to reset, let’s try this with a longer string.<br>
As you can see, “Hello there. General Kenobi, you are a bold one,” results in changes to rotor 2 as well as rotor 3. The notch for rotor 2 wasn’t reached, so rotor 1 remains unaffected. <br>
This has been our model of the Enigma machine.<br>
