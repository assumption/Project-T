 class Player
{
  PVector location;
  PVector hitbox;
  PVector velocity;
  PVector acceleration;
  boolean facingLeft;
  float leg1, leg2;
  float v1, v2;
  boolean brighter, turnBlue, turnGreen, turnRed, blink;
  float colorV;
  float hue;
  float lastTime, randTime;
  
  Player(PVector loc, PVector box)
  { 
    facingLeft = false;
    location = loc.get();
    hitbox = box.get();
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0.5);
    leg1 = blockLength / 3 - 2.5;
    leg2 = 2 * blockLength / 3 - 2.5;
    v1 = 1;
    v2 = -1;
    brighter = true;
    colorV = 0.5;
    hue = 0;
    turnBlue = true;
    turnGreen = turnRed = false;
    lastTime = millis();
    randTime = random(1000, 5000);
    blink = false;
  }
  
  void update()
  {
    float xVel = velocity.x;
    float yVel = velocity.y;
    location.x += xVel;
    if (xVel != 0) {
      leg1 += v1;
      leg2 += v2;
      if (leg1 > 2 * blockLength / 3 - 2.5 || leg1 < blockLength / 3 - 2.5) v1 *= -1;
      if (leg2 > 2 * blockLength / 3 - 2.5 || leg2 < blockLength / 3 - 2.5) v2 *= -1;
    } else {
      leg1 = blockLength / 3 - 2.5;
      leg2 = 2 * blockLength / 3 - 2.5; 
    }
    if (collided() && xVel != 0)
    {
      xVel = xVel/abs(xVel);
      while (collided())
      {
        location.x -= xVel;
      }
      velocity.x = 0;
    }
    if (abs(yVel) >= 1) location.y += yVel;
    if (collided() && yVel != 0)
    {
      yVel = yVel/abs(yVel);
      while (collided())
      {
        location.y -= yVel;
      }
      velocity.y = 0;
    }
    velocity.add(acceleration);
    
    if (brighter) hue += colorV;
    else hue -= colorV;
    if (hue > 100) brighter = false;
    else if (hue < 0) {
      brighter = true;
      if (turnBlue) {
        turnBlue = false;
        turnGreen = true; 
      } else if (turnGreen) {
        turnGreen = false;
        turnRed = true;
      } else if (turnRed) {
        turnRed = false;
        turnBlue = true;
      }
    }
  }
  
  void draw()
  {
    pushMatrix();
      translate(location.x, location.y);
       if (turnBlue) fill(hue / 20, hue / 20, hue);
      else if (turnGreen) fill(hue / 20, hue, hue / 20);
      else if (turnRed) fill(hue, hue / 20, hue / 20);
      pushMatrix();
        translate(leg1, 0);
        rect(0, 0, 5, hitbox.y);
      popMatrix();
      pushMatrix();
        translate(leg2, 0);
        rect(0, 0, 5, hitbox.y);
      popMatrix();
      rect(0, 0, hitbox.x, hitbox.y - 5);
      if (!blink) fill(255);
      else {
        if (turnBlue) fill(hue / 20, hue / 20, hue);
        else if (turnGreen) fill(hue / 20, hue, hue / 20);
        else if (turnRed) fill(hue, hue / 20, hue / 20);
        if (millis() - lastTime > 100) {
          blink = false;
          lastTime = millis();
          randTime = random(1000, 5000); 
        }
      }
      if (millis() - lastTime > randTime) {
        lastTime = millis();
        randTime = 900000001; // lol ghetto coding
        blink = true;
      }
      if (facingLeft) rect(hitbox.x / 10, hitbox.y / 10, 6 * hitbox.x / 10, hitbox.y / 5);
      else rect(3 * hitbox.x / 10, hitbox.y / 10, 6 * hitbox.x / 10, hitbox.y / 5);
    popMatrix();
  }
  
  boolean collided()
  {
    int i0 = (int)location.x/blockLength;
    int i1 = (int)(location.x+hitbox.x-1)/blockLength;
    int j0 = (int)location.y/blockLength;
    int j1 = (int)(location.y + hitbox.y/2-1)/blockLength;
    int j2 = (int)(location.y + hitbox.y-1)/blockLength;
    if (location.x < 0 || location.y < 0) return true;
    if (i0 < 0 || j0 < 0) return true;
    if (i1 >= blocks[0].length || j2 >= blocks.length) return true;
    return !(blocks[j0][i0] == null && blocks[j0][i1] == null && blocks[j1][i0] == null && blocks[j1][i1] == null && blocks[j2][i0] == null && blocks[j2][i1] == null);
  }
  
  //getters and setters
  
  void setHSpeed(float s)
  {
    velocity.x = s;
  }
  
  void setVSpeed(float s)
  {
    velocity.y = s;
  }
  
  void setVelocity(PVector vel)
  {
    velocity = vel.get();
  }
  
  void setLocation(PVector loc)
  {
    if (loc.x < 0 || loc.x + hitbox.x > width || loc.y < 0 || loc.y + hitbox.y > height) return;
    location = loc.get();
  }
  
  PVector getVelocity()
  {
    return velocity.get();
  }
  
  PVector getLocation()
  {
    return location.get();
  }
  
  PVector getHitbox()
  {
    return hitbox.get();
  }
}
