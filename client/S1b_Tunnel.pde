int dTemp = -2000;
int dTemp2 = -3000;
int dTemp3 = -4000;
ArrayList<tunnelSegment> tList = new ArrayList<tunnelSegment>();
int randomRotation = 2;

float S1rotation = 0;
void setup_tunnel(int segments, int startDepth, int interval, int tunnelHeight, int tunnelDepth)
{
  for (int i = 0; i < segments; i++)
  {
    tList.add(new tunnelSegment(((i * (interval + tunnelDepth)) + startDepth) * -1, 10, ((segments - 1) * (interval + tunnelDepth)) * -1, tunnelHeight, tunnelDepth, segments));
  }
}

void tunnelScene(float segmentRotation) {
  for (int i = 0; i < tList.size(); i++) {
    if (i%randomRotation != 0) {
      tList.get(i).rotateSegment(segmentRotation);
    } else {
      tList.get(i).rotateSegment(-segmentRotation);
    }
    tList.get(i).moveSegment(); 
    tList.get(i).drawSegment();
  }
}


public class tunnelSegment {
  private int position;
  private float segmentRotation;
  private int speed;
  private int setBackDepth;
  private int segmentHeight;
  private int segmentDepth;
  private boolean eoScene;
  private boolean enableRotation;
  private float red, green, blue;
  private boolean redTop, greenTop, blueTop;
  private int arraySize;
  public tunnelSegment(int startPos, int segmentSpeed, int resetDepth, int h, int d, int a)
  {
    this.eoScene = false;
    this.enableRotation = true;
    this.segmentHeight = h;
    this.segmentDepth = d;
    this.setBackDepth = resetDepth;
    this.speed = segmentSpeed;
    this.position = startPos;
    this.segmentRotation = 0;
    this.arraySize = a;
    this.red = random(0, 255);
    this.green = random(0, 255);
    this.blue = random(0, 255);

    this.redTop = getStartBoolean();
    this.greenTop = getStartBoolean();
    this.blueTop = getStartBoolean();
  }
  private boolean getStartBoolean()
  {
    float r = random(0, 10);
    if (r > 5) {
      return true;
    }
    return false;
  }

  private void setColors()
  {
    redTop = flagSetter(red, redTop);
    greenTop = flagSetter(green, greenTop);
    blueTop = flagSetter(blue, blueTop);

    red = colorChanger(red, redTop);
    green = colorChanger(green, greenTop);
    blue = colorChanger(blue, blueTop);

    fill(red, green, blue);
  }

  private boolean flagSetter(float value, boolean valueTop)
  {
    boolean result = valueTop;
    if (value < 0)
    {
      result =  false;
    } else if (value > 255)
    {
      result = true;
    }
    return result;
  }

  private float colorChanger(float value, boolean valueTop)
  {
    if (valueTop)
    {
      return value -= random(0, 4);
    }
    return value += random(0, 4);
  }

  public void drawSegment() {
    setColors();
    pushMatrix();
    translate(screenWidth/2, screenHeight/2, position);
    rotate(segmentRotation);
    translate(420*scale, 0, 0);
    box(5, this.segmentHeight, this.segmentDepth);
    popMatrix();

    pushMatrix();
    translate(screenWidth/2, screenHeight/2, position);
    rotate(segmentRotation);
    translate(-420*scale, 0, 0);
    box(5, this.segmentHeight, this.segmentDepth);
    popMatrix();

    pushMatrix();
    translate(screenWidth/2, screenHeight/2, position);
    rotate(segmentRotation);
    translate(0, -420*scale, 0);
    rotateZ(0.5*PI);
    box(5, this.segmentHeight, this.segmentDepth);
    popMatrix();

    pushMatrix();
    translate(screenWidth/2, screenHeight/2, position);
    rotate(segmentRotation);
    translate(0, 420*scale, 0);
    rotateZ(0.5*PI);
    box(5, this.segmentHeight, this.segmentDepth);
    popMatrix();
  }

  public void endScene() {
    eoScene = true;
  }

  public void toggleRotation() {
    this.enableRotation = !this.enableRotation;
    println(this.enableRotation);
  }

  public void moveSegment() {
    this.position += this.speed;
    if (this.position > 1000 && this.eoScene == false)
      this.position = this.setBackDepth;
  }

  public void rotateSegment(float rotation) {

    if (this.enableRotation == true)
    {
      this.segmentRotation += rotation % (2*PI);
      if (this.segmentRotation >= (2*PI)) {
        this.segmentRotation = 0;
      }
      if (-this.segmentRotation >= (2*PI)) {
        this.segmentRotation = 0;
      }
    } else {
      if (this.segmentRotation != 0) {
        if (this.segmentRotation > 0 && this.segmentRotation <(2*PI))
        {
          this.segmentRotation += rotation % (2*PI);
        }
        if (this.segmentRotation < 0 && this.segmentRotation >-(2*PI))
        {
          this.segmentRotation += rotation % (2*PI);
        }
      }
    }
    // println(this.segmentRotation);
  }
}