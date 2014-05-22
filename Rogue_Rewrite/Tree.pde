class Tree{
  Node start;
  Node current;
  
  Tree(){
    start = new Node();
    current = start;
  }
  
  Tree(Node start){
    this.start = start;
    current = start;
  }
  
  void jumpTo(Node node){
    //Wait, how do I tell that the node is in the tree?
  }
  
  boolean nextNode(int index){
    if(index > current.daughters.size() - 1 || index < 0){
      return false;
    }
    current = current.daughters.get(index);
    return true;
  }
  
  Node getCurrent(){
    return current;
  }
  
  Node getDaughter(int i){
    return current.daughters.get(i);
  }
}

class Node{
  ArrayList<Node> daughters;
  String title;
  
  Node(){
    title = "Test Title";
  }
  
  
  void activate(Tree tree){
    tree.nextNode(0);
  }
}

class TalkNode extends Node{
  String text;
  
  TalkNode(){
    super();
    //31 characters per line
    text = "01234567890123456789012345678901234567890";
  }
  
  
  void render(){
    fill(0, 0, 255);
    rect(10, SCREENHEIGHT - 115, SCREENWIDTH - 20, 110, 8);
    textSize(32);
    fill(255);
    text(title, 30, SCREENHEIGHT - 85);
    textSize(16);
    text(text, 30, SCREENHEIGHT - 65);
    
  }
}

class OptionNode extends Node{
  
}
