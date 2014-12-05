abstract class BaseParticleSystem
{
  //standard properties for a particle system
  ArrayList<BaseParticle> particles;
  color systemColor;
  int max;
  
  //particle system setup
  BaseParticleSystem(int num, color c)
  {
    particles = new ArrayList<BaseParticle>();
    max = num;
    systemColor = c;
  }
  
  //go through the system and update/draw each particle
  //also, add and replentish particles
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
  
  //add a particle if there are less than the maximum number
  void populate()
  {
    if (particles.size() < max)
    {
      particles.add(newParticle());
    } 
  }
  
  //replace dead particles
  void replentish(BaseParticle p)
  {
    if (!p.isAlive())
    {
        particles.remove(p);
        particles.add(newParticle());
    }
  }
  
  //replace this with a particle object constructor
  BaseParticle newParticle()
  {
    return null;
  }
  
  //check to see if the system is out of particles
  boolean isAlive()
  {
    return particles.size() > 0;
  }
}
