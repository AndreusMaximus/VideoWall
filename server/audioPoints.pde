public class audioPoint {
  int s;
  int maxR;
  int minR;
  float value;
  FloatList fl;
  public audioPoint(int size, int maxr, int minr)
  {
    this.s = size;
    this.maxR = maxr;
    this.minR = minr;
    value = 0; 
    fl=new FloatList();
    for(int i = 0; i < this.s; i++){
    fl.append(0);
    }
  }

  public void setvalue(float val)
  {
    fl.append(val);
    fl.remove(0);
  }
  
  public float getRawValue()
  {
    return fl.get(0);
  }

  public float getValue() {
    float res = 0;
    for (int i = 0; i < this.s; i++){
     res += fl.get(i); 
    }
    res /= this.s;
   // println(res / (width/100));
    res = (maxR - minR) / 100 * (res / (screenWidth/100)) + minR;
    return res;
  }
  
  public float getOffValue(int max, int min)
  {
        float res = 0;
    for (int i = 0; i < this.s; i++){
     res += fl.get(i); 
    }
    res /= this.s;
   // println(res / (width/100));
    //res =( res / (height/100)) * max;
    //println("t"+res / (height/100) * ((max - min) / 100));
    res = res / (screenHeight/100) * ((max - min) / 100);
    res += min;
    //println(res);
    return res;
  }
}