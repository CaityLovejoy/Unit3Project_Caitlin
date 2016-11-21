class Enemy extends Entity
{
  boolean _Left;
  boolean _Right;
  boolean _Jump;
  boolean _Attack;
  PVector _Speed;
  boolean _jumpAvailable;

  Enemy(float x, float y, PImage img, boolean isActive)
  {
    super(x, y, img, "Player", isActive);
    super.CreateBody(BodyType.DYNAMIC);
    super._body.setUserData(this);
    _Speed = new PVector(100, 50000);
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
    
    if (_Jump && _jumpAvailable)
    {
      b.applyLinearImpulse( new Vec2(0, _Speed.y), super.GetWorldCenter(),true);
      //currentVelocity.y = 1 * _Speed.y;
      _jumpAvailable = false;
    }
    println(currentVelocity);
    super._body.setLinearVelocity(currentVelocity);
  }
  
  void Draw()
  {
    super.Draw();
  }
  
  void Collision(Entity e)
  {
    //println(e.getType());
    if(e.getType().equals("Platform"))
    {
     _jumpAvailable = true;
    // println("?????");
    }
  }
  
}