class Arrow {
  PVector loc;
  boolean rotate;
  float radius;

  Arrow(float x_, float y_, float r_, boolean rotate_) {
    loc = new PVector(x_,y_);
    radius = r_;
    rotate = rotate_;
  }

  void display() {
    float r;
    boolean hover = PVector.sub(loc,new PVector(mouseX,mouseY)).mag()<=radius;
    if(hover) {
      r = radius*1.5;
    } else r = radius;
    stroke(0);
    pushMatrix();
    translate(loc.x, loc.y);
    if (rotate) {
      rotate(PI);
    }
    strokeJoin(ROUND);
    noFill();
    strokeWeight(2);
    beginShape();
    vertex(-r, -r*.4);
    vertex(r*.3, -r*.4);
    vertex(0, -r*.8);
    vertex(r, 0);
    vertex(0, r*.8);
    vertex(r*.3, r*.4);
    vertex(-r, r*.4);
    endShape(CLOSE);
    popMatrix();
  }
  
  boolean isClicked() {
    return mousePressed && PVector.sub(loc,new PVector(mouseX,mouseY)).mag()<=radius;
  }
}

