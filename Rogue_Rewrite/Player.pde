class Player extends Entity{
  
  Item[] items;
  
  Player(int x, int y){
    this.x = x;
    this.y = y;
    this.maxHealth = 100;
    this.health = maxHealth;
    this.calculatehealth();
    items = new Item[4];
    for(int i = 0; i < items.length; i ++){
      items[i] = new Weapond();
    }
  }
  
  boolean input(Map map){
    if(frame < 24)
      return false;
    
    //Movement in 4 directions
    if(keyboard.timedpress(UP, 100) && !keyboard.keys[DOWN]){
      if(!attack(up, map)){
        if(!move(up, map)){
          if(direction != up){
            direction = up;
            return true;
          }
        }
        return true;
      }
      return false;
    }
    else if(keyboard.timedpress(LEFT, 100) && !keyboard.keys[RIGHT]){
      if(!attack(left, map)){
        if(!move(left, map) && direction != left){
          direction = left;
          return true;
        }
      }
      return true;
    }
    else if(keyboard.timedpress(DOWN, 100) && !keyboard.keys[UP]){
      if(!attack(down, map)){
        if(!move(down, map) && direction != down){
          direction = down;
          return true;
        }
      }
      return true;
    }
    else if(keyboard.timedpress(RIGHT, 100) && !keyboard.keys[LEFT]){
      if(!attack(right, map)){
        if(!move(right, map) && direction!= right){
          direction = right;
          return true;
        }
      }
      return true;
    }
    
    //Other buttons
    else if(keyboard.cantoggle[122] && keyboard.timedpress(122, 100)){
      switch(direction){
        case up:
          map.tiles[x][y - 1].activate(map);
          keyboard.cantoggle[122] = false;
        break;
        case left:
          map.tiles[x - 1][y].activate(map);
          keyboard.cantoggle[122] = false;
        break;
        case down:
          map.tiles[x][y + 1].activate(map);
          keyboard.cantoggle[122] = false;
        break;
        case right:
          map.tiles[x + 1][y].activate(map);
          keyboard.cantoggle[122] = false;
        break;
      }
    }
    return false;
  }
  
  boolean turn(Map map){
    return false;
  }
  
  void renderStill(int a, int b){
      //this.frame = 24;
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
      rect((x - tempx) * tilesize + (frame * tempx) + a, (y - tempy) * tilesize + (frame * tempy) + b, tilesize, tilesize);
      
      fill(255, 255, 255);
      rect((x - tempx) * tilesize + (frame * tempx) + a, (y - tempy) * tilesize + (frame * tempy) + b, tilesize, 6);
      
      fill(0, 255, 0);
      rect((x - tempx) * tilesize + (frame * tempx) + a, (y - tempy) * tilesize + (frame * tempy) + b, (healthpercent) * tilesize, 6);
      
      frame += 4;
    }
    else{
      fill(255, 0, 0);
      rect(x * tilesize + a, y * tilesize + b, tilesize, tilesize);
      
      fill(255, 255, 255);
      rect(x * tilesize + a, y * tilesize + b, tilesize, 6);
      
      fill(0, 255, 0);
      rect(x * tilesize + a, y * tilesize + b, (healthpercent) * tilesize, 6);
    }

  }
}
