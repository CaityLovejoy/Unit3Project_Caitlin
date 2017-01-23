class Platform extends Entity
{
  String _type;
  Platform(float x, float y, PImage img, boolean isActive)
  {
    super(x, y, img, "Platform", isActive);
    super.CreateBody(BodyType.STATIC);
    super._body.setUserData(this);
  }
  String getType()
  {
    return _type;
  }
}