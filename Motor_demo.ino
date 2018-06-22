/*
 Nema17 - BigEasy driver test code.
*/

int Distance = 0; // Number of steps.

void setup() {
  pinMode(4,OUTPUT);// step
  pinMode(5,OUTPUT);// direction
  digitalWrite(4,LOW);
  digitalWrite(5,LOW);
}

void loop() {
  digitalWrite(4,HIGH);
  delayMicroseconds(300);
  digitalWrite(4,LOW);
  delayMicroseconds(300);  
  Distance++;
  if (Distance == 3200) {
    digitalWrite(5, digitalRead(5) == LOW ? HIGH : LOW);// change direction
    Distance = 0;
    delay(500);
  }
}

