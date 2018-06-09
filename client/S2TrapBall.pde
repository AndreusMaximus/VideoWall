int grid[][] = new int[40][40];
color cgrid[][] = new color[40][40];
PImage texture ;
public class spikedBall {
  private int s;
  private PShape aids;
  private float t;
  private boolean pulse;
  private int high;
  private int x, y;
  private int val;
  private color c;
  public spikedBall(int size)
  {
    this.s = size;
    aids = createShape();
    this.t = millis();
    this.pulse = false;

    for (int i = 0; i < 20; i++) {
      for (int j = 0; j < 20; j++) {
        grid[i][j] = 0;
      }
    }
    texture = loadImage("tkmball.png");
    texture.resize(525*scale, 525*scale);
    this.high = 0;
  }

  public void setData(ArrayList<audioPoint> apl)
  {
    aids = createShape();
    aids.beginShape();
    //aids.noFill();
    aids.stroke(#67FF5D);
    aids.strokeWeight(20);
    aids.textureMode(IMAGE);
    textureWrap(REPEAT);
    aids.texture(texture);
    for (int i = 0; i < s; i += 6)
    {
      aids.vertex(cos(radians(i*(360/this.s)))*apl.get(i).getOffValue(250*scale, 150*scale), sin(radians(i*(360/this.s)))*apl.get(i).getOffValue(250*scale, 150*scale), (texture.width/2)-cos(radians(i*(360/this.s)))*apl.get(i).getOffValue(250*scale, 150*scale), (texture.height/2)-sin(radians(i*(360/this.s)))*apl.get(i).getOffValue(250*scale, 150*scale));
    }
    aids.endShape(CLOSE);
    if (server) {
      if (millis() - this.t >100) {
        for (int i = 0; i < apl.size(); i++) {
          if (apl.get(i).getOffValue(100, 0) >= 95) {
            pulse = true;
            high++;
            t = millis();
            this.x = (int)random (0, 40);
            this.y = (int)random (0, 40);
            this.val =(int)random(high * 20, high * 100);
            this.c = color(random(0, 255), random(0, 255), random(0, 255));
            sendMessage(x, y, val, c);
          }
        }
      }
    }
  }

  public void drawShape()
  {
    pushMatrix();
    translate(0, height);
    translate(screenWidth/2, -(screenHeight/2), 100);
    rotate(PI);
    shape(aids, 0, 0);
    popMatrix();
    ellipse(screenWidth/2, -(screenHeight/2),100,100);
  }
  
  public void setValues(int mx, int my, int mval, color mc)
  {
    if (millis() - this.t >100) {
       
    this.x = mx;
    this.y = my;
    this.val = mval;
    this.c = mc;
    pulse = true;
    }
  }

  public void update() {
    if (pulse) {
      if (grid[x][y] <= 100) {
        grid[x][y] = val;
        cgrid[x][y] = c;
        if (x >= 2)
        {
          if (y >=2) {
            grid[x-2][y-1] = val/4; 
            cgrid[x-2][y-1] = c;
          }
          grid[x-2][y] = val/4; 
          cgrid[x-2][y] = c;
          if (y <=38) {
            grid[x-2][y+1] = val/4; 
            cgrid[x-2][y+1] = c;
          }
        }

        if (x >= 1)
        {
          if (y >=1) {
            grid[x-1][y-1] = val/3; 
            cgrid[x-1][y-1] = c;
          }
          if (y >=2) {
            grid[x-1][y-2] = val/4; 
            cgrid[x-1][y-2] = c;
          }
          grid[x-1][y] = val/2; 
          cgrid[x-1][y] = c;
          if (y <=37) {
            grid[x-1][y+2] = val/4;
            cgrid[x-1][y+2] = c;
          }
          if (y <=38) {
            grid[x-1][y+1] = val/4; 
            cgrid[x-1][y+1] = c;
          }
        }

        if (y >=1) {
          grid[x][y-1] = val/2; 
          cgrid[x][y-1] = c;
        }
        if (y >=2) {
          grid[x][y-2] = val/4; 
          cgrid[x][y-2] = c;
        }
        if (y <=37) {
          grid[x][y+2] = val/4; 
          cgrid[x][y+2] = c;
        }
        if (y <=38) {
          grid[x][y+1] = val/2; 
          cgrid[x][y+1] = c;
        }


        if (x <= 37)
        {
          if (y >=2) {
            grid[x+2][y-1] = val/4; 
            cgrid[x+2][y-1] = c;
          }
          grid[x+2][y] = val/4; 
          cgrid[x+2][y] = c;
          if (y <=38) {
            grid[x+2][y+1] = val/4;
            cgrid[x+2][y+1] = c;
          }
        }

        if (x <= 38)
        {
          if (y >=1) {
            grid[x+1][y-1] = val/3; 
            cgrid[x+1][y-1] = c;
          }
          if (y >=2) {
            grid[x+1][y-2] = val/4; 
            cgrid[x+1][y-2] = c;
          }
          grid[x+1][y] = val/2; 
          cgrid[x+1][y] = c;
          if (y <=37) {
            grid[x+1][y+2] = val/4; 
            cgrid[x+1][y+2] = c;
          }
          if (y <=38) {
            grid[x+1][y+1] = val/4; 
            cgrid[x+1][y+1] = c;
          }
        }
      }
      pulse = false;
      high = 0;
    }
    for (int i = 0; i < 40; i++) {
      for (int j = 0; j < 40; j++) {
        if (grid[i][j] > 0) {
          grid[i][j] -= grid[i][j]/50 + 1;
        }
        if (grid[i][j] < 0) {
          grid[i][j] = 0;
        }
      }
    }
  }
}

void S2Update() {
  int boxDim = (int)(screenWidth/20);
  stroke(#67FF5D);
  pushMatrix();
  translate(-boxDim * 10, screenHeight, 0);
  rotateX(0.5*PI);
  rotateX(-0.2);
  translate(-(boxDim/2), 0, 0);
  for (int i = 0; i < 40; i ++) {
    translate(0, -boxDim, 0);
    pushMatrix();
    for (int j = 0; j < 40; j++) {
      translate(boxDim, 0, 0);
      fill(cgrid[i][j]);
      box(boxDim, boxDim, grid[i][j] + 50);
    }
    popMatrix();
  }
  popMatrix();
}