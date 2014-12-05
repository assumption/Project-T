class Player
{
  PVector location;
  PVector hitbox;
  PVector velocity;
  PVector acceleration;
  boolean facingLeft;
  
  //variables from james's code
  PImage bg;
  PImage face;
  PImage weapon;
  PImage body;
  PImage arm;
  PImage frontLeg;
  PImage leg;
  PImage bottom;
  
  float backA, frontA, backL, frontL, backF, frontF;
  
  boolean armsMove = false;
  boolean feetsMove = false;
  boolean legsMove = false;
  boolean animateCharacter = true;
  //end variables
  
  Player(PVector loc, PVector box)
  { 
    facingLeft = true;
    location = loc.get();
    hitbox = box.get();
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0.5);
    
    //player textures
    face = loadImage("data/EvanHead.png");
    face.resize(55, 55);
  
    weapon = loadImage("data/weapon.png");
    weapon.resize(60, 60);
  
    body = loadImage("data/body.png");
    body.resize(55, 65);
  
    arm = loadImage("data/frontA.png");
    arm.resize(40, 60);
  
  
    leg = loadImage("data/leg.png");
    leg.resize(20, 20);
  
    frontLeg = loadImage("data/leg.png");
    frontLeg.resize(20, 30);
  
  
    bottom = loadImage("data/bottom.png");
    bottom.resize(60, 40);
  }
  
  void update()
  {
    float xVel = velocity.x;
    float yVel = velocity.y;
    location.x += xVel;
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
  }
  
  void draw()
  {
    pushMatrix();
      pushMatrix();
      translate(location.x+blockLength/2, location.y+blockLength/4);
      scale(.4);
      //back leg
      pushMatrix();
        translate(2, 62);
        rotate(backL);
        translate(0, 6);
        image(leg, -12, -8);
        //back feet
        ellipse(3, 13, 15, 5);
      popMatrix();
    
    
      //back arm
      pushMatrix();
        translate(0, 30);//move into draw position
        rotate(backA);
        translate(0, -20);
        image(arm, -17, 10);
      popMatrix();
    
      //body
      fill(#F2CA00);
      image(body, -26, 0);
      image(bottom, -16, 25);
    
      //head
      pushMatrix();
        image(face, -25, -35);
      popMatrix();
    
      //front leg
      pushMatrix();
        translate(2, 62);
        rotate(frontL);
        translate(2, 6);
        image(frontLeg, -18, -14);
        //front feet
        ellipse(-1, 13, 15, 5);
      popMatrix();
    
      //front arm
      pushMatrix();
        translate(-20, 25);//move into draw position
        rotate(frontA);
        translate(0, -20);
        image(weapon, 2, -10);
        image(arm, -17, 10);
      popMatrix();
      popMatrix();
      
      //hitbox
      /*translate(location.x,location.y);
      fill(0);
      rect(0, 0, hitbox.x, hitbox.y);
      fill(255);
      if (facingLeft) rect(hitbox.x / 10, hitbox.y / 10, 6 * hitbox.x / 10, hitbox.y / 5);
      else rect(3 * hitbox.x / 10, hitbox.y / 10, 6 * hitbox.x / 10, hitbox.y / 5);*/
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
