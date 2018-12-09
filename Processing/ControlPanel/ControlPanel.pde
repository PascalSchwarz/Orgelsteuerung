import controlP5.*;
import processing.serial.*;

Serial myPort;  // Create object from Serial class
ControlP5 cp5;

CheckBox checkbox;

int myColorBackground;
long buttons = 0;
int page = 0;
long[] savestates = {0,0,0,0,0,0,0};

void setup() {
  size(900, 700);
  smooth();
  
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
  
  myPort = new Serial(this, "/dev/ttyUSB1", 9600);
}

void draw() {
  background(0);
  
  buttons = 0;
  for(int i = 0; i<32; ++i)
  {
    if(checkbox.getState(i)) buttons |= (long)pow(2,i);
  }
  sendtocontroller();
    
  text("Page",400,500);
  text(page,450,500);
}

void controlEvent(ControlEvent theEvent) { //<>//
}

void keyPressed() {
  if (key==' ') {
    checkbox.deactivateAll();
  } 
  if (key=='s')
  {
    buttons = 0;
    for(int i = 0; i<32; ++i)
    {
      if(checkbox.getState(i)) buttons |= (long)pow(2,i);
    }
    savestates[page] = buttons;
  }
  if(key=='a')
  {
    if(page > 0) page--;
    checkbox.deactivateAll();
    buttons = savestates[page];
    for(int i = 0; i<32; ++i)
    {
      if((buttons >> i & 1) == 1) checkbox.activate(i);
    }
  }
  if(key=='d')
  {
    page++;
    checkbox.deactivateAll();
    buttons = savestates[page];
    for(int i = 0; i<32; ++i)
    {
      if((buttons >> i & 1) == 1) checkbox.activate(i);
    }
  }
}

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
