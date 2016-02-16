float xSpeed = 5;
float ySpeed = 4;

float x = 250;
float y = 100;
float radius = 25;

void setup() {
  size(500, 500); 
  ellipseMode(CENTER);
  ellipseMode(RADIUS);
}

void draw() {
  background(0);
  fill(255, 125, 0);

  ellipse(x, y, radius, radius);

  if (x <= 0) {
    xSpeed *= -1;
  }
  else if ( x >= width) {
    xSpeed *= -1;
  }

  if (y <= 0 ) {
    ySpeed *= -1;
  }
  else if (y >= height) {
    ySpeed *= -1;
  }

  x += xSpeed;
  y += ySpeed;




}