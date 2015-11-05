class ArtWork {
  Ball[] balls;
  float G = 5;
  Ball mouse;
  float jump = 150;
  int jumpGap = 50;
  int fCount = 0;

  boolean canDraw = false;

  PImage img;

  ArtWork() {
    mouse = new Ball((width/2)-50, height/2, 50);

    balls = new Ball[20];
    for (int i= 0; i<balls.length; i++) {
      balls[i] = new Ball(random(100, width), random(100, height), 5);
    }

    img  = gBg.get();
    fCount+=jumpGap;
  }
  void run() {
    fCount++;
    noTint();
    imageMode(CORNER);
    image(img, 0, 0);
    for ( int i = 0; i<balls.length; i++) {
      for (int j = 0; j<balls.length; j++) {
        if (i!=j) {
          PVector F = balls[i].attract(balls[j]);
          PVector f = balls[i].attract(mouse);
          balls[i].applyForce(f);
          //balls[i].applyForce(F);
        }
      }
      balls[i].update();
      //balls[i].checkEdge();
      if (canDraw) balls[i].display();
    }


    if (fCount ==jumpGap) {
      mouse.loc.x+=jump;
      mouse.loc.y+=jump;
      fCount+=jumpGap-10;
    } else if ( fCount == jumpGap*2) {
      mouse.loc.x+=jump;
      mouse.loc.y-=jump;
      fCount+=jumpGap-10;
    } else if (fCount == jumpGap*3) {
      mouse.loc.x = width/2;
      mouse.loc.y = height/2;
      canDraw = true;
    }

    loadPixels();
    img.loadPixels();
    for (int i = 0; i<pixels.length; i++) {
      img.pixels[i] = pixels[i];
    }
    img.updatePixels();
  }

  void reset() {
    /*for (int i= 0; i<balls.length; i++) {
      balls[i] = new Ball(random(100, width), random(100, height), 5);
    }

    img  = gBg.get();
    canDraw = false;
    fCount = 0;
    */
  }
}


class Ball {
  PVector loc;
  PVector vel;
  PVector ac; 
  float mass;
  PVector pLoc;
  color c;

  float G = 5;

  Ball(float x, float y, float m) {
    loc = new PVector(x, y);
    vel = new PVector(0, 0);
    ac = new PVector(0, 0);
    mass = m;
    c = color(random(0, 255), random(0, 255), random(0, 255));
  }

  void update() {
    vel.add(ac);
    pLoc = loc.get();
    loc.add(vel);
    ac.mult(0);
  }

  void checkEdge() {
    if (loc.x<0 ) {
      vel.x*=-1;
      loc.x = 0;
    } else if ( loc.x>width) {
      vel.x*=-1;
      loc.x = width;
    }
    if (loc.y<0) {
      vel.y*=-1;
      loc.y = 0;
    } else if (loc.y>height) {
      vel.y*=-1;
      loc.y = height;
    }
  }

  void display() {
    strokeWeight(.3);
    stroke(c);
    line(pLoc.x, pLoc.y, loc.x, loc.y);
  }

  void applyForce(PVector f) {

    ac.add(PVector.div(f, mass));
  }

  PVector attract( Ball b) {

    PVector f = PVector.sub(b.loc, loc);
    float dist = f.mag();
    dist = constrain(dist, 5, 25);
    f.normalize();
    float strength = (G*mass*b.mass)/(dist*dist);
    f.mult(strength);

    return f;
  }
}

