Block[][] block;

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
}

void draw() {
  image(background, 0, 0);
  for (int i = 0; i < block.length; i++) {
    for (int j = 0; j < block[0].length; j++) {
      try {
        image(block[i][j].texture, j * blockLength, i * blockLength);
      } catch (Exception kappa) {}
    } 
  }
}

void mousePressed() {
  if (mouseButton == RIGHT) block[int(mouseY / blockLength)][int(mouseX / blockLength)] = new Block("grass");
  else block[int(mouseY / blockLength)][int(mouseX / blockLength)] = null;
}

