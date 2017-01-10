class Enemy extends Entity
{
  boolean _Left;
  boolean _Right;
  boolean _Jump;
  boolean _Attack;
  PVector _Speed;
  boolean _jumpAvailable;
  float x;
  int _enemyHealth = 30;


  Enemy(float x, float y, PImage img, boolean isActive)
  {
    super(x, y, img, "Player", isActive);
    super.CreateBody(BodyType.KINEMATIC);
    super._body.setUserData(this);
    _Speed = new PVector(10, 0);
    _jumpAvailable = true;
  }
 
 void Update()
  {
    Movement();
  }
  
  void Movement()
  {
    Body b = super._body;
    Vec2 currentVelocity = super._body.getLinearVelocity();
    if (_Right)
    {
       currentVelocity.x = 1 * _Speed.x;
       //println("Boop?");
    }
    else if (_Left)
    {
      currentVelocity.x = -1 * _Speed.x;
    }
    else
    {
      currentVelocity.x = 0;
    }
   if(x > 0)
      {
        println("HEY!!!!");
        currentVelocity.x = -1 * _Speed.x;
     
      }
   if(x < width)
      {
        //println("Boop?");
       currentVelocity.x = -1 * _Speed.x;
      }
     
    
   // println(currentVelocity);
    super._body.setLinearVelocity(currentVelocity);
  }
  
  void Draw()
  {
    super.Draw();
  }
 
  
}