import ddf.minim.analysis.*;
import ddf.minim.*;

Minim       minim;
AudioPlayer jingle;
FFT         fft;

AudioPlayer song;
BeatDetect beat;
BeatListener bl;

float r = 200;
float d = 42;

float initSize = 16;
float maxSize = 128;
Beat kick, snare, hat;

boolean canPlay;      //boolean for allowing the audio to play 

void setup() {
  fullScreen();
  noiseDetail(8);

  minim = new Minim(this);
  selectInput("Select an audio file:", "fileSelected");
  initExplosion();
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    String audioFileName = selection.getAbsolutePath();
    song = minim.loadFile(audioFileName, 1024);

    beat = new BeatDetect(song.bufferSize(), song.sampleRate());

    beat.setSensitivity(300); 

    bl = new BeatListener(beat, song);  
    textFont(createFont("Helvetica", 16));
    textAlign(CENTER);

    fft = new FFT( song.bufferSize(), song.sampleRate() );

    kick = new Beat("KICK", width/4, height/2);
    hat = new Beat("HAT", width/2, height/2);
    snare = new Beat("SNARE", 3*width/4, height/2);
  }
}

void draw()
{
  background(0);

  noFill();
  stroke(255);
  strokeWeight(1);
  if (song != null) {
    if (fft != null) {
      pushMatrix(); 
      translate(width/2, height/2);
      float arclength = 0;  
      fft.forward( song.mix );

      for (int i = 0; i < fft.specSize(); i++)
      {
        arclength += d;
        float theta = arclength / r; 
        pushMatrix();
        //rotate(-(frameCount * 0.005) + (i*PI/(i*10)));
        translate(r*cos(theta), r*sin(theta));
        rotate(theta);
        //arc(i, height/2, 0, fft.getBand(i)*8, 0, PI * 2);
        float w = fft.getBand(i)*8;
        if (w > r) w = r;    
        ellipse(0, 0, w, 0);
        popMatrix();
        arclength += d/2;
      }
      popMatrix();
      //drawExplosion();
      //drawBeats();
      canPlay = true;
      if (canPlay)
      {
        song.play();
      }
    }
  }
}