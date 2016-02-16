size(500,500);
background(100);

stroke(0);
line(0, 50, width, 50);
line(0, 150, width, 150);
line(0, 250, width, 250);

stroke(255);

float x = 0;
while(x < width) {
  point(x, 50 + random(-20,20));//(-20,20)
  point(x, 150 + noise(x/10) * 20);//0-1
  point(x, 250 + sin(x/10) * 20);//-1-1
  x = x + 1;
}