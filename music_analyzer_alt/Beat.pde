class Beat{
  String name;
  float popSize;
  
  float x,y;
  float h;
  
  Beat(String name, float x, float y){
    this.name = name;
    this.popSize = 16;
    this.x = x;
    this.y = y;
    this.h = random(255);
  }
  
  void draw(){
    if (name == "KICK") stroke(0, 255, 255);
    else if (name == "SNARE") stroke(255, 0, 255);
    else if (name == "HAT") stroke(255, 255, 0);
    //textSize(popSize);
    ellipse(x, y, popSize, popSize);
    //text(name, x, y);
  }
  
}

void drawBeats(){
  if ( beat.isKick() ) {
    stroke(0, 255, 255);
    kick.popSize = maxSize;
    shotParticle(kick.x, kick.y);
  } else if ( beat.isSnare() ) {
    stroke(255, 0, 255);
    snare.popSize = maxSize;
    shotParticle(snare.x, snare.y);
  } else if ( beat.isHat() ) {
    stroke(255, 255, 0);
    hat.popSize = maxSize;
    shotParticle(hat.x, hat.y);
  }
  
  kick.draw();
  snare.draw();
  hat.draw();
  
  kick.popSize = constrain(kick.popSize * 0.95, initSize, maxSize);
  snare.popSize = constrain(snare.popSize * 0.95, initSize, maxSize);
  hat.popSize = constrain(hat.popSize * 0.95, initSize, maxSize);
}