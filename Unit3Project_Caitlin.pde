import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

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
EntityManager em;
int w;
int h;

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
  w = PlatformImg.width;
  h = PlatformImg.height;
  EnemyImg.resize(w, h);
  pl1 = new Platform[500];
  en1 = new Enemy[400];

  PlayerIdleImg.resize(w, h);

  control = ControlIO.getInstance(this);
  gpad = control.getMatchedDevice("gpad");
  em = new EntityManager();
   LoadDefaultEntities();
}



void draw()
{
  c.draw();
  c.print();
  background(150, 128, 255);
  box2d.step();

  jump = gpad.getButton("A").pressed();
  walk = gpad.getSlider("X AXIS").getValue();
  attack = gpad.getButton("X").pressed();
  // println("Walk: " + walk);
  if (walk == 1.0)
  {
    movetype = 1;
  } else if (walk == -1.0)
  {
    movetype = 2;
  } else
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
  fill(P1.getHealth(), 90, 90);
  textSize(50);
  text("Health:"+ P1.getHealth(), 40, height - height/1.1 + TEXT_OFFSET);
 //text("Enemy Health:"+ en1[0].getEnemyHealth(), 40, height - height/1.3 + TEXT_OFFSET);

  if (P1.getHealth() <= 0)
  {
    background(0, 0, 0);
  }
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

  if (o1.getClass() == Player.class && o2.getClass() == Enemy.class)
  {
    Player p = (Player)o1;
    Enemy en1 = (Enemy)o2;
    p.Collision(o2);
    println("grrrrr");
  } else if (o2.getClass() == Player.class && o1.getClass() == Enemy.class)
  {
    Player p = (Player)o2;
    Enemy en1 = (Enemy)o1;
    p.Collision(o1);
    println("hey!");
  }
  if (o1.getClass() == Player.class && o2.getClass() == Platform.class)
  { 
    Player p = (Player)o1;
    Platform pl = (Platform)o2;
    p.Collision(o2);
    println("LOLOL");
  } else if (o2.getClass() == Player.class && o1.getClass() == Platform.class)
  { 
    Player p = (Player)o2;
    Platform pl = (Platform)o1;
    p.Collision(o1);
    println("LOLOL");
  }
}

void endContact(Contact cp) 
{
}

void LoadDefaultEntities()
{
  //Load player
  //Load platforms
  em.CreateEntity(new Player(width/2, height-h, PlayerIdleImg, true, playerHealth));
  P1 = em.GetPlayer();
  println(P1._type);

  int platNum = (int)(width/w + 0.5);
  for (int x=0; x < platNum; x++)
  {
    em.CreateEntity(new Platform(w*x, height-20, PlatformImg, true));
  }
  for (int x=0; x < ENEMYCOUNT; x++)
  {
    em.CreateEntity(new Enemy(random(0, width), height-h, EnemyImg, true));
  }
}