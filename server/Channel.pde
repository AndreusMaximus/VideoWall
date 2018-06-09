public class channel
{
  private FloatList channelData;
  private int channelValue;
  public channel(int channelSize)
  {
    channelData = new FloatList();
   for(int i = 0; i < channelSize; i++)
   {
     channelData.append(0);
   }
   channelValue = 0;
  }
  
  public void addChannelData(float data)
  {
    channelData.remove(0);
    channelData.append(data);
  }
  
  public void drawChannel()
  {
    
    for(int i = 0; i < channelData.size() -1; i++)
    {
      stroke(25*i,100,100);
      strokeWeight(10);
      line(i * (screenWidth/channelData.size()),screenHeight - channelData.get(i), (i+1)*(screenWidth/channelData.size()), screenHeight - channelData.get(i+1));
      strokeWeight(1);
    }
    
  }
  
  public void drawChannel(int x, int numchan,int d)
  {
    float ret = 0;
    for(int i = 0; i < channelData.size() -1; i++)
    {
      ret += channelData.get(i);
    }
    ret /= channelData.size();
    ret = ret / (screenHeight/100);
    int r = (int)ret;
    channelValue = r;
   // println(r);
    if(r > 10){
       drawCube(1,x,color(0,255,0),numchan,d);
      
    } if(r >= 20){
       drawCube(2,x,color(25,225,0),numchan,d);
      
    } if(r >= 30){
       drawCube(3,x,color(50,200,0),numchan,d);
      
    } if(r >= 40){
       drawCube(4,x,color(75,175,0),numchan,d);
      
    } if(r >= 50){
       drawCube(5,x,color(100,150,0),numchan,d);
      
    } if(r >= 60){
       drawCube(6,x,color(125,125,0),numchan,d);
      
    } if(r >= 70){
       drawCube(7,x,color(150,100,0),numchan,d);
      
    } if(r >= 80){
       drawCube(8,x,color(175,75,0),numchan,d);
      
    } if(r >= 90){
       drawCube(9,x,color(200,50,0),numchan,d);
      
    } if(r >= 100){
       drawCube(10,x,color(225,25,0),numchan,d);
      
    }
  }
  
  private void drawCube(int i, int x, color c, int nc, int d)
  {
    fill(c);
    //rect(x,height - (i * (height/10)), d/nc, height/10);
    pushMatrix();
    translate(x ,screenHeight - (i * (screenHeight/10) - 120),0);
    box(d/nc,screenHeight/10,d/nc);
    popMatrix();
  }
  
  public int getChannelValue()
  {
    float ret = 0;
    for(int i = 0; i < channelData.size() -1; i++)
    {
      ret += channelData.get(i);
    }
    ret /= channelData.size();
    ret = ret / (screenHeight/100);
    int r = (int)ret;
    return r;
   //return this.channelValue; 
  }
}