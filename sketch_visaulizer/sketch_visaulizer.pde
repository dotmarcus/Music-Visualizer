import ddf.minim.*;
import ddf.minim.signals.*; 
import ddf.minim.analysis.*;
visualizer classicVi;

Minim minim;
FFT fft;

AudioOutput out;
AudioPlayer mp3;

PFont directions;
int hVal;

boolean started;     //boolean for telling if the program has started 
boolean selection;   //boolean for telling if a song has been selected
boolean canPlay;      //boolean for allowing the audio to play 


void setup()
{
  /* Program setup */
  fullScreen();
  frameRate(1000);
  started = false;
  selection = false;
  
  /* Sound and minim setup parameters */
  minim = new Minim(this);
  /*
  Music by オオドラ
  UNDERTALE 1ST ANNIVERSARY SPECIAL RELEASE - 09.15.2016.
  http://underveil.unisphere.tv/
  */
  mp3 = minim.loadFile("01 Enemy Approaching アレンジ.mp3",2048);
  out = minim.getLineOut(Minim.STEREO,44100);
  fft = new FFT(mp3.bufferSize(),mp3.sampleRate());  //allows for the decription of the sound waves 
  rectMode(CORNERS);
  mp3.loop();
  
  classicVi = new visualizer(); // initializes the class visualizer 
}

void draw()
{
  canPlay = true;
    background(0);
    classicVi.drawBEQ();
    if(canPlay)
    {
      mp3.play();
    }
}

/* Start Button Parameters */
void keyPressed()
{
  if(key == ESC)
  {
    started = false; //kills the program 
    mp3.pause();
  }
}