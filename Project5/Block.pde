class Block {
  
  PImage texture;
  String type;
  int life;
  float conversionTime;
  int snowCount;
  
  Block(String blockType) {
    type = blockType;
    if (type.equals("grass")) texture = loadImage("data/grass.png");
    else if (type.equals("dirt")) texture = loadImage("data/dirt.png");
    else if (type.equals("cobble")) texture = loadImage("data/cobble.png");
    else if (type.equals("wood")) texture = loadImage("data/wood.png");
    else if (type.equals("leaf")) texture = loadImage("data/leaf.png");
    else if (type.equals("plank")) texture = loadImage("data/plank.png");
    else if (type.equals("glass")) texture = loadImage("data/glass.png");
    else if (type.equals("stone")) texture = loadImage("data/stone.png");
    else if (type.equals("brick")) texture = loadImage("data/brick.png");
    texture.resize(blockLength, blockLength);
    snowCount = 0;
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
    else if (type.equals("glass")) texture = loadImage("data/glass.png");
    else if (type.equals("stone")) texture = loadImage("data/stone.png");
    else if (type.equals("brick")) texture = loadImage("data/brick.png");
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
