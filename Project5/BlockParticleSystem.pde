class BlockParticleSystem extends BaseParticleSystem
{
  PImage texture;
  PVector location;
  
  BlockParticleSystem(int size, PVector loc, PImage tex)
  {
    super(size, color(0,0));
    texture = tex.get();
    location = loc.get();
    
    texture.loadPixels();
    for (int i = 0; i < size; i++)
    {
      int r = (int)random(texture.pixels.length);
      color c = texture.pixels[r];
      int x = r % texture.width;
      int y = (int)r/texture.height;
      
      particles.add(new BlockParticle(new PVector(location.x+x,location.y+y), c));
    }
  }
  
  void run()
  {
    for (int i = particles.size()-1; i >= 0; i--)
    {
      BlockParticle p = (BlockParticle)particles.get(i);
      p.update();
      p.draw();
      if (p.isDead())
      {
        particles.remove(i);
      }
    }
  }
  
  boolean isAlive()
  {
    return (particles.size() > 0);
  }
}
