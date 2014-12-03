Block[][] block;

//blocks available in inventory
ArrayList<Block> inventory;
float index;

int blockLength;
float playerHeight;
int playerWidth;
PImage background;

PVector loc;
PVector vel;
PVector gravity;
boolean left, right, mouse1, mouse2;

void setup() {
  size(1000, 600);
  blockLength = 20;
  playerHeight = 1.8 * blockLength;
  playerWidth = blockLength;
  block = new Block[height / blockLength][width / blockLength]; 
  background = loadImage("data/background.png");
  background.resize(width, height);
  
  index = 0; //variable for selected block in inventory
  
  //inventory arraylist
  inventory = new ArrayList();
  inventory.add(new Block("grass",2));
  inventory.add(new Block("dirt",2));
  inventory.add(new Block("cobble",2));
  inventory.add(new Block("wood",2));
  inventory.add(new Block("leaf",2));
  
  loc = new PVector(width / 2, 0);
  vel = new PVector(0, 0);
  gravity = new PVector(0, 0.5);
  left = right = mouse1 = mouse2 = false;
}

void draw()
{
  image(background, 0, 0);
  
  //draw the terrain
  updateChar();
  drawChar();
  if (mouse1) block[int(mouseY / blockLength)][int(mouseX / blockLength)] = new Block(inventory.get((int)index).getType());
  else if (mouse2) block[int(mouseY / blockLength)][int(mouseX / blockLength)] = null;
  for (int i = 0; i < block.length; i++) {
    for (int j = 0; j < block[0].length; j++) {
      try {
        image(block[i][j].texture, j * blockLength, i * blockLength);
        if (loc.y + playerHeight >= i * blockLength && !(loc.y > (i + 1) * blockLength) && ((loc.x > j * blockLength && loc.x < (j + 1) * blockLength) || (loc.x + playerWidth > j * blockLength && loc.x + playerWidth < (j + 1) * blockLength) || (loc.x == j * blockLength))) {
          //loc = new PVector(loc.x, i * blockLength - playerHeight);
          vel = new PVector(0, 0);
          loc = new PVector(loc.x, i * blockLength - playerHeight);
        }
        try {//buggy af
          if (left && block[int(loc.y % 10) - 1][int(loc.x % 10) - 1] == null && block[int(loc.y % 10)][int(loc.x % 10) - 1] == null) loc.add(new PVector(-0.5, 0));
        } catch (Exception noExists) {}
        if (right) loc.add(new PVector(0.5, 0));
      } catch (Exception noExists) {}
    } 
  }
  //draw the inventory
  drawInventory();
}

float distanceTo(float x1, float y1, float x2, float y2) {
  return sqrt(pow(x1 - x2, 2) + pow(y1 - y2, 2)); 
}

void updateChar() {
  loc.add(vel);
  vel.add(gravity);
}

void drawChar() {
  pushMatrix();
    translate(loc.x, loc.y);
    fill(0);
    rect(0, 0, playerWidth, playerHeight);
  popMatrix();
}

void keyPressed() {
  if (key == 'a') left = true;
  else if (key == 'd') right = true;
  else if (key == 'w' && vel.y == 0) vel.y = -10;
  else if (key == CODED) {
    if (keyCode == LEFT) {
      index -= 1;
      if (index < 0) index += 5;
      index %= inventory.size();
    }
    else if (keyCode == RIGHT) {
      index += 1;
      index %= inventory.size();
    }
  }
}

void keyReleased() {
  if (key == 'a') left = false;
  else if (key == 'd') right = false;
}

void mousePressed() {
  if (mouseButton == LEFT) mouse1 = true;
  else if (mouseButton == RIGHT) mouse2 = true;
}

void mouseReleased() {
   if (mouseButton == LEFT) mouse1 = false;
   else if (mouseButton == RIGHT) mouse2 = false;
}

void mouseWheel(MouseEvent e)
{
  float count = e.getCount();
  float change = count/2;
  index += change;
  if (index < 0) index += 5;
  index %= inventory.size();
}

void drawInventory()
{
  fill(50,0,200,128);
  noStroke();
  rect(blockLength/2,blockLength/2,2.2*blockLength*inventory.size() + 0.2*blockLength, 2.4*blockLength);
  fill(255,50);
  rect(blockLength/2 + 2.2*blockLength*(int)index, blockLength/2, 2.4*blockLength, 2.4*blockLength);
  for (int i = 0; i < inventory.size(); i++)
  {
    image(inventory.get(i).texture, blockLength/2 + 2.2*blockLength*i + 0.2*blockLength, blockLength/2 + 0.2*blockLength);
  }
}
