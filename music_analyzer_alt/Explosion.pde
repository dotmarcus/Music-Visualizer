ArrayList<Particle> particles;
void initExplosion() {
  particles = new ArrayList<Particle>();
}

void drawExplosion() {
  //fill(255, 150);
  //noStroke(); 
  pushMatrix();
  for (int i = particles.size()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.update();
    p.draw();
    if (p.gone()) particles.remove(i);
  }
  popMatrix();
} 