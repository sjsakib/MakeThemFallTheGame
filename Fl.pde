class Flyer {
  float w, h;
  Body body;
  
  boolean containLife;

  boolean markedToDelete;
  boolean flying;

  Flyer() {
    markedToDelete = false;
    containLife = false;
  }
  
  void display() {
  }
  
  void destroy() {
  }
  
  void fly() {
  }
  
  boolean out() {
    Vec2 loc = box2d.getBodyPixelCoord(body);
    return loc.x+w/2<0 ||loc.y-h/2>height;
  }
}

