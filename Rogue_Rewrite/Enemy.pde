class Wolf extends Enemy{

  boolean isalpha;
  
  Wolf(){
    this(1, 1, 10);
    //Why are you using this constructor??
  }
  
  Wolf(int x, int y){
    this(x, y, 5, false);
  }
  
  Wolf(int x, int y, int health){
    this(x, y, health, false);
  }
  
  Wolf(int x, int y, int health, boolean isalpha){
    this.x = x;
    this.y = y;
    this.maxHealth = health;
    this.health = health;
    this.isalpha = isalpha;
  }
  
  boolean turn(Map map){
    int wolfcount = - 1; //acts as confidence counter
    //and one of those wolves is this one, so -1
    float playerdistance = 9;
    boolean isplayernear = false;
    for(int i = -5; i < 5; i ++){
      for(int j = - 5; j < 5; j ++){
        if(i + x > 0 && i + x < map.width  &&  j + y > 0 && j + y < map.height){
          if(map.entities[i + x][j + y] instanceof Wolf){
            wolfcount ++;
            if(this.isalpha){
              if(((Wolf)map.entities[i + x][j + y]).isalpha){
                //Some really cool infighting I'm going to implement later -3/23/14
              }
            }
          }
          
          if(map.entities[i + x][j + y] instanceof Player){
            //RUN FOR YOUR LIVES!
            isplayernear = true;
            playerdistance = sqrt(pow(i, 2) + pow(j, 2));
          }
          
        }
      }
    }
    
    if(isplayernear && wolfcount >= 2 && astar(map, map.player.x, map.player.y)){
      astar(map, map.player.x, map.player.y);
      return true;
    }
    if(!isplayernear && wolfcount == 2){
      //Math here
    }
    if(isplayernear && wolfcount < 2){
      if(playerdistance > 3)
        run(map);
      else
        astar(map, map.player.x, map.player.y);
        
      return true;
    }
    return false;
  }
}

class Ghost extends Enemy{
  
  Ghost(int x, int y){
    this(x, y, 3);
  }
  
  Ghost(int x, int y, int health){
    this.x = x;
    this.y = y;
    this.maxHealth = health;
    this.health = health;
  }
  
  boolean turn(Map map){
    if(astar(map, map.player.x, map.player.y)){
      if(map.player.x == this.x){
        if(map.player.y == this.y + 1){
          attack(down, map);
          return true;
        }
        if(map.player.y == this.y - 1){
          attack(up, map);
          return true;
        }
      }
      if(map.player.y == this.y){
        if(map.player.x == this.x + 1){
          attack(right, map);
          return true;
        }
        if(map.player.x == this.x - 1){
          attack(left, map);
          return true;
        }
      }
    }
    return false;
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
      fill(32);
      rect((x + a - tempx) * tilesize + (frame * tempx), (y + b - tempy) * tilesize + (frame * tempy), tilesize, tilesize);
      
      fill(255, 255, 255);
      rect((x + a - tempx) * tilesize + (frame * tempx), (y + b - tempy) * tilesize + (frame * tempy), tilesize, 6);
      
      fill(0, 255, 0);
      rect((x + a - tempx) * tilesize + (frame * tempx), (y + b - tempy) * tilesize + (frame * tempy), (healthpercent) * tilesize, 6);
      
      frame += 4;
    }
    else{
      fill(32);
      rect((x + a) * tilesize, (y + b) * tilesize, tilesize, tilesize);
      
      fill(255, 255, 255);
      rect((x + a) * tilesize, (y + b) * tilesize, tilesize, 6);
      
      fill(0, 255, 0);
      rect((x + a) * tilesize, (y + b) * tilesize, (healthpercent) * tilesize, 6);
    }
  }
}
