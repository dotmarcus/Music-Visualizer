import beads.*;
import org.jaudiolibs.beads.*;

AudioContext ac; // create our AudioContext
AudioContext ac2;

Glide gainGlide;
BeatDetector bd;    
BeatQueue bq;
int forward = 2000;  // how many milliseconds to look forward
float spd;
float fadeInVal = 1;
float volumeFade = 0.4;
boolean checkGap;

Boolean playtest;

String song = "Grapevine vs. Feel Good Inc (Demo).mp3";

Boolean songChosen = false;

void initMusic() {
  ac = new AudioContext();
  
  stroke(255);
  time = millis();
  bd = new BeatDetector(forward);
  bd.loadSong(song);
  bq = new BeatQueue(bd);
  bd.start();
  gainGlide.setValue(1);
}

void setup(){
  fullScreen();
  frameRate(1000);
  noiseDetail(8);
  initRipples();
  initMusic();
}

void test(){
  stroke(#FFF703);
  noFill();
  //fill(#FFF703);
  strokeWeight(1);
  rect(0, 0, 100, height-1);
  strokeWeight(3);
  
  int beats[] = bq.nexts(); // returns an array of time of Peaks
  
  for (int i = 0; i < beats.length; ++i) {
    //int r = 50 - Peaks[i] * 50 / forward;
    int r = height - beats[i] * height / forward;
    print("note: "+r+"\n");
    stroke(255,235,3,r);
    //int r = Peaks[i] * 50 / forward;
    line (0, r, 100, r);
    //ellipse(width/2, height/2, r, r);
  }
  int next = bq.next(); // return next Peak
  if (next <= 20) {
    eRadius = 85;
  }
  
  int dt = millis() - time;
  eRadius -= (dt * 0.1);
  //eRadius += (dt * 0.1);
  if (eRadius < 20) eRadius = 20;
  //if (eRadius > 85) eRadius = 85;
  time += dt;
}

void draw(){
  background(0);
  spd = (abs(bq.next())/100) + 10;
  test();
  makeRipples();
}