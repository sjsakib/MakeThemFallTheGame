import java.util.Iterator;
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
Box2DProcessing box2d;

int planeRate = 200;
int shotDown;
int came;
int life;
float planeSpeed;
float planeLevel;
float level;
int toUpLevel;
boolean bonus = true;
boolean isBest = false;


String[] bestString;
int best;
int newBest;

ArrayList<Flyer> fs;
Cloud[] clouds;


void game() {
  background(gBg);
  for (Flyer p : fs) {
    p.fly();
    p.display();
  }
  for (Cloud c : clouds) {
    c.display();
    c.update();
  }
  box2d.step();
  addPlane();
  delete();

  if (came == toUpLevel) {
    level++;
    if(bonus) shotDown+=level*5;
    toDisplay = "levelUp";
    levelUpT.set(2000);
    for (Cloud c : clouds) {
      c.reset();
    }
    for(Flyer f:fs) {
      box2d.destroyBody(f.body);
    }
    fs.clear();
    planeLevel+=50;
    toUpLevel+=(level*10)+5;
    planeSpeed = 100;
  }

  if (life<1) {
    toDisplay = "gameOver";
    art.reset();
    if(shotDown>best){
      isBest  = true;
      newBest = shotDown;
      String[] s = new String[1];
      s[0] = ""+newBest;
      saveStrings("scssq",s);
    }
  }

  backArrow.display();
  if (backArrow.isClicked()) {
    toDisplay = "paused";
  }

  //the header...
  strokeWeight(4);
  stroke(0);
  noFill();
  ellipse(0, 0, 130, 130);
  textSize(20);
  textFont(fSmall);
  textAlign(CENTER);
  text(shotDown, 20, 30);
  ellipse(width/2, 0, 70, 70);
  text(int(level)+1, width/2, 20);
  ellipse(width, 0, 130, 130);
  text(life, width-20, 30);
}


void addPlane() {
  if (frameCount%planeRate == 0) {
    Plane p = new Plane(width+50, planeLevel, 100, 20);
    float r = random(1);
    if (r<.05) p.containLife = true;
    fs.add(p);
  }
}

void delete() {
  Iterator it = fs.iterator();

  while (it.hasNext ()) {
    Flyer f =(Flyer) it.next();
    if (f.out()) {
      if (f.getClass() == Plane.class) {
        came++;
      }
      if (f.flying) {
        life--;
        bonus = false;
      }
      box2d.destroyBody(f.body);
      it.remove();
    }
  }
}

void resetGame() {
  came = 0;
  life = 5;
  shotDown = 0;
  for (Cloud c : clouds) {
    c.reset();
  }
  for(Flyer f:fs) {
    box2d.destroyBody(f.body);
  }
  fs.clear();
  planeSpeed = 100;
  level = 0;
  planeLevel = 200;
  toUpLevel = 10;
  bonus = true;
}

void levelUp() {
  background(gBg);
  textAlign(CENTER);
  textSize(30);
  textFont(f);
  text("Level Up: "+(int(level)+1), width/2, height/2);
  if (bonus) {
    textSize(25);
    text("Level Bonus: "+int(level*5), width/2, height/2+50);
  }


  if (levelUpT.isFinished()) {
    toDisplay = "game";
  }
}





//------------Box2D Collision handeling methods------------------\\
void beginContact(Contact cp) {

  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();

  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  Flyer e1 = (Flyer) b1.getUserData();
  Flyer e2 = (Flyer) b2.getUserData();

  if (e1.flying || e2.flying) {
    shotDown++;
    planeSpeed+=20;

    if (e1.containLife || e2.containLife) {
      life++;
      e1.containLife = false;
      e2.containLife = false;
    }
  }
  e1.flying = false;
  e2.flying = false;
}

void endContact(Contact cp) {
}

