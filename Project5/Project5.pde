Block[][] blocks;
Player player;

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
  blocks = new Block[height / blockLength][width / blockLength]; 
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
  
  player = new Player(new PVector(width/2,0), new PVector(playerWidth,playerHeight));
  
  left = right = mouse1 = mouse2 = false;
}

void draw()
{
  image(background, 0, 0);
  
  //draw the terrain
  player.update();
  player.draw();
  
  //block placement/destroy
  if (mouse1)
  {
    PVector location = player.getLocation();
    PVector hitbox = player.getHitbox();
    int i0 = (int)location.x/blockLength;
    int i1 = (int)(location.x+hitbox.x-1)/blockLength;
    int j0 = (int)location.y/blockLength;
    int j1 = (int)(location.y + hitbox.y/2-1)/blockLength;
    int j2 = (int)(location.y + hitbox.y-1)/blockLength;
    int mx = (int)mouseX/blockLength;
    int my = (int)mouseY/blockLength;
    boolean flag =  ((i0 == mx && (my == j0 || my == j1 || my == j2)) || (i1 == mx && (my == j0 || my == j1 || my == j2)));
    if (!flag) blocks[my][mx] = new Block(inventory.get((int)index).getType());
  }
  else if (mouse2)
  {
    blocks[int(mouseY / blockLength)][int(mouseX / blockLength)] = null;
  }
  
  //render blocks
  for (int i = 0; i < blocks.length; i++) {
    for (int j = 0; j < blocks[0].length; j++) {
      if (blocks[i][j] != null) image(blocks[i][j].texture, j * blockLength, i * blockLength);
    } 
  }
  
  //draw the inventory
  drawInventory();
}

float distanceTo(float x1, float y1, float x2, float y2) {
  return sqrt(pow(x1 - x2, 2) + pow(y1 - y2, 2)); 
}

void keyPressed() {
  if (key == 'a') player.setHSpeed(-2);
  else if (key == 'd') player.setHSpeed(2);
  if (key == 'w' && player.getVelocity().x == 0) player.setVSpeed(-10);
  if (key == CODED) {
    if (keyCode == LEFT) {
      index -= 1;
      if (index < 0) index += 5;
      index %= inventory.size();
    } else if (keyCode == RIGHT) {
      index += 1;
      index %= inventory.size();
    } else if (keyCode == CONTROL) {
      player.setVelocity(new PVector());
      player.setLocation(new PVector(mouseX,mouseY));
    }
  }
}

void keyReleased() {
  if (key == 'a' || key == 'd')
  {
    player.setHSpeed(0);
  }
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
