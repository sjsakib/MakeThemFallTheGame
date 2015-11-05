class Cloud {
  PVector loc;
  float r;
  boolean clicked;

  int bomb;
  Timer t;

  Cloud(PVector loc_) {
    loc = loc_.get();
    r  = 60;
    clicked = false;

    bomb = 1;

    t = new Timer();
  }

  void reset() {
    t.reset();
    bomb = 1;
  }

  void display() {
    imageMode(CENTER);
    if (clicked) { 
      image(cloudI, loc.x, loc.y-20, cloudI.width*.8, cloudI.height*.8);
    } else {
      image(cloudI, loc.x, loc.y);
    }
    fill(0);
    //textAlign(CENTER);
    //textSize(32);
    //text(bomb, loc.x, loc.y);
    if (!t.isFinished()) {
      noFill();
      strokeWeight(3);
      stroke(255,0,0);
      float an = (t.remaining()/float(t.t))*TWO_PI;
      an = map(an,0,TWO_PI,TWO_PI,0);
      arc(loc.x, loc.y, cloudI.width,cloudI.width, 0, an, OPEN);
      textSize(16);
      text("reloading...",loc.x,loc.y+10);
    }
  }

  boolean clicked() {
    PVector mouse = new PVector(mouseX, mouseY);
    mouse.sub(loc);

    return mousePressed && mouse.mag()<r;
  }

  void update() {
    if (bomb == 0 &&!t.isSet) {
      t.set(8000);
    }
    if (bomb == 0 &&t.isSet && t.isFinished()) {
      bomb = 1;
      t.isSet = false;
    }
  }
}

