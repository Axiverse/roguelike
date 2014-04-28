abstract class Item{
  int quantity;
  int quality;
  //Icon
  abstract void activate(Dungeon dungeon);
  
  void render(int x, int y){
    //Some stuff here?
    fill(255);
    rect(x, y, TILESIZE + 4, TILESIZE + 4);
  }
}

class Tool extends Item{
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


