class Player extends Entity{
  
  Item[] items;
  
  Player(int x, int y){
    this.x = x;
    this.y = y;
    this.health = 100;
    this.currenthealth = health;
    items = new Item[4];
    for(int i = 0; i < items.length; i ++){
      items[i] = new Weapond();
    }
  }
  
  boolean input(Map map){
    if(frame < 24)
      return false;
    
    if(keyboard.timedpress(UP, 100) && !keyboard.keys[DOWN]){
      if(!move(up, map) && !attack(up, map)){
        return false;
      }
      return true;
    }
    else if(keyboard.timedpress(LEFT, 100) && !keyboard.keys[RIGHT]){
      if(!move(left, map) && !attack(left, map)){
        return false;
      }
      return true;
    }
    else if(keyboard.timedpress(DOWN, 100) && !keyboard.keys[UP]){
      if(!move(down, map) && !attack(down, map)){
        return false;
      }
      return true;
    }
    else if(keyboard.timedpress(RIGHT, 100) && !keyboard.keys[LEFT]){
      if(!move(right, map) && !attack(right, map)){
        return false;
      }
      return true;
    }
    return false;
  }
  
  boolean turn(Map map){
    return false;
  }
  
  void renderStill(int a, int b){
      fill(255, 0, 0);
      rect((x + a) * tilesize, (y + b) * tilesize, tilesize, tilesize);
      
      fill(255, 255, 255);
      rect((x + a) * tilesize, (y + b) * tilesize, tilesize, 6);
      
      fill(0, 255, 0);
      rect((x + a) * tilesize, (y + b) * tilesize, (healthpercent) * tilesize, 6);
  }
  
  void render(int a, int b){
    int tempx, tempy;
    if(direction % 2 == 1){//Vertical directions
      tempx = 0;
      if(direction == 1)
        tempy = -1;
      else
        tempy = 1;
    }
    else{
      tempy = 0;
      if(direction == 2)
        tempx = -1;
      else
        tempx = 1;
    }
    
    if(frame < 24){
      fill(255, 0, 0);
      rect((x + a - tempx) * tilesize + (frame * tempx), (y + b - tempy) * tilesize + (frame * tempy), tilesize, tilesize);
      
      fill(255, 255, 255);
      rect((x + a - tempx) * tilesize + (frame * tempx), (y + b - tempy) * tilesize + (frame * tempy), tilesize, 6);
      
      fill(0, 255, 0);
      rect((x + a - tempx) * tilesize + (frame * tempx), (y + b - tempy) * tilesize + (frame * tempy), (healthpercent) * tilesize, 6);
      
      frame += 4;
    }
    else{
      fill(255, 0, 0);
      rect((x + a) * tilesize, (y + b) * tilesize, tilesize, tilesize);
      
      fill(255, 255, 255);
      rect((x + a) * tilesize, (y + b) * tilesize, tilesize, 6);
      
      fill(0, 255, 0);
      rect((x + a) * tilesize, (y + b) * tilesize, (healthpercent) * tilesize, 6);
    }

  }
}
