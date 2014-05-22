class Ally extends Creature{
  
  Tree talkTree;
  
  Ally(int x, int y){
    this.x = x;
    this.y = y;
    frame = 24;
    
    light = 0;
    talkTree = new Tree();
  }
  
  boolean turn(Map map){
    return false;
  }
  
  void talk(){
    //output current node
  }
  
  void renderImage(int x, int y){
    fill(#663399);
    rect(x, y, TILESIZE, TILESIZE);
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
      //Square
      renderImage((x - tempx) * TILESIZE + (frame * tempx) + a, (y - tempy) * TILESIZE + (frame * tempy) + b);
      
      frame += 4;
    }
    else{
      fill(0, 255, 255);
      renderImage(x * TILESIZE + a, y * TILESIZE + b);
    }
  }
}
