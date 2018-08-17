import ddf.minim.analysis.*;
import ddf.minim.*;

Minim       minim;
AudioPlayer jingle;
FFT         fft;

float r = 200;
float d = 42;

void setup()
{
  //size(512, 200, P3D);
  fullScreen();
  noiseDetail(8);

  minim = new Minim(this);

  // specify that we want the audio buffers of the AudioPlayer
  // to be 1024 samples long because our FFT needs to have 
  // a power-of-two buffer size and this is a good size.
  jingle = minim.loadFile("jingle.mp3", 1024);

  // loop the file indefinitely
  jingle.loop();

  // create an FFT object that has a time-domain buffer 
  // the same size as jingle's sample buffer
  // note that this needs to be a power of two 
  // and that it means the size of the spectrum will be half as large.
  fft = new FFT( jingle.bufferSize(), jingle.sampleRate() );
}

void draw()
{
  background(0);
  stroke(255);
  pushMatrix(); 
  translate(width/2, height/2);
  float arclength = 0;  
  fft.forward( jingle.mix );
  for (int i = 0; i < fft.specSize(); i++)
  {
    arclength += d;
    float theta = arclength / r; 
    pushMatrix();
    //rotate(-(frameCount * 0.005) + (i*PI/(i*10)));
    translate(r*cos(theta), r*sin(theta));
    rotate(theta);
    //arc(i, height/2, 0, fft.getBand(i)*8, 0, PI * 2);
    ellipse(0, 0, fft.getBand(i)*8,0);
    popMatrix();
    arclength += d/2; 
  }
  popMatrix();
}