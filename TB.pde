class TextBox {
  String text;
  PVector loc;
  float textSize;
  float h, w;

  TextBox(String s, PVector loc_, float ts) {
    text = s;
    loc = loc_.get();
    textSize = ts;

    w = s.length()*ts;
    h = ts*1.5;
  }

  void display() {
    if (textSize<=20) textFont(fSmall);
    else textFont(f);
    textSize(textSize);
    textAlign(CENTER);
    boolean hover = abs(loc.x-mouseX)<=w/2 && abs(loc.y-mouseY)<=h/2;

    if (hover) {
      textFont(f);
      textSize(textSize*1.5);
    } else fill(0);

    text(text, loc.x, loc.y+h/2);
  }

  boolean isClicked() {
    return mousePressed && abs(loc.x-mouseX)<=w/2 && abs(loc.y-mouseY)<=h/2;
  }
}

