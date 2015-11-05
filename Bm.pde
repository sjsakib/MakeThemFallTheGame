class Bomb extends Flyer {

  Bomb(float x, float y, float w_, float h_) {
    w = w_;
    h = h_;
    flying = false;

    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    body = box2d.createBody(bd);

    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(h/2);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 3;
    fd.friction   = 5;
    fd.restitution = 1;

    body.createFixture(fd);
    body.setUserData(this);
  }

  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float an = body.getAngle();

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-an);
    face(0,0,h);
    //imageMode(CENTER);
    //image(stone,0, 0, h, h);
    popMatrix();
  }

  boolean isClicked() {
    Vec2 point = box2d.coordPixelsToWorld(mouseX, mouseY);
    Fixture f  = body.getFixtureList();
    boolean inside = f.testPoint(point);
    return inside;
  }
  void destroy() {
    box2d.world.destroyBody(body);
    body = null;
  }
}

