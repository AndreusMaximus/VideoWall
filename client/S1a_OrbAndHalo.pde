
orbAndHalo centerPiece;

void setup_orbCenterpiece()
{
  centerPiece = new orbAndHalo(new Toroid(this, 50, 50));
}

void orbScene()
{
  centerPiece.drawOrb((int)ap.get(1).getValue(), 0.01);
}

void enableOrb()
{
  centerPiece.setupScene();
}

public class orbAndHalo {

  color orbFillColor;
  color orbStrokeColor;

  float orbRotationX, orbRotationY, orbRotationZ;

  color ringFillColor;
  color ringStrokeColor;

  float ringRotationX, ringRitationY, ringRotationZ;

  float xPos, yPos, zPos;

  boolean orbSetup, orbExit;

  float sceneRotationX, sceneRotationY, sceneRotationZ;

  float trX, trY, trZ;

  Toroid t; 
  public orbAndHalo(Toroid halo)
  {
    this.t = halo;
    this.t.stroke(#981212);
    this.t.strokeWeight(1);
    this.t.fill(#981212);
    this.t.setRadius(10*scale, 25*scale, 400*scale);
    this.t.drawMode(Shape3D.TEXTURE|Shape3D.WIRE);

    this.sceneRotationX = PI;
    this.sceneRotationY = 0;
    this.sceneRotationZ = 0;

    this.xPos = screenWidth / 2;
    this.yPos = screenHeight/2;
    this.zPos = -2000;

    this.orbSetup = false;
    this.orbExit = false;
    this.trX = 0;
    this.trY = 0;
    this.trZ = 0;
  }

  public void drawOrb(int audioValue, float r)
  {
    this.trX -= r + random(0, 0.02);
    this.trY += r +random(0, 0.02);
    this.trZ += 2*r+ random(0, 0.02);
    checkSetup();
    checkExit();
    pushMatrix();
    noFill();
    translate(xPos, 0, 0);
    rotateX(sceneRotationX);
    rotateY(sceneRotationY);
    rotateZ(sceneRotationZ);
    translate(0, yPos, zPos);
    sphere(audioValue*scale);

    rotateX(trX);
    rotateZ(trY);
    rotateY(trZ);

    t.draw();

    popMatrix();
  }

  private void checkSetup()
  {
    if (orbSetup) {
      if (sceneRotationX < 2*PI)
      {
        sceneRotationX += 0.01;
      } else
      {
        sceneRotationX = 2*PI; 
        orbSetup = false;
      }
    }
  }

  private void checkExit()
  {
    if (orbExit) {
      if (sceneRotationX > PI)
      {
        sceneRotationX -= 0.01;
      } else
      {
        sceneRotationX = PI; 
        orbExit = true;
      }
    }
  }
  public void setupScene()
  {
    if (orbSetup == false)
    {
      orbSetup = true;
    }
  }

  public void exitScene()
  {
    if (orbExit == false)
    {
      orbExit = true;
    }
  }
}