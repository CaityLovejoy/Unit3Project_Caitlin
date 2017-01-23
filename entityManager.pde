class EntityManager
{
  ArrayList<Entity> entityList;
  int playerID;
  boolean playerAdded = false;
  int deadEnemies;
  AudioPlayer gameOver;

  EntityManager()
  {
    entityList = new ArrayList<Entity>();
    gameOver = minim.loadFile("gameOver.wav");
    //entityList.add(thingToAdd)
    //entityList.get(numberToGet)
    //entityList.remove(thingToRemove)
    //entityList.size() size of list
  }

  void CreateEntity(Entity e)
  {
    if (e._type.equals("Player"))
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
      case "Platform":
        Platform pl = (Platform)e;
        pl.Draw();
        break;
      case "Enemy":
        Enemy en = (Enemy)e;
        en.Draw();
        en.Movement();
        if (en._enemyHealth <= 0)
        {
        entityList.remove(e);
        deadEnemies = deadEnemies + 1;
        }
        break;
      case "Player":
        Player P1 = (Player)e;
        P1.Draw();
        P1.Update();
        if (P1._playerHealth <= 0)
        {
          endGame();
        }
        break;
      }
    }
  }
  Player GetPlayer()
  {
    if (playerAdded)
    {
      Player p = (Player)entityList.get(playerID);
      return p;
    } else
    {
      println("No player has been added.");
      return null;
    }
  }
  
  void endGame()
  {
    background(0, 0, 0);
    gameOver.play();
    text("GAMEOVER", 500, height - height/1.1 + TEXT_OFFSET);
  }
}