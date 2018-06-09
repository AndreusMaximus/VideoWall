int visd = 0;
  int depth = 7030;
void S3Visualizer()
{
  background(0, 0, 0);
  channel ct;
  for (int i = 0; i < cl.size(); i ++) {
    ct = cl.get(i);
    for (int j = 0; j <  ap.size()/cl.size(); j++)
    {
      ct.addChannelData(ap.get(j+(i *(ap.size()/cl.size()) )).getOffValue(screenHeight,0));
    }
  }
  //println(cl.get(1).getChannelValue());
  pushMatrix();
  translate(screenx,screeny,0);
  rotateY((PI/2)- ch);
  for (int i = 0; i < cl.size(); i++) {
    ct = cl.get(i);
    ct.drawChannel(i*depth/cl.size(), cl.size(), depth);
  }
  popMatrix();
  pushMatrix();
  translate(screenWidth  + screenx, 0  + screeny, 0);
  rotateY((0.5*PI) + ch);
  for (int i = 0; i < cl.size(); i++) {
    ct = cl.get(i);
    ct.drawChannel(i*depth/cl.size(), cl.size(), depth);
  }
  popMatrix();
  pushMatrix();
  translate(0 + screenx, screenHeight  + screeny);
  rotateX(1.5*PI);
  stroke(255);
  strokeWeight(5);
  rotateX(PI);
  for (int i = 0; i < 8; i++) {
    fill(#02A7E0);
    rect(0, 0, (i+1)*(screenWidth/8), -depth);
    textSize(100);
    fill(255);
    translate(0, 0, 10);
    //text(i+1, (screenWidth/16 + screenWidth/8), -250); // check waarom de cijfers weer verneukt zijn
    translate(0, 0, -10);
  }
  strokeWeight(2);
  popMatrix();
  pushMatrix();
  translate(0 + screenx, 0   + screeny, -1000);
  S0JustLogoUpdate(depth);
  popMatrix();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  //println(depth);
  if(e > 0){
   visd += 10; 
  }
  if(e < 0){
   visd -= 10; 
  }
}