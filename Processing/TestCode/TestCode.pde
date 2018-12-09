import controlP5.*;
import processing.serial.*;

Serial myPort;  // Create object from Serial class
ControlP5 cp5;

CheckBox checkbox;

int myColorBackground;
long buttons = 1;
int page = 0;
long[] savestates = {0};
int pos = 0;

void setup() {
  size(900, 700);
  smooth(); //<>//
  
  myPort = new Serial(this, "/dev/ttyUSB1", 9600);
}

void draw() {
  background(0);
  delay(250);
  buttons |= (long)pow(2,pos);
  pos++;
  if(pos > 32) 
  {
    pos = 0;
    buttons = 0;
  }
  sendtocontroller();
} //<>//



void sendtocontroller()
{
  byte[] tx = {0,0,0,0};
  tx[0] = (byte)(buttons >> 0 & 0xFF);
  tx[1] = (byte)(buttons >> 8 & 0xFF);
  tx[2] = (byte)(buttons >> 16 & 0xFF);
  tx[3] = (byte)(buttons >> 24 & 0xFF);
  myPort.write(tx[0]);
  myPort.write(tx[1]);
  myPort.write(tx[2]);
  myPort.write(tx[3]);
}
