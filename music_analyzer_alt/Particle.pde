class Particle {
  PVector pos, vel;
  float mult = 1;
  float angle = random(PI);
  float max = random(1.15, 1.25);
  boolean growing = true;
  float r, h;
  float c, m, y;

  Particle(float x, float y) {
    pos = new PVector(x, y);
    vel = PVector.random2D();
    vel.mult(2);
    r = random(2, 8);
    h = random(255);

    //c = m = y = 255;
  }

  void update() {
    pos.add(vel);
    angle *= 1.03;
    if (growing) {
      mult *= 1.008;
      r *= 1.05;
      vel.mult(mult);
      if (mult > max) {
        growing = false;
      }
    } else if (!growing) {
      growing = false;
      mult *= 0.85;
      vel.mult(mult);
      r *= mult;
    }
  }

  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    noFill();
    strokeWeight(mult*3);
    //stroke(c, m, y);
    ellipse(0, 0, r, r);
    popMatrix();
  }

  boolean gone() {
    return r < 1;
  }
}

class Line extends Particle {
  Line(float x, float y) {
    super(x, y);
    vel.mult(1.4);
  }

  void draw() {
    noFill();
    strokeWeight(mult*5);
    //stroke(h, 255, 255);
    //stroke(255);
    line(pos.x+vel.x, pos.y+vel.y, pos.x-vel.x, pos.y-vel.y);
  }
}

void shotParticle(Float x, float y) {
  for (int i = 0; i < random(6, 10); i++) {
    if (random(1) < 0.25) {
      Particle p = new Particle(x, y);
      particles.add(p);
    } else if (random(1) < 0.4) {
      Line p = new Line(x, y);
      particles.add(p);
    } else if (random(1) < 0.65) {
      Line p = new Line(x, y);
      particles.add(p);
    } else {
      Particle p = new Particle(x, y);
      particles.add(p);
    }
  }
}