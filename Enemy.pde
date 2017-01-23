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
String _type;
PImage _img;
AudioPlayer enemyDamage;

  Enemy(float x, float y, PImage img, boolean isActive)
  {
    super(x, y, img, "Enemy", isActive);
    super.CreateBody(BodyType.DYNAMIC);
    super._body.setUserData(this);
    _Speed = new PVector(10, 0);
    _jumpAvailable = true;
    _img = img;
    enemyDamage = minim.loadFile("enemyDamage.wav");
  }
 

  
  void Movement()
  {
    Body b = super._body;
    Vec2 currentVelocity = super._body.getLinearVelocity();
       currentVelocity.x = 1 * _Speed.x;
       //println("Boop?");
   print("X: ");
   println(b.getPosition().x);
   if(b.getPosition().x < -90)
      {
       // println("HEY!!!!");
        currentVelocity.x = -_Speed.x;
     _Speed.x = -_Speed.x;
      }
   if(b.getPosition().x > 90)
      {
       // println("Boop?");
       currentVelocity.x = -_Speed.x;
        _Speed.x = -_Speed.x;
      }
    
    
   // println(currentVelocity);
    super._body.setLinearVelocity(currentVelocity);
  }
  
  void Draw()
  {
    super.Draw();
  }

  
 int getEnemyHealth()
 {
   return _enemyHealth;
 }
 
 String getType()
  {
    return _type;
  }
  
  void Damage()
  {
     _enemyHealth = _enemyHealth - 10;
     enemyDamage.play();
     enemyDamage.rewind();
     
  }
 
}