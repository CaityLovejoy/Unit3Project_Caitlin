class Player extends Entity
{
  boolean _keyLeft;
  boolean _keyRight;
  boolean _keyJump;
  boolean _attackRight;
  boolean _attackLeft;
  boolean _weaponChange;
  PVector _Speed;
  boolean _jumpAvailable;
  boolean jump; 
  float move;

  Player(float x, float y, PImage img, boolean isActive)
  {
    super(x, y, img, "Player", isActive);
    super.CreateBody(BodyType.DYNAMIC);
    super._body.setUserData(this);
    _Speed = new PVector(100, 50000);
    _jumpAvailable = true;
  }
 
 void Update()
  {
    KeyInputs();
    Movement();
  }                 

  void KeyInputs()
  {
    jump = gpad.getButton("A").pressed();
    move = gpad.getSlider("X AXIS").getValue();
    println(move);
      if (move > 0)
      {
        _keyRight = true; //<>//
      }
      if (move < 0)
      {
        _keyLeft = true; //<>//
      }
      if (jump)
      {
        _keyJump = true; //<>//
      }
      
      if (key == ';')
      {
        println("asdferg");
        _attackRight = true;
      }
      if (key == 'k')
      {
        _attackLeft = true;
      }
      if (key == 'q')
      {
        _weaponChange = true;
      }
    
    else
    {
      _keyLeft  = false;
      _keyRight = false;
      _keyJump  = false;
      _attackRight = false;
      _attackLeft = false;
      _weaponChange = false;
    }
  }
  
  void Movement()
  {
    Body b = super._body;
    Vec2 currentVelocity = super._body.getLinearVelocity();
    if (_keyRight)
    {
       currentVelocity.x = 1 * _Speed.x;
       println("Boop?");
       println(currentVelocity.x);
    }
    else if (_keyLeft)
    {
      currentVelocity.x = -1 * _Speed.x;
    }
    else
    {
      currentVelocity.x = 0;
    }
    
    if (_keyJump && _jumpAvailable)
    {
      b.applyLinearImpulse( new Vec2(0, _Speed.y), super.GetWorldCenter(),true);
      //currentVelocity.y = 1 * _Speed.y;
      _jumpAvailable = false;
    }
    println(currentVelocity);
    super._body.setLinearVelocity(currentVelocity);
  }
  
  void Collision(Entity e)
  {
    //println(e.getType());
    if(e.getType().equals("Platform"))
    {
     _jumpAvailable = true;
     //println("?????");
    }
  }
  
}