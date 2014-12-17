abstract class Scene{
  ArrayList<Element> elements;
  Controller controller;
  
  Scene(){
    elements = new ArrayList();
  }
  
  void render(){
    renderElements();
  }

  void renderElements(){
    for(int i = elements.size() - 1; i >= 0; i --){
      elements.get(i).render();
    }
  }
  
  void update(){
    return;
  }
  
}

class DungeonScene extends Scene{
  Map map;
  int floor;
  Notifications notices;
  //PlayerStats stats;
  
  DungeonScene(){
    map = new Map(40, 40);
    elements.add(new MiniMap(0, 0));
    controller = new Controller(map.player);
    floor = 0;
    //stats = new PlayerStats(480, 0);
  }
  
  void update(){
    boolean enemyturn = false;
    if(controller.move(map)){
      enemyturn = true;
      map.tiles[map.player.x][map.player.y].onstep(map);
      
      if(map.floorup){
        floor ++;
        Player temp = map.player;
        map = new Map(map.width, map.height, temp);
      }
      
    }
    if(enemyturn){
      map.enemyturn();
      if(map.player.health <= 0){
        floor = 0;
        map = new Map(10, 10);
      }
      enemyturn = false;
    }
    map.process();
    
    map.currentRoom = map.findStructure(map.currentRoom, map.player.x, map.player.y);
  }
  
  void render(){
    map.render();
    renderElements();
    //stats.render(map.player, this);
  }
}

class DialogueScene extends Scene{
  Scene background;
  
  DialogueScene(Scene background){
    
  }
}
