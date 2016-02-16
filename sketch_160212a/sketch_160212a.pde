float x;
float y;
float radius;
float velocity;
float speed;
float gravity;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
 
void setup(){
  size(1440, 900);
  x = 720;
  y = 250;
  radius = 25;
  velocity = 5;
  speed = 0;
  gravity = 0.2;
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
    else if (keyCode == DOWN) {
      downPressed = true;
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
    else if (keyCode == DOWN) {
      downPressed = false;
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
  //Controls
  //if (upPressed) {
  //y -= speed;
  //}
  //if (downPressed) {
  //y += velocity;
  //}
  if (leftPressed && x > 0) {
   x -= velocity;
  }
  if (rightPressed && x < width) {
   x += velocity;
  }
  
  //Physics
  y = y + speed;
  speed = speed + gravity;
   
  // Condition to make the ball stop
  if ( speed < 0.65 && y > 700-99.5) {
    println("bottom");
    speed = 0;
    gravity = 0;
  }
  else if (y > 700-99.5) {
    println(speed);
    speed = speed * -0.65;
    println("Change Direction");
  }
}

void render() {
  //display ball
  background(0);
  ellipse(x, y, radius, radius);
  //display line
  line(0, 600, width, 600);
  stroke(255);
  rect(0, 600, width, 1);
}