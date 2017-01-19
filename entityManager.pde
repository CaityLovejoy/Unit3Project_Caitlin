class EntityManager
{
  ArrayList<Entity> entityList;
  
  EntityManager()
  {
    entityList = new ArrayList<Entity>();
    
    //entityList.add(thingToAdd)
    //entityList.get(numberToGet)
    //entityList.remove(thingToRemove)
    //entityList.size() size of list
  }
  
  void CreateEntity(Entity e)
  {
    entityList.add(e);
  }
}