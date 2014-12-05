class SnowParticle extends BaseParticle
{
  SnowParticle(PVector location, color c)
  {
    super(location,c);
    velocity = new PVector(0,1);
  }
  
  void draw()
  {
    pushMatrix();
      translate(position.x,position.y);
      fill(drawColor,100);
      stroke(drawColor);
      ellipse(0,0,2,2);
    popMatrix();
  }
  
  boolean isAlive()
  {
    if (position.y >= height) return false;
    if (position.y <= 0) return true;
    if (blocks[(int)(position.y/blockLength)][(int)(position.x/blockLength)] != null) return false;
    return true;
  }
}
