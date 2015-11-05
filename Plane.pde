class Plane extends Flyer {

  Plane(float x, float y, float w_, float h_) {
    w = w_;
    h = h_;
    flying = true;

    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    body = box2d.createBody(bd);

    PolygonShape ps = new PolygonShape();
    ps.setAsBox(box2d.scalarPixelsToWorld(w/2), box2d.scalarPixelsToWorld(h/2));

    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    fd.density = 1;
    fd.friction   = 3.0;
    fd.restitution = .8;

    body.createFixture(fd);
    body.setUserData(this);
  }

  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float an = body.getAngle();

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-an);
    strokeWeight(2);
    rectMode(CENTER);
    rect(0,0,w,h);
    if(flying) angry(h);
    else unhappy(h);
    imageMode(CENTER);
    //image(planeI, 0, 0, w, h);
    if (containLife) {
      //image(stone,0,-15,15,15);
      face(0,-20,15);
    }
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

  void fly() {
    if (flying) {
      Vec2 g = new Vec2(0, -10.0);
      g.mulLocal(body.m_mass);
      Vec2 path = box2d.vectorPixelsToWorld(-planeSpeed, 0);
      Vec2 v = body.getLinearVelocity();
      path.subLocal(v);
      Vec2 f = path.sub(g);
      Vec2 p = body.getWorldCenter();


      body.applyForce(f, p);
    }
  }
}

