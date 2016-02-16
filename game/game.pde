
class Ball {
  PVector pos;
  float dir;
  PVector velo;
  float roll;
  float bounce;
  float radius;
}

// Golbal Vars
boolean upPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

// Gobal Const
Ball b;
float gravity = 0.2;
float ground = 650;
float dampen = 0.65;
float amplitude = 0;

void setup() {
  size(1440, 900);
  frameRate(60);
  smooth();
  b = new Ball();
  b.pos = new PVector(720, 250);
  b.dir = 1;
  b.velo = new PVector(0, 0);
  b.roll = 5;
  b.bounce = 8;
  b.radius = 25;
}

void draw() {
  update();
  render();
}

void keyPressed(KeyEvent e) {
  if (key == CODED) {
    if (keyCode == UP) {
      upPressed = true;
    }
    else if (keyCode == LEFT) {
      leftPressed = true;
    }
    else if (keyCode == RIGHT) {
      rightPressed = true;
    }
  }
}

void keyReleased(KeyEvent e) {
  if (key == CODED) {
    if (keyCode == UP) {
      upPressed = false;
    }
    else if (keyCode == LEFT) {
      leftPressed = false;
    }
    else if (keyCode == RIGHT) {
      rightPressed = false;
    }
  }
}

void update() {
  if (b.pos.y < ground) {
   b.pos.y += b.velo.y;
   b.velo.y += gravity;
   if (b.pos.y >= ground-100/2) {
     b.velo.y *= -dampen;
     //amplitude = lerp(0, 50, .3);
     //println(b.pos.y);
   }
  }
  else {
   b.velo.y = 0;
   amplitude = 0;
  }
  
  //Controls
  if (b.pos.y >= 600 && upPressed) {
    b.velo.y = -b.bounce;
  }
  if (leftPressed && b.pos.x > 0) {
    b.pos.x -= b.roll;
  }
  if (rightPressed && b.pos.x < width) {
    b.pos.x += b.roll;
  }
 
}

void render() {
  //display ball
  background(0);
  ellipse(b.pos.x, b.pos.y, b.radius, b.radius);
  //display line
  //line(0, 600, width, 600);
  stroke(255);
  //rect(0, 600, width, 1);
  float x = 0;
  while(x < width) {
    ellipse(x, 600 + -sin(x/30) * amplitude, 2, 2);
    //point(x, 600 + -sin(x/30) * random(0, 50));//0-1
    x = x + 1;
    amplitude += .001;
  }
}