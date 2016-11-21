class Entity
{
  float _x;
  float _y;
  PImage _img;
  String _type;
  boolean _isActive;
  Body _body;

  Entity()
  {
    _x = 0;
    _y = 0;
    _img  = null;
    _type = "Unknown Entity"; 
    _isActive = false;
  }

  Entity(float x, float y, PImage img, String type, boolean isActive)
  {
    _x = x;
    _y = y;
    _img  = img;
    _type = type;
    _isActive = isActive;
  }

  private void CreateBody(BodyType bType)
  {
    int imgH = _img.height;
    int imgW = _img.width;
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(imgW/2);
    float box2dH = box2d.scalarPixelsToWorld(imgH/2);
    sd.setAsBox(box2dW, box2dH);
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = 2;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    BodyDef bd = new BodyDef();
    bd.type = bType;
    bd.position.set(box2d.coordPixelsToWorld(_x, _y));
    _body = box2d.createBody(bd);
    _body.createFixture(fd);
  }
  void Draw()
  {
    PVector pos = box2d.getBodyPixelCoordPVector(_body);
    float a = _body.getAngle();
    imageMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    //rotate(-a);
    image(_img, 0, 0);
    popMatrix();
  }
  
  void CleanUpDeadObject()
  {
    box2d.destroyBody(_body);
  }
  
  String getType()
  {
    return _type;
  }
  Vec2    GetWorldCenter() { return _body.getWorldCenter(); } 
}