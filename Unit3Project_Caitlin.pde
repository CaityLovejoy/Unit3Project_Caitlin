import at.mukprojects.console.*;

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;
import net.java.games.input.*;

float TEXT_OFFSET = 50;
Box2DProcessing box2d;
PImage PlatformImg;
PImage PlayerIdleImg;
PImage EnemyImg;
Platform[] pl1;
Enemy[] en1;
Player P1;
boolean jump; 
float walk;
boolean attack;
int movetype = 0;
int jumptype = 0;
int attacktype = 0;
Console c;
ControlIO control;
Configuration config;
ControlDevice gpad;
float  px, py;
boolean trailOn;
int ENEMYCOUNT = 1;
int playerHealth = 100;

void setup()
{
  fullScreen(P3D);
  colorMode(HSB);
  c = new Console(this);
  c.start();
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -500);
  box2d.setContinuousPhysics(true);
  box2d.listenForCollisions(); 
  PlatformImg = loadImage("Platform.png");
  PlayerIdleImg = loadImage("PIdle.png");
  EnemyImg = loadImage("Enemy.png");
  int w = PlatformImg.width;
  int h = PlatformImg.height;
  EnemyImg.resize(w, h);
  pl1 = new Platform[500];
  en1 = new Enemy[400];
  for (int x=0; x < pl1.length; x++)
  {
    pl1[x] = new Platform(w*x, height-20, PlatformImg, true);
  }
 for (int x=0; x < ENEMYCOUNT; x++)
  {
    en1[x] = new Enemy(random(0, width), height-h, EnemyImg, true);
  }
  PlayerIdleImg.resize(w, h);
  
  P1 = new Player(width/2, height-h, PlayerIdleImg, true, playerHealth);
  control = ControlIO.getInstance(this);
  gpad = control.getMatchedDevice("gpad");
}

void draw()
{
  c.draw();
  c.print();
  background(150, 128, 255);
  for (int x=0; x < 16; x++)
  {
    pl1[x].Draw();
  }
  for (int x=0; x < ENEMYCOUNT; x++)
   {
   en1[x].Draw();
   en1[x].Update();
   }
  P1.Draw();
  P1.Update();
  box2d.step();

  jump = gpad.getButton("A").pressed();
  walk = gpad.getSlider("X AXIS").getValue();
  attack = gpad.getButton("X").pressed();
 // println("Walk: " + walk);
  if (walk == 1.0)
  {
    movetype = 1;
  } 
  else if (walk == -1.0)
  {
    movetype = 2;
  } 
  else
  {
    movetype = 0;
  }
  if (jump)
  {
    jumptype = 1;
  }
  if (jump == false)
  {
    jumptype = 0;
  }
  if (attack)
  {
    attacktype = 1;
  }
  if (attack == false)
  {
    attacktype = 0;
  }
  fill(playerHealth,90,90);
  textSize(50);
  text("Health:"+ playerHealth, 40, height - height/1.1 + TEXT_OFFSET);
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

  if (e1.getType() == "Player" && e2.getType() == "Platform")
  { 
    Player p = (Player)o1;
    Platform pl = (Platform)o2;
    p.Collision(pl);
  }
  else if (e2.getType() == "Player" && e1.getType() == "Platform")
  { 
    Player p = (Player)o2;
    Platform pl = (Platform)o1;
    p.Collision(pl);
  }
   else if (e1.getType() == "Player" && e2.getType() == "Enemy")
  {
    Player p = (Player)o1;
    Enemy en1 = (Enemy)o2;
    p.Collision(en1);
    println("grrrrr");
  }
  else if (e2.getType() == "Player" && e1.getType() == "Enemy")
  {
    Player p = (Player)o2;
    Enemy en1 = (Enemy)o1;
    p.Collision(en1);
    println("hey!");
  }
}