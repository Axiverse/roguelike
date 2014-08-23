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
  
  abstract void activate(Map map);
  
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
  
  void activate(Map map){
    return;
  }
}

class Weapond extends Tool{
  int damage;
  
  void activate(Map map){
    Player temp = map.player;//I'm too lazy to type this out again
    switch(temp.direction){
      case MOVE_UP:
        
      break;
      case MOVE_LEFT:
      
      break;
      case MOVE_DOWN:
      
      break;
      case MOVE_RIGHT:
      
      break;
    }
  }
}


