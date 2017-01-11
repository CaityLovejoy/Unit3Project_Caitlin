class Player extends Entity //<>// //<>// //<>//
{
  boolean _keyLeft;
  boolean _keyRight;
  boolean _keyJump;
  boolean _Attack;
  boolean _weaponChange;
  PVector _Speed;
  boolean _jumpAvailable;
  int _playerHealth;
  int startTime = 0;
int invulnTime =250;
AudioPlayer injury;


  Player(float x, float y, PImage img, boolean isActive, int playerHealth)
  {
    super(x, y, img, "Player", isActive);
    super.CreateBody(BodyType.DYNAMIC);
    super._body.setUserData(this);
    _Speed = new PVector(100, 50000);
    _jumpAvailable = true;
    _playerHealth = playerHealth;
  }

  void Update()
  {
    KeyInputs();
    Movement();
  }                 

  void KeyInputs()
  {
    //println(jumptype);
    if (movetype == 1)
    {
      _keyRight = true;
    } 
    else if (movetype == 2)
    {
      _keyLeft = true;
    } 
    if (movetype == 0)
    {
      _keyRight = false;
      _keyLeft = false;
    }

    if (jumptype == 1)
    {
      _keyJump = true;
    }
    if (jumptype == 0)
    {
      _keyJump = false;
    }
    if (attacktype == 0)
    {
      _Attack = false;
    }
    if (attacktype == 1)
    {
      _Attack = true;
    }

     /*
    else
     {
     _keyLeft  = false;
     _keyRight = false;
     _keyJump  = false;
     _attackRight = false;
     _attackLeft = false;
     _weaponChange = false;
     }*/
  }

  void Movement()
  {
    Body b = super._body;
    Vec2 currentVelocity = super._body.getLinearVelocity();

    if (_keyRight == true)
    {
      currentVelocity.x = 1 * _Speed.x;
      //println("Boop?");
      //println(currentVelocity.x);
    } else if (_keyLeft == true)
    {
      currentVelocity.x = -1 * _Speed.x;
    } else
    {
      currentVelocity.x = 0;
    }

    if (_keyJump && _jumpAvailable)
    {
      b.applyLinearImpulse( new Vec2(0, _Speed.y), super.GetWorldCenter(), true);
      //currentVelocity.y = 1 * _Speed.y;
      _jumpAvailable = false;
    }
    
    super._body.setLinearVelocity(currentVelocity);
  }

  void Collision(Object o)
  {
   // println(e.getType());
    if(o.getClass()==Platform.class)
    {
      _jumpAvailable = true;
   // println("?????");
    }
    else
    {
      _jumpAvailable = false;
     // println("hi?");
    }
    if(o.getClass()==Enemy.class)
    {
      if (millis()- startTime > invulnTime)
      {
        _playerHealth = _playerHealth - 10;
        startTime = millis();
      }
     
    }
    if(o.getClass()==Enemy.class && _Attack)
    {
      
    }
  }
  int getHealth()
  {
    return _playerHealth;
  }
}