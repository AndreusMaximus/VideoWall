PShape lhand;
PShape rhand;
PShape Logo;
PShape myLogo;
float rotation = 0;

void S0Setup()
{
  rhand = loadShape("rhand.obj");
  lhand = loadShape("lhandb.obj");
  
    myLogo = loadShape("brimstone.obj");
    myLogo.scale(0.75);
 
    Logo = loadShape("kruik.obj");
    Logo.scale(3*scale*2);
  
  lhand.setStroke(true);
  rhand.setStroke(true);
  Logo.setStroke(true);
  myLogo.setStroke(true);
  rhand.scale(0.75);
  lhand.scale(0.75);
  rhand.rotateX(PI);
  lhand.rotateX(PI); 
  Logo.rotateX(PI);
}

void S0Update() {
 // background(255);
  rotation += 0.01;
  lhand.setStrokeWeight(2);
  lhand.setStroke(color(0, 0, 0));
  rhand.setStrokeWeight(2);
  rhand.setStroke(color(0, 0, 0));
  myLogo.setStrokeWeight(2);
  myLogo.setStroke(color(200, 0, 0));


  pushMatrix();
  translate(width/2, height/2, 0);
  rotateY(0.25*PI);
  shape(lhand, 50, 400);
  popMatrix();
  pushMatrix();
  translate(width/2, height/2, 0);
  rotateY(-0.25*PI);
  shape(rhand, -50, 400);
  popMatrix();

  pushMatrix();
  translate(width/2, height/2, -50);
  rotateY(rotation);
  rotateX(PI);
  shape(myLogo, 0, -100);
  popMatrix();
}

void S0JustLogoUpdate(int depth){
  rotation += 0.01;
   pushMatrix();
  translate(screenWidth/2, (screenHeight/2), -(depth/2));
  rotateY(rotation);
  shape(Logo, 0, -100);
  popMatrix();
}