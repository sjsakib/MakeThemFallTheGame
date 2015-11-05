void splash() {
  background(sp);
  textAlign(CENTER);
  textSize(32);
  fill(0);
  textFont(f);
  text("Make Them Fall", width/2, height/2);

  if (splashT.isFinished()) {
    toDisplay = "menu";
  }
}


void mainMenu() {
  art.run();
  tint(255,150);
  imageMode(CORNER);
  image(gBg,0,0);
  noTint();
  fill(0);
  playGame.display();
  if (playGame.isClicked()) {
    toDisplay = "game";
  }
  help.display();
  if (help.isClicked()) {
    toDisplay  = "help";
  }
  credits.display();
  if (credits.isClicked()) {
    toDisplay = "credits";
  }
  exit.display();
  if (exit.isClicked()) {
    exit();
  }
}

void help() {
  art.run();
  tint(255,150);
  imageMode(CORNER);
  image(gBg,0,0);
  noTint();
  textAlign(CENTER);
  rectMode(CENTER);
  fill(0);
  textSize(18);
  textFont(fSmall);
  String s = "The angry creatures are the villains. Well, don't ask me what they've done. You can always let them escape if you don't believe me.\nSo your job is to tap the clouds to drop the smilling guys and make \"them\" fall.";
  text(s, width/2, height/2, width*.8, height*.6);

  back.display();
  if (back.isClicked()) {
    toDisplay = "menu";
  }
}

void credits() {
  art.run();
  tint(255,150);
  imageMode(CORNER);
  image(gBg,0,0);
  noTint();
  textSize(20);
  textFont(fSmall);
  String s  = "Programmer-\nsjsakib\n\nIdea & design-\nSabbir Tutul.\n\nSabbir dedicates to-\nMoinar Maa.";
  text(s,width/2,80);
  
  back.display();
  if (back.isClicked()) {
    toDisplay = "menu";
  }
}

void gameOver() {
  background(gBg);
  textAlign(CENTER);
  textSize(45);
  fill(255, 0, 0);
  textFont(f);
  text("Game Over", width/2, height/2-100);
  fill(0);
  if (isBest) {
    textSize(30);
    text("Congrats! Currently you are the best!", width/2, height/2-50);
    text("You: "+shotDown+"\nPrevious Best: "+best, width/2, height/2);
  } else {
    text("You: "+shotDown+"\nBest: "+best, width/2, height/2);
  }
  retry.display();
  mainMenu.display();

  if (retry.isClicked()) {
    resetGame();
    toDisplay = "game";
    
    if(isBest) best = newBest;
  }
  if (mainMenu.isClicked()) {
    resetGame();
    toDisplay = "menu";
    
    if(isBest) best = newBest;
  }
}

void face(float x, float y, float r) {
  strokeWeight(2);
  pushMatrix();
  translate(x, y);
  ellipse(0, 0, r, r);
  arc(0, -r*.1, r*.75, r*.75, PI/8, PI-PI/8, OPEN);
  ellipse(-r*.15, -r*.05, r*.1, r*.1);
  ellipse(r*.15, -r*.05, r*.1, r*.1);
  popMatrix();
}

void angry(float r) {
  ellipse(0, 0, r, r);
  arc(0, r*.4, r*.4, r*.75, PI+PI/8, TWO_PI- PI/8, OPEN);
  ellipse(-r*.15, -r*.15, r*.1, r*.1);
  ellipse(r*.15, -r*.15, r*.1, r*.1);
}

void unhappy(float r) {
  ellipse(0, 0, r, r);
  line(-r*.3, r*.2, r*.3, r*.2);
  ellipse(-r*.15, -r*.1, r*.2, r*.2);
  ellipse(r*.15, -r*.1, r*.2, r*.2);
}

void arrow(float x, float y, float r, int rotate) {
  pushMatrix();
  translate(x, y);
  if (rotate<0) {
    rotate(PI);
  }
  strokeJoin(ROUND);
  noFill();
  strokeWeight(2);
  beginShape();
  vertex(-r, -r*.4);
  vertex(r*.3, -r*.4);
  vertex(0, -r);
  vertex(r, 0);
  vertex(0, r);
  vertex(r*.3, r*.4);
  vertex(-r, r*.4);
  endShape(CLOSE);
  popMatrix();
}

void paused() {
  art.run();
  tint(255,150);
  imageMode(CORNER);
  image(gBg,0,0);
  noTint();
  TextBox resume = new TextBox("Resume", new PVector(width/2, height/2-40), 20);
  TextBox mainMenu = new TextBox("Quit Game", new PVector(width/2, height/2), 20);
  TextBox restart = new TextBox("Restart", new PVector(width/2, height/2+40), 20);

  resume.display();
  mainMenu.display();
  restart.display();
  if (resume.isClicked()) {
    toDisplay = "game";
  } else if (mainMenu.isClicked()) {
    resetGame();
    art.reset();
    toDisplay = "menu";
  } else if(restart.isClicked()) {
    resetGame();
    toDisplay = "game";
  }
}

