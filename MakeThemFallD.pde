import java.awt.Image;
//text boxes for menu items;
TextBox playGame;
TextBox help;
TextBox credits;
TextBox back;
TextBox mainMenu;
TextBox retry;
TextBox exit;

PFont f;
PFont fSmall;

String toDisplay;

Arrow backArrow;

//All the timers go here...
Timer splashT;
Timer levelUpT;

//images
PImage gBg;
PImage cloudI;
PImage sp;
PImage logo;

ArtWork art;

void setup() {
  box2d = new Box2DProcessing(this, 30);
  box2d.createWorld();
  box2d.listenForCollisions();
  box2d.setGravity(0, -10.0);

  size(720, 480);

  fs = new ArrayList<Flyer>();
  clouds = new Cloud[4];

  for (int i = 0; i<4; i++) {
    clouds[i] = new Cloud(new PVector((width/5)*(i+1), 100));
  }

  toDisplay = "splash";
  backArrow = new Arrow(60,height-60,30,true);

  //initialiaze timers
  splashT = new Timer();
  levelUpT = new Timer();
  splashT.set(8000);
  life = 5;
  planeSpeed = 100;
  planeLevel = 200;
  toUpLevel = 10;


  //menu items:
  playGame = new TextBox("Play", new PVector(width/2, 170), 20);
  help =  new TextBox("About", new PVector(width/2, 220),  20);
  credits =   new TextBox("Credits", new PVector(width/2, 270), 20);
  exit = new TextBox("Exit", new PVector(width/2, 400), 20);
  back = new TextBox("Back", new PVector(width/2, height*.7),  20);
  mainMenu = new TextBox("Main Menu", new PVector(width/2, height/2+100), 20);
  retry = new TextBox("Retry", new PVector(width/2, height/2+130), 20);


  f = loadFont("Anaktoria-48.vlw");
  fSmall = loadFont("Anaktoria-20.vlw");
  
  bestString = loadStrings("scssq");
  best = int(bestString[0]);
  
  
  //loading images...
  gBg = loadImage("gBg.jpg");
  gBg.resize(width, height);
  cloudI = loadImage("cloud.png");
  cloudI.resize(120, 80);
  sp = loadImage("gBgArt.jpg");
  sp.resize(720,480);
  logo = loadImage("logo.png");
  logo.resize(32,32);
  
  
  //frame.setIconImage((Image) logo.getNative());
  art = new ArtWork();
}

void draw() {
  if (focused) {
    if (toDisplay == "splash") {
      splash();
    } else if (toDisplay == "menu") {
      mainMenu();
    } else if (toDisplay == "game") {
      game();
    } else if (toDisplay == "help") {
      help();
    } else if (toDisplay == "credits") {
      credits();
    } else if (toDisplay == "gameOver") {
      gameOver();
    } else if (toDisplay == "levelUp") {
      levelUp();
    } else if(toDisplay == "paused") {
      paused();
    }
  }
}

void mousePressed() {
  for (Cloud c : clouds) {
    if (c.clicked()) {
      c.clicked  = true;
    }
  }
}
void mouseReleased() { 
  for (Cloud c : clouds) {
    if (c.clicked) {
      if (c.bomb>0) {
        fs.add(new Bomb(c.loc.x, c.loc.y, 10, 30));
        c.bomb--;
      }
      c.clicked  = false;
    }
  }
}
