class Platform extends Entity
{
  
  Platform(float x, float y, PImage img, boolean isActive)
  {
    super(x, y, img, "Platform", isActive);
    super.CreateBody(BodyType.STATIC);
    super._body.setUserData(this);
  }
}