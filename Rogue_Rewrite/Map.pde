class Map{
  
  int width, height;
  Tile[][] tiles;
  Entity[][] entities;
  Player player;
  ArrayList<Entity> actors;
  boolean floorup;
  
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
    entities = new Entity[width][height];
    actors = new ArrayList();
    
    generate();
    
    player = new Player(int(width/2), int(height/2));
    addentity(player);
    
    spawnstuff();
    
    /*
    for(int i = 0; i < width; i ++){
      for(int j = 0; j < height; j ++){
        if(i == 0 || i == width - 1 || j == 0 || j == height - 1)
          tiles[i][j] = new Wall();
        else
          tiles[i][j] = new Tile();
      }
    }
    */
  }
  
  Map(int w, int h, Player player){
    this(w, h);
    generate();
    this.player = player;
    addentity(player);
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
      if(tiles[randx][randy] != null && tiles[randx][randy].canmove && entities[randx][randy] == null){
        if(random(1) > .3)
          //print("wolf here \n");
          addentity(new Wolf(randx, randy));
        else
          addentity(new Ghost(randx, randy));
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
        entities[i][j] = null;
      }
    }
  }
  
  void generate(){//oh boy, here we go
  
  //Clearing the map
    for(int i = 0; i < width - 1; i ++){
      for(int j = 0; j < height - 1; j ++){
        tiles[i][j] = null;
        entities[i][j] = null;
      }
    }
    //Make a room in the center
    makeroom((width / 2) - 4, (height / 2) - 4, 9, 9);
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
        roomwidth = (int)random(4, 10);
        roomheight = (int)random(4, 10);
        
        //UP
        if(tiles[i][j + 1] instanceof Floor){
          
          if(makeroom(i - roomwidth / 2, j - roomheight + 1, roomwidth, roomheight)){
            if(!hasstair && random(1) < stairchance){
              tiles[i][j - roomheight / 2] = new Stair();
              hasstair = true;
            }
            tiles[i][j] = new Floor();
            tiles[i][j - 1] = new Floor();
            roomcount ++;
          }
          
        }
        
        //LEFT
        if(tiles[i + 1][j] instanceof Floor){
          
          if(makeroom(i - roomwidth + 1, j - roomheight / 2, roomwidth, roomheight)){
            if(!hasstair && random(1) < stairchance){
              tiles[i - roomwidth / 2][j] = new Stair();
              hasstair = true;
            }
            tiles[i][j] = new Floor();
            tiles[i - 1][j] = new Floor();
            roomcount ++;
          }
          
        }
        
        //DOWN
        if(tiles[i][j - 1] instanceof Floor){
          
          if(makeroom(i - roomwidth / 2, j, roomwidth, roomheight)){
            if(!hasstair && random(1) < stairchance){
              tiles[i][j + roomheight / 2] = new Stair();
              hasstair = true;
            }
            tiles[i][j] = new Floor();
            tiles[i][j + 1] = new Floor();
            roomcount ++;
          }
          
        }
        
        //RIGHT
        if(tiles[i - 1][j] instanceof Floor){

          if(makeroom(i, j - roomheight / 2, roomwidth, roomheight)){
            if(!hasstair && random(1) < stairchance){
              tiles[i + roomheight / 2][j] = new Stair();
              hasstair = true;
            }
            tiles[i][j] = new Floor();
            tiles[i + 1][j] = new Floor();
            roomcount ++;
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
  
  boolean makeroom(int x, int y, int width, int height){
    if(x + width > this.width || y + height > this.height)
      return false;
    if(x < 0 || y < 0)
      return false;
    for(int i = 0; i < width; i ++){
      for(int j = 0; j < height; j ++){
        if(entities[i + x][j + y] != null){
          return false;
        }
        if(tiles[i + x][j + y] != null && !(tiles[i + x][j + y] instanceof Wall)){
          return false;
        }
      }
    }
    
    for(int i = 0; i < width; i ++){
      for(int j = 0; j < height; j ++){
        if(i == 0 || j == 0 || i == width - 1 || j == height - 1){
          tiles[i + x][j + y] = new Wall();
        }
        else{
          tiles[i + x][j + y] = new Floor();
        }
      }
    }
    return true;
  }
  
  void addentity(Entity entity){
    entities[entity.x][entity.y] = entity;
    actors.add(entity);
  }
  
  void enemyturn(){
    for(int i = 0; i < actors.size(); i ++){
      if(!(actors.get(i) instanceof Player))
        actors.get(i).turn(this);
    }
  }
  
  void process(){
    for(int i = 0; i < actors.size(); i ++){
      if(actors.get(i).currenthealth <= 0){
        entities[actors.get(i).x][actors.get(i).y] = null;
        actors.remove(i);
      }
    }
  }
  
  void render(){
    int offsetx = (screenwidth / tilesize) / 2 - player.x;
    int offsety = (screenheight / tilesize) / 2 - player.y;
    if(offsetx > 0)
      offsetx = 0;
    if(offsety > 0)
      offsety = 0;
    if(offsetx + width < screenwidth / tilesize)
      offsetx = screenwidth / tilesize - width;
    if(offsety + height < screenheight / tilesize)
      offsety = screenheight / tilesize - height;
    if(width < screenwidth / tilesize)
      offsetx = ((screenwidth / tilesize) - width) / 2;
    if(height < screenheight / tilesize)
      offsety = ((screenheight / tilesize) - height) / 2;
    render(offsetx, offsety);
  }
  
  void render(int x, int y){
    for(int i = 0; i < width; i ++){
      for(int j = 0; j < height; j ++){
        if(tiles[i][j] != null)
          tiles[i][j].render(i + x, j + y);
      }
    }
    for(int i = 0; i < width; i ++){
      for(int j = 0; j < height; j ++){
        if(entities[i][j] != null)
          entities[i][j].render(x, y);
      }
    }
  }
  
}

class Dungeon{
  Map map;
  int floor;
  PlayerStats stats;
  //Generator
  Dungeon(){
    map = new Map(10, 10);
    floor = 0;
    stats = new PlayerStats(486, 0);
  }
  
  void process(){
    boolean enemyturn = false;
    if(map.player.input(map)){
      enemyturn = true;
      map.tiles[map.player.x][map.player.y].onstep(map);
      
      if(map.floorup){
        floor ++;
        Player temp = map.player;
        map = new Map(10, 10, temp);
      }
      
    }
    if(enemyturn){
      map.enemyturn();
      if(map.player.currenthealth <= 0){
        floor = 0;
        map = new Map(10, 10);
      }
      enemyturn = false;
    }
    map.process();
  }
  
  void render(){
    map.render();
    stats.render(map.player, this);
  }
}


/*












*/

class Tile{
  //tile type
  //trap? activated?
  boolean canmove;
  
  Tile(){
    canmove = true;
  }
  
  void onstep(Map map){
    return;
  }
  
  void render(int x, int y){
    fill(192);
    rect(x * tilesize, y * tilesize, tilesize, tilesize);
  }
}

class Floor extends Tile{
  //Hey, guess what? I don't do anything!
}

class Wall extends Tile{
  Wall(){
    canmove = false;
  }
  
  void render(int x, int y){
    fill(0, 0, 128);
    rect(x * tilesize, y * tilesize, tilesize, tilesize);
  }
}

class Stair extends Tile{
  void onstep(Map map){
    map.floorup = true;
  }
  
  void render(int x, int y){
    fill(255, 255, 0);
    rect(x * tilesize, y * tilesize, tilesize, tilesize);
  }
}
