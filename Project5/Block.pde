class Block {
  
  PImage texture;
  String type;
  int life;
  float conversionTime;
  
  Block(String blockType) {
    type = blockType;
    if (type.equals("grass")) texture = loadImage("data/grass.png");
    else if (type.equals("dirt")) texture = loadImage("data/dirt.png");
    else if (type.equals("cobble")) texture = loadImage("data/cobble.png");
    else if (type.equals("wood")) texture = loadImage("data/wood.png");
    else if (type.equals("leaf")) texture = loadImage("data/leaf.png");
    else if (type.equals("plank")) texture = loadImage("data/plank.png");
    texture.resize(blockLength, blockLength);
    life = millis();
    conversionTime = random(20000, 40000);
  }
  
  Block(String blockType, float scale)
  {
    type = blockType;
    if (type.equals("grass")) texture = loadImage("data/grass.png");
    else if (type.equals("dirt")) texture = loadImage("data/dirt.png");
    else if (type.equals("cobble")) texture = loadImage("data/cobble.png");
    else if (type.equals("wood")) texture = loadImage("data/wood.png");
    else if (type.equals("leaf")) texture = loadImage("data/leaf.png");
    else if (type.equals("plank")) texture = loadImage("data/plank.png");
    texture.resize((int)(blockLength*scale),(int)(blockLength*scale));
  }
  
  String getType()
  {
    return type;
  }
  
  PImage getTexture()
  {
    return texture;
  }
}
