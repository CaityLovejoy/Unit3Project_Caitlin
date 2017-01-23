class EntityManager
{
  ArrayList<Entity> entityList;
 int playerID;
 boolean playerAdded = false;
 
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
    if(e._type.equals("Player"))
    {
      entityList.add(e);
      playerID = entityList.size() -1 ;
      println("A player has been added.");
      playerAdded = true;
    }
    entityList.add(e);
  }

  void UpdateEntities()
  {
    for (int i=0; i< entityList.size(); i++)
    {
      Entity e = entityList.get(i);
      switch(e._type)
      {
      case "Player":
        Player p = (Player)e;
        p.Draw();
        p.Update();
        break;
      case "Platform":
        Platform pl = (Platform)e;
        pl.Draw();
        break;
      case "Enemy":
        Enemy en = (Enemy)e;
        en.Draw();
        en.Update();
        break;
      }
    }
  }
  Player GetPlayer()
  {
    if(playerAdded)
    {
      Player p = (Player)entityList.get(playerID);
      return p;
    }
    else
    {
      println("No player has been added.");
      return null;
    }
  }
}