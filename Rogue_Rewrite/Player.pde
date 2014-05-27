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
  
  
  
  boolean turn(Map map){
    return false;
  }
  
  void renderImage(int x, int y){
    fill(255, 0, 0);
    rect(x, y, TILESIZE, TILESIZE);
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
      renderImage((x - tempx) * TILESIZE + (frame * tempx) + a, (y - tempy) * TILESIZE + (frame * tempy) + b);
      
      fill(255, 255, 255);
      rect((x - tempx) * TILESIZE + (frame * tempx) + a, (y - tempy) * TILESIZE + (frame * tempy) + b, TILESIZE, 6);
      
      fill(0, 255, 0);
      rect((x - tempx) * TILESIZE + (frame * tempx) + a, (y - tempy) * TILESIZE + (frame * tempy) + b, (healthpercent) * TILESIZE, 6);
      
      frame += 4;
    }
    else{
      renderImage(x * TILESIZE + a, y * TILESIZE + b);
      
      fill(255, 255, 255);
      rect(x * TILESIZE + a, y * TILESIZE + b, TILESIZE, 6);
      
      fill(0, 255, 0);
      rect(x * TILESIZE + a, y * TILESIZE + b, (healthpercent) * TILESIZE, 6);
    }

  }
  
}
