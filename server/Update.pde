color fore = color(255, 102, 204);
color back = color(0, 0, 0);
void globalUpdate()
{
  sendMessage(0, 0, 0, 0);
  readMessage();
}

void sendMessage(int m1, int m2, int m3, int m4) {
  String d = "c " + scene + " ";
  d += m1 + " ";
  d += m2 + " ";
  d += m3 + " ";
  d += m4 + " ";
  if (server == true) {
    //background(back);
    stroke(fore);
    if (ps == null) return;
    float[] features = ps.getFeatures();
    if (features != null) {
      //scan across the pixels
      //  println(features.length);
      for (int i = 0; i < 256; i++) {
        int featureIndex = i * features.length / (screenWidth);
        int vOffset = Math.min((int)(features[featureIndex] * screenHeight), screenHeight );
        d += vOffset + " ";
        ap.get(i).setvalue((float)vOffset);
      }
      d += "\n";
    }
    s1.write(d);
    s2.write(d);
    s3.write(d);
    s4.write(d);
    s5.write(d);
    s6.write(d);
    s7.write(d);
    s8.write(d);
    s9.write(d);
    s10.write(d);
    s11.write(d);
    s12.write(d);

    id.setData(ap);
    sb.setData(ap);
  }
}

void readMessage() {
  if (server == false) {
    try {
      if (client.available() > 0) { 
        String input;
        int d[]; 
        int sv = 1;
        input = client.readString(); 
        input = input.substring(0, input.indexOf("\n"));  // Only up to the newline
        d = int(split(input, ' '));  // Split values into an array
        // Draw line using received coords
        if (input.indexOf('s') == 0 || input.indexOf('c') == 0) {
          scene = d[1];
          //print(scene);
          if (input.indexOf('c') == 0 && scene == 2) {
            int cx, cy, cval;
            color ccol;
            cx = d[2];
            cy = d[3];
            cval = d[4];
            ccol = d[5];
            sv = 6;
            sb.setValues(cx, cy, cval, ccol);
          }
          // println(d[6]);
          for (int i = sv; i < d.length-1; i ++) {
            //print(d[i] + " - ");
            ap.get(i - sv).setvalue((float)d[i]);
          }
          //println();
          id.setData(ap);
          sb.setData(ap);
        }
      }
      //id.detectMusicType();
    }
    catch(Throwable e) {
    }
  }
}