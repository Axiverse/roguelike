class Player extends Creature{
  
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
    
    this.light = 8;
  }
  
  boolean input(Map map){
    if(frame < 24)
      return false;

    //Movement in 4 directions
    if(keyboard.timedpress(UP, 100) && !keyboard.keys[DOWN]){
      if(!attack(MOVE_UP, map)){
        if(!move(MOVE_UP, map)){
          if(direction != MOVE_UP){
            direction = MOVE_UP;
            return true;
          }
          return false;
        }
        return true;
      }
      return false;
    }
    else if(keyboard.timedpress(LEFT, 100) && !keyboard.keys[RIGHT]){
      if(!attack(MOVE_LEFT, map)){
        if(!move(MOVE_LEFT, map)){
          if(direction != MOVE_LEFT){
            direction = MOVE_LEFT;
            return true;
          }
          return false;
        }
        return true;
      }
      return true;
    }
    else if(keyboard.timedpress(DOWN, 100) && !keyboard.keys[UP]){
      if(!attack(MOVE_DOWN, map)){
        if(!move(MOVE_DOWN, map)){
          if(direction != MOVE_DOWN){
            direction = MOVE_DOWN;
            return true;
          }
          return false;
        }
        return true;
      }
      return true;
    }
    else if(keyboard.timedpress(RIGHT, 100) && !keyboard.keys[LEFT]){
      if(!attack(MOVE_RIGHT, map)){
        if(!move(MOVE_RIGHT, map)){
          if(direction!= MOVE_RIGHT){
            direction = MOVE_RIGHT;
            return true;
          }
          return false;
        }
        return true;
      }
      return true;
    }
    
    //Other buttons
    
    //attacking
    else if(keyboard.cantoggle[122] && keyboard.timedpress(122, 100)){
      switch(direction){
        case MOVE_UP:
          map.tiles[x][y - 1].activate(map);
          keyboard.cantoggle[122] = false;
        break;
        case MOVE_LEFT:
          map.tiles[x - 1][y].activate(map);
          keyboard.cantoggle[122] = false;
        break;
        case MOVE_DOWN:
          map.tiles[x][y + 1].activate(map);
          keyboard.cantoggle[122] = false;
        break;
        case MOVE_RIGHT:
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
      rect((x + a) * TILESIZE, (y + b) * TILESIZE, TILESIZE, TILESIZE);
      
      fill(255, 255, 255);
      rect((x + a) * TILESIZE, (y + b) * TILESIZE, TILESIZE, 6);
      
      fill(0, 255, 0);
      rect((x + a) * TILESIZE, (y + b) * TILESIZE, (healthpercent) * TILESIZE, 6);
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
      rect((x - tempx) * TILESIZE + (frame * tempx) + a, (y - tempy) * TILESIZE + (frame * tempy) + b, TILESIZE, TILESIZE);
      
      fill(255, 255, 255);
      rect((x - tempx) * TILESIZE + (frame * tempx) + a, (y - tempy) * TILESIZE + (frame * tempy) + b, TILESIZE, 6);
      
      fill(0, 255, 0);
      rect((x - tempx) * TILESIZE + (frame * tempx) + a, (y - tempy) * TILESIZE + (frame * tempy) + b, (healthpercent) * TILESIZE, 6);
      
      frame += 4;
    }
    else{
      fill(255, 0, 0);
      rect(x * TILESIZE + a, y * TILESIZE + b, TILESIZE, TILESIZE);
      
      fill(255, 255, 255);
      rect(x * TILESIZE + a, y * TILESIZE + b, TILESIZE, 6);
      
      fill(0, 255, 0);
      rect(x * TILESIZE + a, y * TILESIZE + b, (healthpercent) * TILESIZE, 6);
    }

  }
}
