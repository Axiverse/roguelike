class Scene{
  ArrayList<Element> elements;
  
  Scene(){
    elements = new ArrayList();
  }

  void render(){
    for(int i = elements.size(); i > 0; i ++){
      elements.get(i).render();
    }
  }
  
}
