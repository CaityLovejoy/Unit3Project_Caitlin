import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

Box2DProcessing box2d;
PImage PlatformImg;
PImage PlayerIdleImg;
Platform[] pl1;
Player P1;

void setup()
{
  fullScreen(P3D);
  colorMode(HSB);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -500);
  box2d.setContinuousPhysics(true);
  box2d.listenForCollisions(); 
  PlatformImg = loadImage("Platform.png");
  PlayerIdleImg = loadImage("PIdle.png");
  int w = PlatformImg.width;
  int h = PlatformImg.height;
  pl1 = new Platform[500];
  for (int x=0; x < 16; x++)
  {
    pl1[x] = new Platform(w*x, height-20, PlatformImg, true);
  }
  PlayerIdleImg.resize(w, h);
  P1 = new Player(20, height-h*4.1, PlayerIdleImg, true);
}

void draw()
{
  background(150, 128, 255);
  for (int x=0; x < 16; x++)
  {
    pl1[x].Draw();
  }
  P1.Draw();
  P1.Update();
  box2d.step();
}

void beginContact(Contact cp)
{
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  Entity e1 = (Entity) o1;
  Entity e2 = (Entity) o2;
  //println(o1);
  //println(o2);
  if(e1.getType() == "Player")
  { 
    Player p = (Player)o1;
    Platform pl = (Platform)o2;
    p.Collision(pl);
  }
  
}