import processing.sound.*;

SoundFile[] instruments;
SoundFile bassoon, celloMelody, celloSupport, clarinet, contraclarinet, eh, fh, fluteMelody, fluteOst, lowBrass, drums, viola, violinsMelody, violinsOst;
float[] amps = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

final int canvasSize = 900;
int xPos, yPos, previousXPos, previousYPos = 1;

void setup() {
  size(1000, 1000);
  line(canvasSize/2, 0, canvasSize/2, canvasSize);
  line(0, canvasSize/4, canvasSize, canvasSize/4);
  line(0, canvasSize/2, canvasSize, canvasSize/2);
  line(0, 3*(canvasSize/4), canvasSize, 3*(canvasSize/4));
  
  textSize(18);
  fill(0);
  text("----------Increase Focus--------->", 450, 950);
  translate(width/2, height/2);
  rotate(-PI/2);
  text("----------Increase Intensity--------->", 0, 450);
  
  violinsOst = new SoundFile(this, "Modular - ViolinsOst.wav");
  violinsMelody = new SoundFile(this, "Modular - ViolinsMelody.wav");
  viola = new SoundFile(this, "Modular - Viola.wav");
  drums = new SoundFile(this, "Modular - TimpaniNBass.wav");
  lowBrass = new SoundFile(this, "Modular - LowBrass.wav");
  fluteOst = new SoundFile(this, "Modular - FluteOst.wav");
  fluteMelody = new SoundFile(this, "Modular - FluteMelody.wav");
  fh = new SoundFile(this, "Modular - FH.wav");
  eh = new SoundFile(this, "Modular - EHMelody.wav");
  contraclarinet = new SoundFile(this, "Modular - Contraclarinet.wav");
  clarinet = new SoundFile(this, "Modular - Clarinet.wav");
  celloMelody = new SoundFile(this, "Modular - CelloMelodic.wav");
  celloSupport = new SoundFile(this, "Modular - CelloSupport.wav");
  bassoon = new SoundFile(this, "Modular - Bassoon.wav");
  
  instruments = new SoundFile[] {violinsMelody, violinsOst, viola, celloMelody, celloSupport, fluteOst, fluteMelody, eh, bassoon, clarinet, contraclarinet, lowBrass, drums, fh};
  
  for (SoundFile instrument : instruments) {
    instrument.loop();
    instrument.amp(0);
  }
  
  soloTracks(new int[]{2});


}

void draw() { 
  // get mouse position on grid with bottom left being 1,1 
  xPos = ceil(float(mouseX)/(canvasSize/2));
  yPos = 5 - ceil(float(mouseY)/(canvasSize/4));
  
  if (xPos != previousXPos || yPos != previousYPos) {
    previousXPos = xPos;
    previousYPos = yPos;
    handlePositionChange(xPos, yPos);
  }
  
  println(xPos + " " + yPos);
}

void handlePositionChange(int xPos, int yPos) {
  if (xPos == 1) {
    switch (yPos) {
      case 1:   soloTracks(new int[]{2});
                break;
      case 2:   soloTracks(new int[]{2, 3, 5, 6});
                break;
      case 3:   soloTracks(new int[]{2, 3, 5, 6, 10, 11});
                break;
      case 4:   soloTracks(new int[]{2, 3, 5, 6, 10, 11, 12, 13});
                break;
    }
  } else if (xPos == 2) {
    switch (yPos) {
      case 1:   soloTracks(new int[]{2, 4});
                break;
      case 2:   soloTracks(new int[]{1, 2, 3, 4});
                break;
      case 3:   soloTracks(new int[]{1, 2, 3, 4, 7, 8, 11});
                break;
      case 4:   soloTracks(new int[]{1, 2, 3, 4, 7, 8, 11, 12, 13, 14});
                break;
    }
  }
}

void soloTracks(int[] trackNumbers) {
  float incrementAmount = 0.0005;
  int instrumentNumber = 1;
  for (SoundFile instrument : instruments) {
      if (arrayContains(trackNumbers, instrumentNumber)) {
        while (amps[instrumentNumber - 1] < 1) {
          amps[instrumentNumber - 1] += incrementAmount;
          instrument.amp(amps[instrumentNumber - 1]);
        }
      } else {
        while (amps[instrumentNumber - 1] > 0) {
          amps[instrumentNumber - 1] -= incrementAmount;
          instrument.amp(amps[instrumentNumber - 1]);
        }
      }
      instrumentNumber += 1;
  }
}

boolean arrayContains(int[] array, int num) {
  boolean returnVal = false;
  
  for (int i : array) {
    if (i == num) {
      returnVal = true;
    }
  }
  
  return returnVal;
}
