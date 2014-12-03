class ParticleSystem
{
  ArrayList<Particle> particles;
  PImage texture;
  PVector location;
  
  ParticleSystem(int size, PVector loc, PImage tex)
  {
    texture = tex.get();
    location = loc.get();
    
    particles = new ArrayList<Particle>();
    texture.loadPixels();
    for (int i = 0; i < size; i++)
    {
      int r = (int)random(texture.pixels.length);
      color c = texture.pixels[r];
      int x = r % texture.width;
      int y = (int)r/texture.height;
      
      particles.add(new Particle(new PVector(location.x+x,location.y+y), c));
    }
  }
  
  void update()
  {
    for (int i = particles.size()-1; i >= 0; i--)
    {
      Particle p = particles.get(i);
      p.update();
      p.draw();
      if (p.isDead())
      {
        particles.remove(i);
      }
    }
  }
  
  boolean isDead()
  {
    return !(particles.size() > 0);
  }
}
