Block[][] block;

//blocks available in inventory
ArrayList<Block> inventory;
float index;

int blockLength;
float playerHeight;
int playerWidth;
PImage background;

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
}

void draw()
{
  image(background, 0, 0);
  
  //draw the terrain
  for (int i = 0; i < block.length; i++)
  {
    for (int j = 0; j < block[0].length; j++)
    {
        if (block[i][j] != null) 
         {
           image(block[i][j].texture, j * blockLength, i * blockLength);
         }
    } 
  }
  
  //draw the inventory
  drawInventory();
}

void mousePressed() {
  //switching left and right for now, as it feels more natural
  //feel free to change it back
  if (mouseButton == LEFT) block[int(mouseY / blockLength)][int(mouseX / blockLength)] = new Block(inventory.get((int)index).getType());
  else if (mouseButton == RIGHT) block[int(mouseY / blockLength)][int(mouseX / blockLength)] = null;
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
