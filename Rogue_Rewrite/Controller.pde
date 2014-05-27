class Controller{
  Player player;
  
  Controller(Player player){
    this.player = player;
  }
  
  void update(Map map){
    
  }
  
  boolean move(Map map){
    if(player.frame < 24)
      return false;

    //Movement in 4 directions
    if(keyboard.timedpress(UP, 100) && !keyboard.keys[DOWN]){
      if(!player.attack(MOVE_UP, map)){
        if(!player.move(MOVE_UP, map)){
          if(player.direction != MOVE_UP){
            player.direction = MOVE_UP;
            return true;
          }
          return false;
        }
        return true;
      }
      return false;
    }
    else if(keyboard.timedpress(LEFT, 100) && !keyboard.keys[RIGHT]){
      if(!player.attack(MOVE_LEFT, map)){
        if(!player.move(MOVE_LEFT, map)){
          if(player.direction != MOVE_LEFT){
            player.direction = MOVE_LEFT;
            return true;
          }
          return false;
        }
        return true;
      }
      return true;
    }
    else if(keyboard.timedpress(DOWN, 100) && !keyboard.keys[UP]){
      if(!player.attack(MOVE_DOWN, map)){
        if(!player.move(MOVE_DOWN, map)){
          if(player.direction != MOVE_DOWN){
            player.direction = MOVE_DOWN;
            return true;
          }
          return false;
        }
        return true;
      }
      return true;
    }
    else if(keyboard.timedpress(RIGHT, 100) && !keyboard.keys[LEFT]){
      if(!player.attack(MOVE_RIGHT, map)){
        if(!player.move(MOVE_RIGHT, map)){
          if(player.direction!= MOVE_RIGHT){
            player.direction = MOVE_RIGHT;
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
      switch(player.direction){
        case MOVE_UP:
          map.tiles[player.x][player.y - 1].activate(map);
          keyboard.cantoggle[122] = false;
        break;
        case MOVE_LEFT:
          map.tiles[player.x - 1][player.y].activate(map);
          keyboard.cantoggle[122] = false;
        break;
        case MOVE_DOWN:
          map.tiles[player.x][player.y + 1].activate(map);
          keyboard.cantoggle[122] = false;
        break;
        case MOVE_RIGHT:
          map.tiles[player.x + 1][player.y].activate(map);
          keyboard.cantoggle[122] = false;
        break;
      }
    }
    return false;
  }
}
