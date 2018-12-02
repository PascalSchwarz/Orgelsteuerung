import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 
import processing.serial.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ControlPanel extends PApplet {




Serial myPort;  // Create object from Serial class
ControlP5 cp5;

CheckBox checkbox;

int myColorBackground;
long buttons;
int page;
long[] savestates;

public void setup() {
  
  
  
  cp5 = new ControlP5(this); //<>//
  checkbox = cp5.addCheckBox("checkBox")
                .setPosition(100, 100)
                .setColorForeground(color(120))
                .setColorActive(color(255))
                .setColorLabel(color(255))
                .setSize(50, 50)
                .setItemsPerRow(8)
                .setSpacingColumn(50)
                .setSpacingRow(20)
                .addItem("0", 0)
                .addItem("1", 1)
                .addItem("2", 2)
                .addItem("3", 3)
                .addItem("4", 4)
                .addItem("5", 5)
                .addItem("6", 6)
                .addItem("7", 7)
                .addItem("8", 8)
                .addItem("9", 9)
                .addItem("10", 10)
                .addItem("11", 11)
                .addItem("12", 12)
                .addItem("13", 13)
                .addItem("14", 14)
                .addItem("15", 15)
                .addItem("16", 16)
                .addItem("17", 17)
                .addItem("18", 18)
                .addItem("19", 19)
                .addItem("20", 20)
                .addItem("21", 21)
                .addItem("22", 22)
                .addItem("23", 23)
                .addItem("24", 24)
                .addItem("25", 25)
                .addItem("26", 26)
                .addItem("27", 27)
                .addItem("28", 28)
                .addItem("29", 29)
                .addItem("30", 30)
                .addItem("31", 31)
                ;
  cp5.addButton("Save")
     .setPosition(450,400)
     .setSize(50,50)
     .setValue(0)
     .activateBy(ControlP5.PRESS);
     ;
  cp5.addButton("Next")
     .setPosition(550,400)
     .setSize(50,50)
     .setValue(0)
     .activateBy(ControlP5.PRESS);
     ;
  cp5.addButton("Prev")
     .setPosition(350,400)
     .setSize(50,50)
     .setValue(0)
     .activateBy(ControlP5.PRESS);
     ;
  
  myPort = new Serial(this, "/dev/ttyUSB0", 9600);
}

public void draw() {
  background(0);
}

public void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(checkbox)) { //<>//
    myColorBackground = 0;
    buttons = 0;
    for(int i = 0; i<32; ++i)
    {
      if(checkbox.getState(i)) buttons += pow(2,i);
    }
    sendtocontroller();
  }
}

public void Prev(int value){
  page--;
  //buttons = savestates[page];
  println("Currentpage: %i", page);
}

public void Next(int value){
  page++;
  //buttons = savestates[page];
  println("Currentpage: %i", page);
}

public void Save(int value){
  //savestates[page] = buttons;
}

public void sendtocontroller()
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
  public void settings() {  size(900, 700);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ControlPanel" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
