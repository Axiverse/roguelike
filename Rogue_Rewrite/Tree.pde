class Tree{
  Node start;
  Node current;
  
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
  
  void activate(Tree tree){
    tree.nextNode(0);
  }
  
  void render(){
    
  }
}

class TalkNode extends Node(){
  
}

class OptionNode extends Node(){
  
}
