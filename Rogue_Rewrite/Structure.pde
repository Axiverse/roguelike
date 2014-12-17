abstract class Structure{
  int x, y;
  int width, height;
  
  Tile tiles[][];
  ArrayList<Structure> adjacent;
  
  //abstract void renderTileFog(int x, int y);
  abstract void renderTile(Map map, int x, int y);
  abstract void renderEntityTile(Map map, int x, int y);
  abstract void renderTileFog(Map map, int x, int y);
  
  abstract void render(Map map, int x, int y);
  abstract void renderEntity(Map map, int x, int y);
  abstract void renderFog(Map map, int x, int y);
  
  abstract void generate(Map map);
  
  boolean inBounds(int x, int y){
    if(this.x < x && this.y < y && this.x + width > x && this.y + height > y)
      return true;
    return false;
  }
}

class Room extends Structure{
  boolean hasStarirs;
  boolean doorOpen;
  
  Room(){
    println("why are you using this ROOM constructor?");
    return;
  }
  
  Room(int x, int y, int width, int height){
    adjacent = new ArrayList();
    
    tiles = new Tile[width][height];
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    
  }
  
  
  void renderTile(Map map, int x, int y){
    for(int i = 0; i < width; i ++){
      for(int j = 0; j < height; j ++){
        if(map.tiles[this.x + i][this.y + j] != null)
          map.tiles[this.x + i][this.y + j].renderTile(map, this.x + i + x, this.y + j + y);
      }
    }
    
    renderEntityTile(map, x, y);
  }
  
  void renderEntityTile(Map map, int x, int y){
    for(int i = 0; i < width; i ++){
      for(int j = 0; j < height; j ++){
        if(map.items[this.x + i][this.y + j] != null)
          map.items[this.x + i][this.y + j].renderTile(x, y);
        if(map.creatures[this.x + i][this.y + j] != null)
          map.creatures[this.x + i][this.y + j].renderTile(x, y);
      }
    }
  }
  
  void renderTileFog(Map map, int x, int y){
    for(int i = 0; i < width; i ++){
      for(int j = 0; j < height; j ++){
        if(map.tiles[this.x + i][this.y + j] != null)
          map.tiles[this.x + i][this.y + j].renderTileFog(this.x + i + x, this.y + j + y);
      }
    }
  }
  
  void render(Map map, int x, int y){
    for(int i = 0; i < width; i ++){
      for(int j = 0; j < height; j ++){
        if(map.tiles[this.x + i][this.y + j] != null){
          map.tiles[this.x + i][this.y + j].render(map, x + (this.x + i) * TILESIZE, y + (this.y + j) * TILESIZE);
          //println(this.x + i);
        }
      }
    }
  }
  
  void renderEntity(Map map, int x, int y){
    for(int i = 0; i < width; i ++){
      for(int j = 0; j < height; j ++){
        if(map.items[this.x + i][this.y + j] != null)
          map.items[this.x + i][this.y + j].render(x, y);
        if(map.creatures[this.x + i][this.y + j] != null){
          if(map.creatures[this.x + i][this.y + j] instanceof Player)
            continue;
          else
            map.creatures[this.x + i][this.y + j].render(x, y);
          //println(this.x + i);
        }
      }
    }
  }
  
  void renderFog(Map map, int x, int y){
    for(int i = 0; i < width; i ++){
      for(int j = 0; j < height; j ++){
        if(map.tiles[this.x + i][this.y + j] != null){
          map.tiles[this.x + i][this.y + j].renderFog(x + (this.x + i) * TILESIZE, y + (this.y + j) * TILESIZE);
          //println(this.x + i);
        }
      }
    }
  }
  
  void generate(Map map){
    for(int i = 0; i < width; i ++){
      for(int j = 0; j < height; j ++){
        map.tiles[i + x][j + y] = new Floor();
      }
    }
    
    for(int i = 0; i < width; i ++){
      map.tiles[x + i][y] = new Wall();
      map.tiles[x + i][y + height - 1] = new Wall();
    }
    
    for(int j = 0; j < height; j ++){
      map.tiles[x][j + y] = new Wall();
      map.tiles[x + width - 1][y + j] = new Wall();
    }
    
  }
}

