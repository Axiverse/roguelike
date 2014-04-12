abstract class Entity{
  int health;
  int currenthealth;
  float healthpercent;
  int x, y;
  int direction;
  
  int frame;
  
  //weapon
  //armor
  //etc
  
  Entity(){
    this(1, 1, 10);
  }
  
  Entity(int x, int y, int health){
    this.x = x;
    this.y = y;
    this.health = health;
    currenthealth = health;
    healthpercent = (float) currenthealth / (float) health;
    frame = 24;
  }
  
  abstract boolean turn(Map map);
  
  boolean astar(Map map, int goalx, int goaly){
    
    if(goalx < 0 || goalx > map.width || goaly < 0 || goaly > height){
      return false;
    }
    
    if(goalx == this.x){
      if(goaly == this.y + 1){
        return true;
      }
      if(goaly == this.y - 1){
        return true;
      }
    }
    if(goaly == this.y){
      if(goalx == this.x + 1){
        return true;
      }
      if(goalx == this.x - 1){
        return true;
      }
    }
    
    //print("searching for best path \n");
    int lowx = 0;
    int lowy = 0;
    int lowvalue = 100;
    
    int opennodes[][] = new int[map.width][map.height]; //contains the g: travel distance from start
    int closenodes[][] = new int[map.width][map.height];
    
    for(int i = 0; i < map.width; i ++){
      for(int j = 0; j < map.height; j ++){
        opennodes[i][j] = -1; // 10^5: appropriate substitute for infinity
        closenodes[i][j] = 0;
      }
    }
    
    opennodes[this.x][this.y] = 0;
    
    int pleasedontcrashjava = 0;
    
    while(closenodes[goalx][goaly] == 0){
      
      pleasedontcrashjava ++;
      if(pleasedontcrashjava > 1000){
        return false;
      }
      for(int i = 1; i < map.width - 1; i ++){
        for(int j = 1; j < map.height - 1; j ++){
          //(opennodes[i][j] + sqrt(pow(i - goalx, 2) + pow(j - goaly, 2)))
          if(opennodes[i][j] != -1 && (opennodes[i][j] + abs(i - goalx) + abs(j - goaly) ) < lowvalue){//Moving 100+ spaces is just ridiculous
            lowx = i;
            lowy = j;
            lowvalue = (opennodes[i][j] + abs(i - goalx) + abs(j - goaly) );
          }
        }
      }
      //print("x: " + lowx + "\n");
      //print("y: " + lowy + "\n");
      
      /*
      if(opennodes[lowx][lowy - 1] == -1  && closenodes[lowx][lowy - 1] == 0 && map.tiles[lowx][lowy - 1] != null){
        if(map.tiles[lowx][lowy - 1].canmove){
          if(map.entities[lowx][lowy - 1] == null)
            opennodes[lowx][lowy - 1] = opennodes[lowx][lowy] + 1;
          else
            opennodes[lowx][lowy - 1] = opennodes[lowx][lowy] + 5;
        }
        else{
          opennodes[lowx][lowy - 1] = opennodes[lowx][lowy] + 100;
        }
      }
      
      if(opennodes[lowx - 1][lowy] == -1  && closenodes[lowx - 1][lowy] == 0 && map.tiles[lowx - 1][lowy] != null){
        if(map.tiles[lowx - 1][lowy].canmove){
          if(map.entities[lowx - 1][lowy] == null)
            opennodes[lowx - 1][lowy] = opennodes[lowx][lowy] + 1;
          else
            opennodes[lowx - 1][lowy] = opennodes[lowx][lowy] + 5;
        }
        else{
          opennodes[lowx - 1][lowy] = opennodes[lowx][lowy] + 100;
        }
      }
      
      if(opennodes[lowx][lowy + 1] == -1  && closenodes[lowx][lowy + 1] == 0 && map.tiles[lowx][lowy + 1] != null){
        if(map.tiles[lowx][lowy + 1].canmove){
          if(map.entities[lowx][lowy + 1] == null)
            opennodes[lowx][lowy + 1] = opennodes[lowx][lowy] + 1;
          else
            opennodes[lowx][lowy + 1] = opennodes[lowx][lowy] + 5;
        }
        else{
          opennodes[lowx][lowy + 1] = opennodes[lowx][lowy] + 100;
        }
      }
      
      if(opennodes[lowx + 1][lowy] == -1  && closenodes[lowx + 1][lowy] == 0 && map.tiles[lowx + 1][lowy] != null){
        if(map.tiles[lowx + 1][lowy].canmove){
          if(map.entities[lowx + 1][lowy] == null)
            opennodes[lowx + 1][lowy] = opennodes[lowx][lowy] + 1;
          else
            opennodes[lowx + 1][lowy] = opennodes[lowx][lowy] + 5;
        }
        else{
          opennodes[lowx + 1][lowy] = opennodes[lowx][lowy] + 100;
        }
      }
      */
      if(opennodes[lowx][lowy - 1] == -1 && closenodes[lowx][lowy - 1] == 0 && map.tiles[lowx][lowy - 1] != null){
        if(map.tiles[lowx][lowy - 1].canmove){
          if(map.entities[lowx][lowy - 1] == null){
            opennodes[lowx][lowy - 1] = opennodes[lowx][lowy] + 1;
          }
          else{
            //opennodes[lowx][lowy - 1] = opennodes[lowx][lowy] + 5;
          }
        }
        else{
          //opennodes[lowx + 1][lowy] = opennodes[lowx][lowy] + 100;
        }
      }
      
      if(map.tiles[lowx - 1][lowy] != null && map.tiles[lowx - 1][lowy].canmove && opennodes[lowx - 1][lowy] == -1 && closenodes[lowx - 1][lowy] == 0)
        opennodes[lowx - 1][lowy] = opennodes[lowx][lowy] + 1;
        
      if(map.tiles[lowx][lowy + 1] != null && map.tiles[lowx][lowy + 1].canmove && opennodes[lowx][lowy + 1] == -1 && closenodes[lowx][lowy + 1] == 0)
        opennodes[lowx][lowy + 1] = opennodes[lowx][lowy] + 1;
        
      if(map.tiles[lowx + 1][lowy] != null && map.tiles[lowx + 1][lowy].canmove && opennodes[lowx + 1][lowy] == -1 && closenodes[lowx + 1][lowy] == 0)
        opennodes[lowx + 1][lowy] = opennodes[lowx][lowy] + 1;
        
      closenodes[lowx][lowy] = opennodes[lowx][lowy];
      opennodes[lowx][lowy] = -1;
      lowvalue = 100;
      
      //print(opennodes[this.x + 1][this.y] + "\n");
    }
    
    //trace path back to start
    //print("tracing path \n");
    //print("distance to start: " + closenodes[goalx][goaly]);
    int findx = goalx;
    int findy = goaly;
    int previous = closenodes[goalx][goaly];
    /*
    print("\n");
    for(int j = 0; j < map.width - 1; j ++){
      for(int i = 0; i < map.height - 1; i ++){
        print(closenodes[i][j] + " ");
      }
      print("\n");
    }
    */
    ///*
    while(true){
      //print("finding");
      if(closenodes[findx][findy - 1] == previous - 1){
        findy --;
        //print("y-");
      }
      else if(closenodes[findx - 1][findy] == previous - 1){
        findx --;
        //print("x-");
      }
      else if(closenodes[findx][findy + 1] == previous - 1){
        findy ++;
        //print("y+");
      }
      else if(closenodes[findx + 1][findy] == previous - 1){
        findx ++;
        //print("x+");
      }
      
      previous = closenodes[findx][findy];
      //print(previous);
      if(previous == 1){
        if(findx == this.x){
          if(findy == this.y + 1){
            move(down, map);
            break;
          }
          if(findy == this.y - 1){
            move(up, map);
            break;
          }
        }
        if(findy == this.y){
          if(findx == this.x + 1){
            move(right, map);
            break;
          }
          if(findx == this.x - 1){
            move(left, map);
            break;
          }
        }
      }
    }
    //*/
    return false;
  }
  
  boolean move(int direction, Map map){
    switch(direction){
      case up:
        if(y > 0 && map.tiles[x][y - 1] != null && map.entities[x][y - 1] == null && map.tiles[x][y - 1].canmove){
          map.entities[x][y] = null;
          y --;
          map.entities[x][y] = this;
          frame = 0;
          this.direction = direction;
          return true;
        }
      break;
      case left:
        if(x > 0 && map.tiles[x - 1][y] != null && map.entities[x - 1][y] == null && map.tiles[x - 1][y].canmove){
          map.entities[x][y] = null;
          x --;
          map.entities[x][y] = this;
          frame = 0;
          this.direction = direction;
          return true;
        }
      break;
      case down:
        if(y < map.height - 1 && map.tiles[x][y + 1] != null && map.entities[x][y + 1] == null && map.tiles[x][y + 1].canmove){
          map.entities[x][y] = null;
          y ++;
          map.entities[x][y] = this;
          frame = 0;
          this.direction = direction;
          return true;
        }
      break;
      case right:
        if(x < map.width - 1 && map.tiles[x + 1][y] != null && map.entities[x + 1][y] == null && map.tiles[x + 1][y].canmove){
          map.entities[x][y] = null;
          x ++;
          map.entities[x][y] = this;
          frame = 0;
          this.direction = direction;
          return true;
        }
      break;
    }
    return false;
  }
  
  boolean attack(int direction, Map map){
    int damage = 1;
    switch(direction){
      case up:
        if(y > 0 && map.entities[x][y - 1] != null){
          map.entities[x][y - 1].currenthealth -= damage;
          map.entities[x][y - 1].calculatehealth();
          if(map.entities[x][y - 1].currenthealth <= 0){
            //map.entities[x][y - 1] = null;
          }
          return true;
        }
      break;
      case left:
        if(x > 0 && map.entities[x - 1][y] != null){
          map.entities[x - 1][y].currenthealth -= damage;
          map.entities[x - 1][y].calculatehealth();
          if(map.entities[x - 1][y].currenthealth <= 0){
            //map.entities[x - 1][y] = null;
          }
          return true;
        }
      break;
      case down:
        if(y < map.height - 1 && map.entities[x][y + 1] != null){
          map.entities[x][y + 1].currenthealth -= damage;
          map.entities[x][y + 1].calculatehealth();
          if(map.entities[x][y + 1].currenthealth <= 0){
            //map.entities[x][y + 1] = null;
          }
          return true;
        }
      break;
      case right:
        if(x < map.width - 1 && map.entities[x + 1][y] != null){
          map.entities[x + 1][y].currenthealth -= damage;
          map.entities[x + 1][y].calculatehealth();
          if(map.entities[x + 1][y].currenthealth <= 0){
            map.entities[x + 1][y] = null;
          }
          return true;
        }
      break;
    }
    return false;
  }
  
  void calculatehealth(){
    healthpercent = (float) currenthealth / health;
  }
  
  void render(){
    fill(0, 255, 0);
    rect(x * tilesize, y * tilesize, tilesize, tilesize);
  }
  
  abstract void renderStill(int a, int b);
  
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
      fill(0, 255, 255);
      rect((x + a - tempx) * tilesize + (frame * tempx), (y + b - tempy) * tilesize + (frame * tempy), tilesize, tilesize);
      
      fill(255, 255, 255);
      rect((x + a - tempx) * tilesize + (frame * tempx), (y + b - tempy) * tilesize + (frame * tempy), tilesize, 6);
      
      fill(0, 255, 0);
      rect((x + a - tempx) * tilesize + (frame * tempx), (y + b - tempy) * tilesize + (frame * tempy), (healthpercent) * tilesize, 6);
      
      frame += 4;
    }
    else{
      fill(0, 255, 255);
      rect((x + a) * tilesize, (y + b) * tilesize, tilesize, tilesize);
      
      fill(255, 255, 255);
      rect((x + a) * tilesize, (y + b) * tilesize, tilesize, 6);
      
      fill(0, 255, 0);
      rect((x + a) * tilesize, (y + b) * tilesize, (healthpercent) * tilesize, 6);
    }
  }
}

class Enemy extends Entity{
  
  int suggestion; //for swarm/team calcs
  
  void suggest(Enemy enemy, int suggestion){
    enemy.suggestion = suggestion;
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
  
  void run(Map map){
    if(x < map.player.x - 1){
      move(left, map);
      return;
    }
    if(x > map.player.x + 1){
      move(right, map);
      return;
    }
    if(y < map.player.y - 1){
      move(up, map);
      return;
    }
    if(y > map.player.y + 1){
      move(down, map);
      return;
    }
  }
  
  
  void renderStill(int a, int b){
    fill(0, 255, 255);
    rect((x + a) * tilesize, (y + b) * tilesize, tilesize, tilesize);
    
    fill(255, 255, 255);
    rect((x + a) * tilesize, (y + b) * tilesize, tilesize, 6);
    
    fill(0, 255, 0);
    rect((x + a) * tilesize, (y + b) * tilesize, (healthpercent) * tilesize, 6);
  }
  
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
    this.health = health;
    currenthealth = health;
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
    
    if(isplayernear && wolfcount >= 2){
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
    this.health = health;
    currenthealth = health;
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
