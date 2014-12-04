Block[][] blocks;
Player player;
ArrayList<ParticleSystem> systems;

//blocks available in inventory
ArrayList<Block> inventory;
HashMap<String,Integer> blockCount;
float index;

int blockLength;
float playerHeight;
int playerWidth;
PImage background;

PVector loc;
PVector vel;
PVector gravity;
boolean mouse1, mouse2;

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
  inventory.add(new Block("plank",2));
  
  //inventory count
  blockCount = new HashMap<String,Integer>();
  for (Block b : inventory)
  {
    blockCount.put(b.getType(), 0);
  }
  
  blockCount.put("plank", -1);
  
  player = new Player(new PVector(width/2,0), new PVector(playerWidth,playerHeight));
  
  mouse1 = mouse2 = false;
  
  //temp fill for terrain
  int h = blocks.length;
  
  for (int i = 0; i < blocks[0].length; i++)
  {
    blocks[(int)(h-5)][i] = new Block("grass");
    blocks[(int)(h-4)][i] = new Block("dirt");
    blocks[(int)(h-3)][i] = new Block("cobble");
    blocks[(int)(h-2)][i] = new Block("cobble");
    blocks[(int)(h-1)][i] = new Block("cobble");
  }
  
  generateTree(10,h-6);
  
  systems = new ArrayList<ParticleSystem>();
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
    //place blocks, but make sure that they aren't placed on the character
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
    flag = flag || (my < 0 || my >= blocks.length || mx < 0 || mx >= blocks[0].length);
    if (!flag) flag = blocks[my][mx] != null;
    String type = inventory.get((int)index).getType();
    if (!flag && (int)blockCount.get(type) != 0) 
    {
      PVector loc = player.getLocation();
      if (sqrt(sq((loc.x+blockLength/2)-mouseX) + sq((loc.y+.9*blockLength)-mouseY)) < 5*blockLength)
      {
        blocks[my][mx] = new Block(type);
        blockCount.put(type, (int)blockCount.get(type)-1);
      }
    }
  }
  else if (mouse2)
  {
    int mx = (int)mouseX/blockLength;
    int my = (int)mouseY/blockLength;
    boolean flag = (my < 0 || my >= blocks.length || mx < 0 || mx >= blocks[0].length);
    if (!flag) flag = flag || blocks[my][mx] == null;
    if (!flag)
    {
      PVector loc = player.getLocation();
      if (sqrt(sq((loc.x+blockLength/2)-mouseX) + sq((loc.y+.9*blockLength)-mouseY)) < 5*blockLength)
      {
        systems.add(new ParticleSystem(10, new PVector(mx*blockLength, my*blockLength), blocks[my][mx].getTexture()));
        blockCount.put(blocks[my][mx].getType(), (int)blockCount.get(blocks[my][mx].getType())+1);
        blocks[my][mx] = null;
      }
    }
  }
  
  //render block destroy particles
  for (int i = systems.size()-1; i >= 0; i--)
  {
    ParticleSystem s = systems.get(i);
    s.update();
    if (s.isDead())
    {
      systems.remove(s);
    }
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
  if (key == 'w')
  {
    PVector location = player.getLocation();
    PVector hitbox = player.getHitbox();
    int i0 = (int)location.x/blockLength;
    int i1 = (int)(location.x+hitbox.x-1)/blockLength;
    int j2 = (int)(location.y + hitbox.y)/blockLength;
    if (j2 >= blocks.length || blocks[j2][i0] != null || blocks[j2][i1] != null)
    {
      player.setVSpeed(-7);
    }
  }
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
  rect(blockLength/2,blockLength/2,2.2*blockLength*inventory.size() + 0.2*blockLength, 2.4*blockLength+16);
  fill(255,75);
  rect(blockLength/2 + 2.2*blockLength*(int)index, blockLength/2, 2.4*blockLength, 2.4*blockLength);
  fill(255);
  textSize(10);
  for (int i = 0; i < inventory.size(); i++)
  {
    float x = blockLength/2 + 2.2*blockLength*i + 0.2*blockLength;
    float y = blockLength/2 + 0.2*blockLength;
    image(inventory.get(i).texture, x, y);
    if (blockCount.get(inventory.get(i).getType()) == 0)
    {
      fill(0,128);
      rect(x,y,inventory.get(i).texture.width,inventory.get(i).texture.height);
      fill(255,128);
    }
    else
    {
      fill(255);
    }
    text(blockCount.get(inventory.get(i).getType()), x, y + 2.4*blockLength + 6);
  }
}

void generateTree(int x, int y)
{
  blocks[y][x] = new Block("wood");
  blocks[y-1][x] = new Block("wood");
  blocks[y-2][x] = new Block("wood");
  blocks[y-3][x] = new Block("wood");
  blocks[y-4][x-2] = new Block("leaf");
  blocks[y-4][x-1] = new Block("leaf");
  blocks[y-4][x] = new Block("wood");
  blocks[y-4][x+1] = new Block("leaf");
  blocks[y-4][x+2] = new Block("leaf");
  blocks[y-5][x-2] = new Block("leaf");
  blocks[y-5][x-1] = new Block("leaf");
  blocks[y-5][x] = new Block("wood");
  blocks[y-5][x+1] = new Block("leaf");
  blocks[y-5][x+2] = new Block("leaf");
  blocks[y-6][x-1] = new Block("leaf");
  blocks[y-6][x] = new Block("leaf");
  blocks[y-6][x+1] = new Block("leaf");
  blocks[y-7][x-1] = new Block("leaf");
  blocks[y-7][x] = new Block("leaf");
  blocks[y-7][x+1] = new Block("leaf");
}
