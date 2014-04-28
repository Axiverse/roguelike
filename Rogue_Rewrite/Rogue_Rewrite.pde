final int SCREENWIDTH = 480;
final int SCREENHEIGHT = 480;

final int TILESIZE = 24;

final int up = 1;
final int left = 2;
final int down = 3;
final int right = 4;

final int MAXLIGHT = 8;

Keyboard keyboard = new Keyboard();
Dungeon test = new Dungeon();

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
