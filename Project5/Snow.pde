class Snow extends BaseParticleSystem
{
  Snow(int num, color c)
  {
    super(num,c);
  }
  
  void run()
  {
    this.populate();
    for (int i = particles.size()-1; i >= 0; i--)
    {
      BaseParticle p = (BaseParticle)particles.get(i);
      
      p.update();
      p.draw();
      
      this.replentish(p);
    }
  }
  
  void replentish(BaseParticle p)
  {
    if (!p.isAlive())
    {
        particles.remove(p);
        particles.add(newParticle());
    }
  }
  
  BaseParticle newParticle()
  {
    return new SnowParticle(new PVector(random(width),-50),systemColor);
  }
  
  boolean isAlive()
  {
    return true;
  }
}
