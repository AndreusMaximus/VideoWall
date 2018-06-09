ArrayList<button> bList = new ArrayList<button>();

void setupStartMenu()
{
  bList.add(new button(50, 50, 100, 50, "Config", color(125, 125, 125)));
  bList.add(new button(50, 150, 100, 50, "Start", color(125, 125, 125)));
}

class button {
  private boolean pressed;
  private int _x;
  private int _y;
  private int _w;
  private int _h;
  private String _t;
  private color _c;
  private color _oc;


  public button(int x, int y, int w, int h, String t, color c)
  {
    this.pressed = false;
    this._x = x;
    this._y = y;
    this._w = w;
    this._h = h;
    this._t = t;
    this._c = c;
    this._oc = c;
  }

  public void drawButton()
  {
    fill(this._c);
    rect(_x, _y, _w, _h);
    fill(0);
    textAlign(CENTER, CENTER);
    text(this._t, this._x + (this._w/2), this._y + (this._h/2));
  }

  public void checkPressed()
  {
    if (mousePressed && mouseX > this._x && mouseX < this._x + this._w && mouseY > this._y && mouseY < this._y + this._h)
    {
      this.pressed = true;
      this._c = color(100, 100, 100);
    } else {
      this.pressed = false;
      this._c = this._oc;
    }
  }

  public boolean getPressed() {
    return this.pressed;
  }
}

void buttonUpdate()
{
  for (int i = 0; i < bList.size(); i++) {
    bList.get(i).checkPressed();
  }

  if (bList.get(1).getPressed()) {
    scene = 100;
  }
}