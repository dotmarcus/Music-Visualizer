float RIPPLE_INITIAL_RADIOUS = 5.0;
float RIPPLE_INITIAL_RADIUS = 100.0;
float RIPPLE_RADIOUS_STEP_SIZE = 3.0;
float RIPPLE_TRANSPARENCY_STEP_SIZE = 5.0;
float NEW_RIPPLE_RATE = 0.01;
boolean trigger = false;

ArrayList<Ripple> ripples;

void initRipples() {
  ripples = new ArrayList<Ripple>();
  ripples.add(new Ripple());
}

void makeRipples() {
  for (Ripple ripple : ripples) {
    ripple.draw();
  }
  for (Ripple ripple : ripples) {
    ripple.update();
  }

  ArrayList<Ripple> nextRipples = new ArrayList<Ripple>();
  for (Ripple ripple : ripples) {
    if (!ripple.isTransparent()) {
      nextRipples.add(ripple);
    }
  }  
  ripples = nextRipples;
  limitRip();
  if (trigger) {
    trigger = false;
    ripples.add(new Ripple());
  }
}

class Ripple {

  float x;
  float y;
  float radius;
  float invertRadius;
  float transparency;
  float r, g, b;

  Ripple() {
    x = random(width - 100.0) + 50.0;
    y = random(height - 100.0) + 50.0;
    radius = RIPPLE_INITIAL_RADIOUS;
    transparency = 255.0;
    r = random(0,256);
    g = random(0,256);
    b = random(0,256);
  }

  void draw() {
    
    /* Rainbow Effect parameters */
    smooth();
    fill(r,g,b, transparency);
    noStroke();
    ellipse(x, y, transparency / 4.0, transparency / 4.0);
    noFill();
    stroke(r, g, b, transparency);  //sets the stroke to cycle through the whole color spectrum 
    strokeWeight(5);
    
    //arc(x, y, radius * 2.0, radius * 2.0, 0, PI * 2);
    ellipse(x, y, radius * 2.0, radius * 2.0);
    
  }

  void update() {
    radius += RIPPLE_RADIOUS_STEP_SIZE;
    transparency -= RIPPLE_TRANSPARENCY_STEP_SIZE;
  }  

  boolean isTransparent() {
    if (transparency <= 0.0) {
      return true;
    } else {
      return false;
    }
  }
}

void limitRip() {
  if (eRadius >= 80 && eRadius < 83) {
    trigger = true;
  } else {
    trigger = false;
  }
}