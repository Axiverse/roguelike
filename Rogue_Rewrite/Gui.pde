class Element{
  int x, y;
  int width, height;
  
  Element(){
    x = 0;
    y = 0;
    width = 50;
    height = 50;
  }
  
  void render(){
    fill(255, 0, 255);
    rect(x, y, width, height);
  }
}

class Menu extends Element{
  ArrayList<Element> elements;
  Element selected;
  
  Menu(int x, int y, int width, Element ... buttons){
    this(x, y, width, 0, buttons);
  }
  
  Menu(int x, int y, int width, int height, Element ... buttons){
    int tempy = 0;
    
    this.x = x;
    this.y = y;
    this.width = width;
    elements = new ArrayList();
    for(int i = 0; i < buttons.length; i ++){
      buttons[i].y = tempy;
      buttons[i].x = x;
      tempy += buttons[i].height;
      elements.add(buttons[i]);
    }
    this.height = tempy;
  }
  
  void render(){
    
  }
}

class PlayerStats extends Element{
  
  PlayerStats(int x, int y){
    this.x = x;
    this.y = y;
    width = 160;
    height = 480;
  }
  
  void render(Player player, Dungeon dungeon){
    //background
    fill(0, 224);
    rect(x, y, width, height);
    
    //Dungeon floor No
    fill(255, 255, 0);
    rect(x + 108, y + 8, 40, 40);
    fill(0);
    textSize(32);
    text(dungeon.floor, x + 118, y + 40);
    
    //Health bar
    fill(255, 0, 0);
    rect(x + 8, y + 60, (width - 18) * player.healthpercent, 10);
    textSize(10);
    fill(0);
    text(player.health + " / " + player.maxHealth, x + 12, y + 70);
    
    //Hotbar (Items)
    for(int i = 0; i < player.items.length; i ++){
      if(player.items[i] != null)
        player.items[i].render(24 + x + 34 * i, y + 74);
    }
  }
}
