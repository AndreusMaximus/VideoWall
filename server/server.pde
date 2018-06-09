import shapes3d.*;
import shapes3d.animation.*;
import shapes3d.utils.*;
import processing.net.*;

import beads.*;
import java.util.Arrays; 

//Voor de Audio player
AudioContext ac;
PowerSpectrum ps;

//Ding dat kijkt wat voor muziek er ongeveer gedraaid wordt
identifier id;

//alle servers
Server s1;
Server s2; 
Server s3;
Server s4; 
Server s5;
Server s6; 
Server s7;
Server s8; 
Server s9;
Server s10; 
Server s11;
Server s12; 

Client client;

float ch = 0;

boolean server = true;

int scene = 0;

int screenWidth = 0;
int screenHeight = 0;

int scale = 4;

int screenx = 0;
int screeny = 0;
float rotx = 0;
float roty = 0;

//alle arrays
ArrayList<audioPoint> ap = new ArrayList<audioPoint>();
ArrayList<channel> cl = new ArrayList<channel>();

//Ambiguous timer
int counter = 0;

//Alle scene objecten
spikedBall sb; //zon random vormpie in het midden
void setup() {
  //fullScreen(P3D);
  size(800,800,P3D);
  screenWidth = 1440*4;
  screenHeight = 900*3;
  //screenx = screenWidth/2;
  //screeny = screenHeight/2;
  
  imageMode(CENTER);
  ortho();
  //Setup alle dingen die dingen aansturen enzo
  ac = new AudioContext();
  id = new identifier(ap, 1);

  for (int i = 0; i < 256; i++) {
    ap.add(new audioPoint(1, 400, 200));
  }
  for (int i = 0; i < 64; i ++) {
    cl.add(new channel(64));
  }
  if (server) {
    s1 = new Server(this, 1);
    s2 = new Server(this, 2);
    s3 = new Server(this, 3);
    s4 = new Server(this, 4);
    s5 = new Server(this, 5);
    s6 = new Server(this, 6);
    s7 = new Server(this, 7);
    s8 = new Server(this, 8);
    s9 = new Server(this, 9);
    s10 = new Server(this, 10);
    s11 = new Server(this, 11);
    s12 = new Server(this, 12);
  }
  if (!server) {
    client = new Client(this, "192.168.2.146", 1);
  }

  //Setup all scenes
  //Sene 0
  S0Setup();
  setupStartMenu();
  //Scene 1
  setup_tunnel(8, 2000, 500, (int)screenHeight/2, 500);
  setup_orbCenterpiece();
  //Scene 2
  sb = new spikedBall(180);




  //size(1000,1000,P3D);
}

void fileSelected(File selection) {
  /*
   * Here's something we've seen before...
   */
  String audioFileName = selection.getAbsolutePath();
  Sample sample = SampleManager.sample(audioFileName);
  SamplePlayer player = new SamplePlayer(ac, sample);
  Gain g = new Gain(ac, 2, 0.2);
  g.addInput(player);
  ac.out.addInput(g);
  /*
   * To analyse a signal, build an analysis chain.
   */
  ShortFrameSegmenter sfs = new ShortFrameSegmenter(ac);
  sfs.addInput(ac.out);
  FFT fft = new FFT();
  ps = new PowerSpectrum();
  sfs.addListener(fft);
  fft.addListener(ps);
  ac.out.addDependent(sfs);
  //and begin
  ac.start();
}

void draw()
{
  println("x:" + screenx + "y:" + screeny);
  translate(0,0,0);
  rotateX(-0.02);
  background(0);
  switch(scene) {
  case 0:
    startMenu();
    break;
  case 1:
    S1Update();
    orbScene();
    break;
  case 2:
    sb.drawShape();
    sb.update();
    S2Update();
    break;
  case 3:
    S3Visualizer();
    break;
  case 100:
    startVisualizer();
    break;
  }
  globalUpdate();
  move();
}

void startMenu()
{
  S0Update();
  buttonUpdate();
  for (int i = 0; i < bList.size(); i++) {
    bList.get(i).drawButton();
  }
}

void startVisualizer()
{
  if(server){
  selectInput("Select an audio file:", "fileSelected");
  }
  scene = 1;
}

void S1Update() {
  S1rotation += 0.01;
  tunnelScene(0.01);
}

void move()
{
  if (keyPressed) {
    if (keyCode == UP) {
      screeny +=50;
    }
    if (keyCode == DOWN) {
      screeny -=50;
    }
    if (keyCode == LEFT) {
      screenx +=50;
    }
    if (keyCode == RIGHT) {
      screenx -=50;
    }
    if(key == 'x'){
     rotx -= 0.001; 
    }
    if(key == 'c'){
     ch += 0.001; 
    }
  }
      //rotx = atan(((int)screeny)/((int)depth));
     // print(rotx);
      roty = atan(((int)screenx)/((int)depth));
}

void keyPressed() {
  if (scene == 1) {
    if (key == 't') {
      for (int i = 0; i < tList.size(); i++) {
        randomRotation = (int)random(1, 8);
        tList.get(i).toggleRotation();
      }
    }
  }
  if (key == '1') {
    scene = 1; 
    enableOrb();
  }
  if (key == '2') {
    scene = 2; 
    if (scene == 1) {
      centerPiece.exitScene();
    }
  }
  if (key == '3') {
    scene = 3; 
    if (scene == 1) {
      centerPiece.exitScene();
    }
  }
}