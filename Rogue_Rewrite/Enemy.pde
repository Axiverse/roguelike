PImage wolfImage;
PImage ghostImage;
PImage heroImage;

void loadEnemies() {
  wolfImage = loadImage("images/wolf.png");
  ghostImage = loadImage("images/ghost.png"); 
  heroImage = loadImage("images/hero.png");
}

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
    return super.turn(map);
    /*
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
    */
  }
  
  void renderImage(int x, int y){
    //fill(0, 255, 255);
    //rect(x, y, TILESIZE, TILESIZE);
    image(wolfImage, x, y, TILESIZE, TILESIZE);
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
          attack(MOVE_DOWN, map);
          return true;
        }
        if(map.player.y == this.y - 1){
          attack(MOVE_UP, map);
          return true;
        }
      }
      if(map.player.y == this.y){
        if(map.player.x == this.x + 1){
          attack(MOVE_RIGHT, map);
          return true;
        }
        if(map.player.x == this.x - 1){
          attack(MOVE_LEFT, map);
          return true;
        }
      }
    }
    return false;
  }
  
  void renderImage(int x, int y){
    //fill(0);
    //rect(x, y, TILESIZE, TILESIZE);
    image(ghostImage, x, y, TILESIZE, TILESIZE);
  }
}
