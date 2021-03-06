class Tile{
  //tile type
  //trap? activated?
  boolean canmove;
  int light;
  
  Tile(){
    canmove = true;
  }
  
  void onstep(Map map){
    return;
  }
  
  void activate(Map map){
    return;
  }
  
  void renderTile(Map map, int x, int y){
    renderTile(x, y);
  }

  void renderTile(int x, int y){
    render(x * TILESIZE, y * TILESIZE);
  }
  
  void render(Map map, int x, int y){
    render(x, y);
  }
  
  void render(int x, int y){
    fill(192);
    rect(x, y, TILESIZE, TILESIZE);
  }

  void renderTileFog(int x, int y){
    renderFog(x * TILESIZE, y * TILESIZE);
  }

  void renderFog(int x, int y){
    fill(128);
    rect(x, y, TILESIZE, TILESIZE);
  }

}

PImage floorImage;
PImage stairImage;
PImage doorImage;
PImage wallImage;

void loadTiles() {
  floorImage = loadImage("images/floor_tile.png");
  stairImage = loadImage("images/stairs_up.png");
  doorImage = loadImage("images/door.png");
  wallImage = loadImage("images/wall.png");
}

class Floor extends Tile{
  //Hey, guess what? I don't do anything!
  void render(int x, int y) {
    image(floorImage, x, y, TILESIZE, TILESIZE);
  }
}

class Wall extends Tile{
  Wall(){
    canmove = false;
  }
  
  void render(int x, int y){
    image(wallImage, x, y, TILESIZE, TILESIZE);
  }
  
  void renderFog(int x, int y){
    fill(32, 32, 64);
    rect(x, y, TILESIZE, TILESIZE);
  }
}

class Stair extends Tile{
  void onstep(Map map){
    map.floorup = true;
  }
  
  void render(int x, int y){
    image(stairImage, x, y, TILESIZE, TILESIZE);
  }
}

class Door extends Tile{
  Door(){
    canmove = false;
  }
  
  void render(int x, int y){
    /*
    if(room1 != null)
      room1.render(map, x, y);
    if(room2 != null)
      room2.render(map, x, y);
    */
    if(canmove) {
      image(floorImage, x, y, TILESIZE, TILESIZE);
    } else {
      image(doorImage, x, y, TILESIZE, TILESIZE);
    }
  }
  
  void activate(Map map){
    canmove = !canmove;
  }
  
  void renderFog(int x, int y){
    if(canmove)
      fill(160);
    else
      fill(64, 48, 32);
    rect(x, y, TILESIZE, TILESIZE);
  }
}
