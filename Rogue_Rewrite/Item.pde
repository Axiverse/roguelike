abstract class Item extends Entity{
  int quantity;
  int quality;
  //Icon
  
  Item(){
    this(0,0);
  }
  
  Item(int x, int y){
    this.x = x;
    this.y = y;
    light = 0;
  }
  
  abstract void activate(Dungeon dungeon);
  
  void renderTile(int a, int b){
    //Some stuff here?
    //do the offset thing
    fill(255);
    rect((x + a) * TILESIZE, (y + b) * TILESIZE, TILESIZE, TILESIZE);
  }
}

class Tool extends Item{
  void renderStill(int a, int b){
    
  }
  
  void activate(Dungeon dungeon){
    return;
  }
}

class Weapond extends Tool{
  int damage;
  
  void activate(Dungeon dungeon){
    Player temp = dungeon.map.player;//I'm too lazy to type this out again
    switch(temp.direction){
      case up:
        
      break;
      case left:
      
      break;
      case down:
      
      break;
      case right:
      
      break;
    }
  }
}


