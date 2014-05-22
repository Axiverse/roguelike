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
Dungeon test = new Dungeon();
//TalkNode asdf = new TalkNode();

void setup(){
  size(SCREENWIDTH + 160, SCREENHEIGHT);
  //size(displayWidth, displayHeight);
  frameRate(60);
  frame.setTitle("not rogue");
  randomSeed(10);
}

void draw(){
  background(0);
  test.render();
  test.process();
  //asdf.render();
}

boolean sketchFullScreen() {
  //return true;
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
