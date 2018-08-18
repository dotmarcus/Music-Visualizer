import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.spi.*; // for AudioStream

Minim minim;
AudioOutput out;
LiveInput in;

float r = 450;
float d = 42;


void setup() {
  fullScreen();
  
  minim = new Minim(this);
  out = minim.getLineOut();

  AudioStream inputStream = minim.getInputStream( out.getFormat().getChannels(), 
    out.bufferSize(), 
    out.sampleRate(), 
    out.getFormat().getSampleSizeInBits());
                                                  
  in = new LiveInput( inputStream );

  GranulateSteady grain = new GranulateSteady();

  in.patch(grain).patch(out);
}

// draw is run many times
void draw()
{
  // erase the window to black
  background( 0 );
  // draw using a white stroke
  stroke( 255 );
  strokeWeight(1);

  for (int i = 0; i < out.bufferSize() - 1; i++)
  {
    ellipse(50, i, out.left.get(i)*50, 0);
    ellipse(width-50, i, out.right.get(i)*50, 0);
  }

  pushMatrix(); 
  translate(width/2, height/2);
  scale(.25);
  strokeWeight(20);
  noFill();
  float arclength = 0; 
  // draw the waveforms
  for ( int i = 0; i < out.bufferSize() - 1; i++ )
  {
    if (out.left.get(i) > 0.01 && out.right.get(i) > 0.01) stroke(255, 0, 0);
    else stroke(255);
    arclength += d;
    float theta = arclength / r; 
    pushMatrix();
    // find the x position of each buffer value
    translate(r*cos(theta), r*sin(theta));
    rotate(theta);
    float x1  =  map( i, 0, out.bufferSize(), 0, width );
    float x2  =  map( i+1, 0, out.bufferSize(), 0, width );
    // draw a line from one buffer position to the next for both channels
    line( x1, 50 + out.left.get(i)*65, x2, 50 + out.left.get(i+1)*65);
    line( x1, 150 + out.right.get(i)*65, x2, 150 + out.right.get(i+1)*65);
    popMatrix();
    arclength += d/2;
  } 
  popMatrix();
}