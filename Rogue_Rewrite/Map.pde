class Map{
  
  int width, height;
  Tile[][] tiles;
  Creature[][] creatures;
  Item[][] items;
  Player player;
  
  Structure currentRoom;
  
  ArrayList<Structure> structures;
  ArrayList<Entity> actors;
  boolean floorup;
  int offsetx, offsety;
  
  Map(int w, int h){
    floorup = false;
    this.width = w;
    this.height = h;
    //print("\n"+ w + " " + h);
    
    if(width < 20)
      width = 20;
    if(height < 20)
      height = 20;
    
    tiles = new Tile[width][height];
    creatures = new Creature[width][height];
    items = new Item[width][height];
    
    actors = new ArrayList();
    structures = new ArrayList();
    
    generate();
    
    
    player = new Player(int(width/2), int(height/2));
    //player = new Player(1, 1);
    addCreature(player);
    items[player.x][player.y + 1] = new Tool(player.x, player.y + 1);
    
    currentRoom = findStructure(player.x, player.y);
    
    offsetx = (SCREENWIDTH / TILESIZE) / 2 - player.x;
    offsety = (SCREENHEIGHT / TILESIZE) / 2 - player.y;
    
    spawnstuff();
    //addentity(new Ally(5, 5));
    
  }
  
  Map(int w, int h, Player player){
    this(w, h);
    generate();
    this.player = player;
    
    while(!(tiles[player.x][player.y] != null && tiles[player.x][player.y] instanceof Floor)){
      int tempx = (int)random(0, width - 1);
      int tempy = (int)random(0, height - 1);
      if(tiles[tempx][tempy] != null && tiles[tempx][tempy] instanceof Floor){
        player.x = tempx;
        player.y = tempy;
      }
    }
    
    addCreature(player);
    
    offsetx = (SCREENWIDTH / TILESIZE) / 2 - player.x;
    offsety = (SCREENHEIGHT / TILESIZE) / 2 - player.y;
    /*
    while(tiles[player.x][player.y] != null || !tiles[player.x][player.y].canmove){
      int i = (int)random(-5, 5);
      int j = (int)random(-5, 5);
      if(player.x + i > 0 && player.x + i < width && player.y + j > 0 && player.y + j < height){
        if(tiles[player.x + i][player.y + j] != null && tiles[player.x + i][player.y + j].canmove){
          player.x = i;
          player.y = j;
        }
      }
    }
    */
    spawnstuff();
    
  }
  
  void spawnstuff(){
    int enemycount = 0;
    int randx;
    int randy;
    for(int i = 0; i < 1000; i ++){
      randx = (int)random(0, width - 1);
      randy = (int)random(0, height - 1);
      if(tiles[randx][randy] != null && tiles[randx][randy].canmove && creatures[randx][randy] == null){
        if(random(1) > .3)
          //print("wolf here \n");
          addCreature(new Wolf(randx, randy));
        else
          addCreature(new Ghost(randx, randy));
        enemycount ++;
        
      }
      
      if(enemycount > 5)
        break;
    }
  }
  
  void clear(){
    for(int i = 0; i < width; i ++){
      for(int j = 0; j < height; j ++){
        tiles[i][j] = new Floor();
        if(i == 0 || i == width - 1 || j == 0 || j == height - 1){
          tiles[i][j] = new Wall();
        }
        creatures[i][j] = null;
      }
    }
  }
  
  void generate(){//oh boy, here we go
  
    Structure current;
    Structure temp;
  
    //Clearing the map
    for(int i = 0; i < width - 1; i ++){
      for(int j = 0; j < height - 1; j ++){
        tiles[i][j] = null;
        creatures[i][j] = null;
      }
    }
    structures.clear();
    
    //Make a room in the center
    current = makeroom((width / 2) - 4, (height / 2) - 4, 9, 9);
    
    //print("\n");
    int roomcount = 1;
    int roomwidth;
    int roomheight;
    int i, j;
    boolean hasstair = false;
    float stairchance = .05; //testing to make good maps
    
    for(int a = 0; a < 10000; a ++){
      
      i = (int)random(1, width - 1);
      j = (int)random(1, height - 1);
      
      if(tiles[i][j] instanceof Wall){
        roomwidth = (int)random(5, 10);
        roomheight = (int)random(5, 10);
        
        current = findStructure(i, j);
        
        //UP
        if(tiles[i][j + 1] instanceof Floor){
          temp = makeroom(i - roomwidth / 2, j - roomheight + 1, roomwidth, roomheight);
          if(temp != null){
            if(!hasstair && random(1) < stairchance){
              tiles[i][j - roomheight / 2] = new Stair();
              hasstair = true;
            }
            tiles[i][j] = (random(1) > .5) ? new Door() : new Floor();
            tiles[i][j - 1] = new Floor();
            roomcount ++;
            
            if(current != null){
              current.adjacent.add(temp);
              temp.adjacent.add(current);
            }
          }
          
        }
        
        //LEFT
        if(tiles[i + 1][j] instanceof Floor){
          temp = makeroom(i - roomwidth + 1, j - roomheight / 2, roomwidth, roomheight);
          if(temp != null){
            if(!hasstair && random(1) < stairchance){
              tiles[i - roomwidth / 2][j] = new Stair();
              hasstair = true;
            }
            tiles[i][j] = (random(1) > .5) ? new Door() : new Floor();
            tiles[i - 1][j] = new Floor();
            roomcount ++;
            
            if(current != null){
              current.adjacent.add(temp);
              temp.adjacent.add(current);
            }
          }
          
        }
        
        //DOWN
        if(tiles[i][j - 1] instanceof Floor){
          temp = makeroom(i - roomwidth / 2, j, roomwidth, roomheight);
          if(temp != null){
            if(!hasstair && random(1) < stairchance){
              tiles[i][j + roomheight / 2] = new Stair();
              hasstair = true;
            }
            tiles[i][j] = (random(1) > .5) ? new Door() : new Floor();
            tiles[i][j + 1] = new Floor();
            roomcount ++;
            
            if(current != null){
              current.adjacent.add(temp);
              temp.adjacent.add(current);
            }
          }
          
        }
        
        //RIGHT
        if(tiles[i - 1][j] instanceof Floor){
          temp = makeroom(i, j - roomheight / 2, roomwidth, roomheight);
          if(temp != null){
            if(!hasstair && random(1) < stairchance){
              tiles[i + roomheight / 2][j] = new Stair();
              hasstair = true;
            }
            tiles[i][j] = (random(1) > .5) ? new Door() : new Floor();
            tiles[i + 1][j] = new Floor();
            roomcount ++;
            
            if(current != null){
              current.adjacent.add(temp);
              temp.adjacent.add(current);
            }
          }
        }

      }
    }
    
    
    while(!hasstair){
      i = (int)random(1, width - 1);
      j = (int)random(1, height - 1);
      if(tiles[i][j] != null && tiles[i][j] instanceof Floor){
        if(!((tiles[i - 1][j] instanceof Wall && tiles[i + 1][j] instanceof Wall) || (tiles[i][j - 1] instanceof Wall && tiles[i][j + 1] instanceof Wall))){
          //^That, ladies and gentlemen, finds out if the stairs will be caught between two walls (Inside here = not between walls)
          //ie a doorway or something, but I'll probably add real doors to the rooms sometime.
          tiles[i][j] = new Stair();
          hasstair = true;
        }
      }
    }

  }
  
  Structure makeroom(int x, int y, int width, int height){
    if(x + width > this.width || y + height > this.height)
      return null;
    if(x < 0 || y < 0)
      return null;
      
    for(int i = 0; i < width; i ++){
      for(int j = 0; j < height; j ++){
        if(creatures[i + x][j + y] != null){
          return null;
        }
        if(tiles[i + x][j + y] != null && !(tiles[i + x][j + y] instanceof Wall)){
          return null;
        }
      }
    }
    Room room = new Room(x, y, width, height);
    addStructure(room);
    return room;
  }
  
  void addStructure(Structure structure){
    structure.generate(this);
    
    structures.add(structure);
  }
  
  Structure findStructure(int x, int y){
    for(int i = 0; i < structures.size(); i ++){
      Structure temp = structures.get(i);
      if(temp.inBounds(x, y)){
        return temp;
      }
    }
    
    return null;
  }
  
  Structure findStructure(Structure current, int x, int y){
    if(current == null)
      return findStructure(x, y);
    
    if(current.inBounds(x, y))
      return current;
      
    for(int i = 0; i < current.adjacent.size(); i ++){
      if(current.adjacent.get(i).inBounds(x, y))
        return current.adjacent.get(i);
    }
    
    return findStructure(x, y);
  }
  
  void addCreature(Creature creature){
    creatures[creature.x][creature.y] = creature;
    actors.add(creature);
  }
  
  void enemyturn(){
    for(int i = 0; i < actors.size(); i ++){
      if(!(tiles[actors.get(i).x][actors.get(i).y] != null && tiles[actors.get(i).x][actors.get(i).y].canmove)){
        actors.remove(i);
      }
      
      if(!(actors.get(i) instanceof Player))
        actors.get(i).turn(this);
    }
  }
  
  void process(){
    for(int i = 0; i < actors.size(); i ++){
      if(actors.get(i) instanceof Creature && ((Creature)actors.get(i)).health <= 0){
        creatures[actors.get(i).x][actors.get(i).y] = null;
        actors.remove(i);
      }
    }
    
    if(keyboard.keys['q']){
      print("x: " + offsetx + " y: " + offsety + "\n");
    }
  }
  
  void render(){
    
    if(!((width <= SCREENWIDTH / TILESIZE) && (height <= SCREENHEIGHT / TILESIZE))){
      offsetx = (SCREENWIDTH / TILESIZE) / 2 - player.x;
      offsety = (SCREENHEIGHT / TILESIZE) / 2 - player.y;
    }
    
    if(offsetx > 0)
      offsetx = 0;
    if(offsety > 0)
      offsety = 0;
    if(offsetx + width < SCREENWIDTH / TILESIZE)
      offsetx = SCREENWIDTH / TILESIZE - width;
    if(offsety + height < SCREENHEIGHT / TILESIZE)
      offsety = SCREENHEIGHT / TILESIZE - height;
    if(width < SCREENWIDTH / TILESIZE)
      offsetx = ((SCREENWIDTH / TILESIZE) - width) / 2;
    if(height < SCREENHEIGHT / TILESIZE)
      offsety = ((SCREENHEIGHT / TILESIZE) - height) / 2;
      
      /*
    if(offsetx + width == SCREENWIDTH / TILESIZE){
      print("!");
    }
      //render(offsetx, offsety);
    */
    if(player.x == (SCREENWIDTH / TILESIZE) / 2 && player.direction == MOVE_LEFT){
      renderStill(offsetx, offsety);
    }
    else if(player.y == (SCREENHEIGHT / TILESIZE) / 2 && player.direction == MOVE_UP){
      renderStill(offsetx, offsety);
    }
    else if(width - player.x == (SCREENWIDTH / TILESIZE) / 2 && player.direction == MOVE_RIGHT){
      renderStill(offsetx, offsety);
    }
    else if(height - player.y == (SCREENHEIGHT / TILESIZE) / 2 && player.direction == MOVE_DOWN){
      renderStill(offsetx, offsety);
    }
    
    else if(width + offsetx == (SCREENWIDTH / TILESIZE) && (player.direction == MOVE_RIGHT || player.direction == MOVE_LEFT)){
      render(offsetx, offsety);
    }
    else if(height + offsety == (SCREENWIDTH / TILESIZE) && (player.direction == MOVE_DOWN || player.direction == MOVE_UP)){
      render(offsetx, offsety);
    }
    
    else if(offsetx == 0 && (player.direction == MOVE_LEFT || player.direction == MOVE_RIGHT)){
      render(offsetx, offsety);
    }
    
    else if(offsety == 0 && (player.direction == MOVE_UP || player.direction == MOVE_DOWN)){
      render(offsetx, offsety);
    }
    
    else{
      renderStill(offsetx, offsety);
    }
  }
  
  void renderStill(int x, int y){
    if(player.frame > 24){
      render(x, y);
      return;
    }
    
    int tempx, tempy;
    if(player.direction % 2 == 1){//Vertical directions
      tempx = 0;
      if(player.direction == 1)
        tempy = -1;
      else
        tempy = 1;
    }
    else{
      tempy = 0;
      if(player.direction == 2)
        tempx = -1;
      else
        tempx = 1;
    }
    
    for(int i = 0; i < structures.size(); i ++){
      //structures.get(i).renderFog(this, (x + tempx) * TILESIZE - (player.frame * tempx), (y + tempy) * TILESIZE - (player.frame * tempy));
      //println((x + tempx) * TILESIZE + (player.frame * tempx));
    }
    
    if(currentRoom != null){
      currentRoom.render(this, (x + tempx) * TILESIZE - (player.frame * tempx), (y + tempy) * TILESIZE - (player.frame * tempy));
      currentRoom.renderEntity(this, (x + tempx) * TILESIZE - (player.frame * tempx), (y + tempy) * TILESIZE - (player.frame * tempy));
      
      for(int a = 0; a < currentRoom.adjacent.size(); a ++){
        currentRoom.adjacent.get(a).render(this, (x + tempx) * TILESIZE - (player.frame * tempx), (y + tempy) * TILESIZE - (player.frame * tempy));
      }
    }
    
    player.renderStill(x, y);
    
    player.frame += 4;
  }
  
  void render(int x, int y){
    
    for(int i = 0; i < structures.size(); i ++){
      //structures.get(i).renderTileFog(this, x, y);
    }
    
    if(currentRoom != null){
      currentRoom.renderTile(this, x, y);
      for(int a = 0; a < currentRoom.adjacent.size(); a ++){
        currentRoom.adjacent.get(a).renderTile(this, x, y);
      }
    }
    
  }
  
}

abstract class Generator{
  int width;
  int height;
  String style;
  
  //make a weighted generator here
}
