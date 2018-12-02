int latchPin = 8;
int clockPin = 12;
int dataPin = 11;

byte buffer[4];

void setup() {
  pinMode(latchPin, OUTPUT);
  pinMode(clockPin, OUTPUT);
  pinMode(dataPin, OUTPUT);

  Serial.begin(9600);

  digitalWrite(latchPin, LOW);

  // shift out the bits:
  shiftOut(dataPin, clockPin, MSBFIRST, 0x00);  //ch0-7
  shiftOut(dataPin, clockPin, MSBFIRST, 0x00);   //ch8-15
  shiftOut(dataPin, clockPin, MSBFIRST, 0x00);  //ch16-23
  shiftOut(dataPin, clockPin, MSBFIRST, 0x00);   //ch24-31

  digitalWrite(latchPin, HIGH);
}

void loop() {

  if (Serial.available()) {
    //get data on which registers to switch on
    Serial.readBytes(buffer, 4);

    //shift out register data to shift registers
    digitalWrite(latchPin, LOW);

    shiftOut(dataPin, clockPin, MSBFIRST, buffer[3]);  //ch0-7
    shiftOut(dataPin, clockPin, MSBFIRST, buffer[2]);   //ch8-15
    shiftOut(dataPin, clockPin, MSBFIRST, buffer[1]);  //ch16-23
    shiftOut(dataPin, clockPin, MSBFIRST, buffer[0]);   //ch24-31

    digitalWrite(latchPin, HIGH);

    Serial.println("OK!");
  }
}
