class Snow {
  
  PVector loc;
  PVector vel;
  PVector accel;
  
  Snow(PVector location) {
    loc = new PVector(location.x, location.y);
    vel = new PVector(0, 1);
    accel = new PVector(0, 0);
  }
  
  void update() {
    accel = new PVector(random(-0.01, 0.01), 0);
    vel.add(accel);
    loc.add(vel);
  }
  
  void render() {
    pushMatrix();
      translate(loc.x, loc.y);
      fill(255, 255, 255, 100);
      ellipse(0, 0, 5, 5);
    popMatrix();
  }
  
  boolean collided() {
    if (loc.y > 0 && loc.y < height && loc.x > 0 && loc.x < width) {
      if (blocks[(int)loc.y/blockLength][(int)loc.x/blockLength] != null) {
        blocks[(int)loc.y/blockLength][(int)loc.x/blockLength].snowCount++;
        return true;
      } else return false;
    } else return false;
  }
}
