class Particle
{
  PVector location;
  PVector velocity;
  PVector acceleration;
  color drawColor;
  int life; 
  
  Particle(PVector loc, color c)
  {
    location = loc.get();
    velocity = new PVector(0,0);
    acceleration = new PVector(0,.5);
    drawColor = c;
    life = 10 + (int)random(6)-3;
  }
  
  void update()
  {
    location.add(velocity);
    velocity.add(acceleration);
    life -= 1;
  }
  
  void draw()
  {
    pushMatrix();
      translate(location.x,location.y);
      noStroke();
      fill(drawColor,(life > 3 ? 175 : life*175/3));
      rect(-1,-1,2,2);
    popMatrix();
  }
  
  boolean isDead()
  {
    return life <= 0;
  }
}
