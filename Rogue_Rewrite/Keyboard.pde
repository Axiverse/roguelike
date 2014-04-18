class Keyboard{
  Keyboard(){
    int maxkeys = 128;
    keys = new boolean[maxkeys];
    cantoggle = new boolean[maxkeys];
    previous = new int[maxkeys];
    
    for(int i = 0; i < maxkeys; i++){
      previous[i] = 0;
    }
  }
  boolean keys[];
  boolean cantoggle[];
  int previous[];
  
  boolean timedpress(int keynum, int delay){
    if(keys[keynum]){//if the key is pressed
      if(delay <= millis() - previous[keynum]){
        previous[keynum] = millis();
        return true;
      }
    }
    return false;
  }
}

void keyPressed(){
  if(key == ESC){
    key = 0;
  }
  else if(key == CODED){
    if(key == RETURN){
      keyboard.keys[ENTER] = true;
    }
    else if (keyCode < keyboard.keys.length){
      keyboard.keys[keyCode] = true;
      
    }
  }
  else if (key < keyboard.keys.length){
    keyboard.keys[key] = true;
  }
}

void keyReleased(){
  if(key == ESC){
    print("YOU CANNOT ESCAPE \n");
  }
  else if(key == CODED){
    if(key == RETURN){
      keyboard.keys[ENTER] = false;
      keyboard.cantoggle[ENTER] = !keyboard.cantoggle[ENTER];
    }
    else{
      if (keyCode < keyboard.keys.length){
        keyboard.keys[keyCode] = false;
        keyboard.cantoggle[keyCode] = !keyboard.cantoggle[keyCode];
        //keyboard.previous[keyCode] = 0;
      }
    }
  }
  else{
    if(keyCode < keyboard.keys.length){
      keyboard.keys[key] = false;
      keyboard.cantoggle[key] = !keyboard.cantoggle[key]; 
    }
  }
}
