import ddf.minim.analysis.*;
import ddf.minim.*;

Minim       minim;
FFT         fft;
AudioPlayer song;
Play play;
Rewind rewind;
Forward ffwd;

float r = 450;
float d = 42;


void setup() {
  fullScreen();
  noiseDetail(8);

  minim = new Minim(this);
  selectInput("Select an audio file:", "fileSelected");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    String audioFileName = selection.getAbsolutePath();
    song = minim.loadFile(audioFileName, 1024);
    play = new Play(width/2 - 50, 130, 20, 10);
    rewind = new Rewind(width/2, 130, 20, 10);
    ffwd = new Forward(width/2 + 50, 130, 20, 10);

    //textFont(createFont("Helvetica", 16));
    //textAlign(CENTER);

    fft = new FFT( song.bufferSize(), song.sampleRate() );
  }
}

void draw() {
  background(0);

  noFill();
  stroke(255);
  strokeWeight(1); 

  if (song != null) {

    float x = map(song.position(), 0, song.length(), 0, width);

    for (int i = 0; i < song.bufferSize() - 1; i++)
    {
      ellipse(i*1.8, 50, 0, song.left.get(i)*50);
    }

    float arclength = 0;  
    if (fft != null) {
      fft.forward( song.mix );
      pushMatrix(); 
      translate(width/2, height/2);
      scale(.5);
      for (int i = 0; i < fft.specSize(); i++)
      {
        arclength += d;
        float theta = arclength / r; 
        pushMatrix();
        //rotate((frameCount * 0.005 * x/50) + (x*PI/(x*10)));
        translate(r*cos(theta), r*sin(theta));
        rotate(theta);
        float w = fft.getBand(i)*8;
        if (w > r) w = r;

        ellipse(0, 0, w, 0);
        popMatrix();
        arclength += d/2;
      } 
      popMatrix();
    }

    stroke(255, 0, 0);
    line(x, 50 - 20, x, 50 + 20);

    play.update();
    play.draw();
    rewind.update();
    rewind.draw();
    ffwd.update(); 
    ffwd.draw();
  }
}

void mousePressed()
{
  play.mousePressed();
  rewind.mousePressed();
  ffwd.mousePressed();
}

void mouseReleased()
{
  play.mouseReleased();
  rewind.mouseReleased();
  ffwd.mouseReleased();
}