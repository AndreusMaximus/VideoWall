public class identifier{
 private ArrayList<audioPoint> apl;
 private ArrayList<channel> cl;
  public identifier(ArrayList<audioPoint> data, int aoChannels)
  {
    this.apl = data;
    this.cl = new ArrayList<channel>();
    for(int i = 0; i < aoChannels; i++){
      cl.add(new channel(width/10));
    }
  }
  
  public void setData(ArrayList<audioPoint> data)
  {
    //print("got 'ere");
    this.apl = data;
    //println(apl.size()/cl.size());
    for(int i = 0; i < cl.size(); i++){
     cl.get(i).addChannelData(this.apl.get(i*(apl.size() / cl.size())).getOffValue(screenHeight,0)); 
    // cl.get(i).drawChannel();
    }
    
    // cl.get(1).addChannelData(this.apl.get(1*(apl.size() / cl.size())).getOffValue(height,0)); 
    // cl.get(1).drawChannel();
  }
  
  public void showData()
  {
    
  }
  
  public void detectMusicType()
  {
    highBPM();
    hardMusic();
    softMusic();
    vocals();
    agressive();
    mostlyHigh();
    mostlyLow();
    
  }
  
  private void highBPM()
  {
    
  }
  
  private void hardMusic()
  {
    
  }
  
  private void softMusic()
  {
    
  }
  
  private void vocals()
  {
    
  }
  
  private void agressive()
  {
    
  }
  
  private void mostlyHigh()
  {
    
  }
  
  private void mostlyLow()
  {
    
  }
}