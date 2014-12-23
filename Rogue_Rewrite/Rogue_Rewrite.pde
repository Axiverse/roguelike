final int SCREENWIDTH = 480;
final int SCREENHEIGHT = 480;

final int TILESIZE = 24;

final int MOVE_UP = 1;
final int MOVE_LEFT = 2;
final int MOVE_DOWN = 3;
final int MOVE_RIGHT = 4;

final int ATK_UP = 5;
final int ATK_LEFT = 6;
final int ATK_DOWN = 7;
final int ATK_RIGHT = 8;

final int MAXLIGHT = 8;

Keyboard keyboard = new Keyboard();
Scene scene = new DungeonScene();
//TalkNode asdf = new TalkNode();

void setup(){
  size(SCREENWIDTH + 160, SCREENHEIGHT);
  ellipseMode(CORNER);
  //size(displayWidth, displayHeight);
  frameRate(60);
  frame.setTitle("All Hail Dave Soon");
  
  randomSeed(10);
  loadTiles();
}

void draw(){
  //frame.setTitle(Float.toString(frameRate));
  background(0);
  scene.update();
  scene.render();
  //asdf.render();
}

boolean sketchFullScreen() {
  //return true;
  return false;
}

boolean isAdjacent(int x1, int y1, int x2, int y2){
  if(x1 == x2){
    if(abs(y1 - y2) == 1)
      return false;
  }
  if(y1 == y2){
    if(abs(x1 - x2) == 1)
      return true;
  }
  return false;
}

/*
-ITEMS!!

-Stairs don't do anything <- fixed

-Gui to the right
  Floor, icon
  -Text/info output
  -Mini map (part of Dungeon)

-Menus for easy programming magic

-Sprites
  -Animated sprites
    -set sprite sheet (3 frames?)
    
-Particle effects
    
-AI
  New unique AI
    -teleport ghosts
    
-Map loading

*/

/*
Crazy ideas
-Right/Left handedness: different combat/sheild combo

-Silly items
  -Golden cheese (nyoron)
  -Plot armor
*/
