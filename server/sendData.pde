void S0SendData()
{
}

void S1SendData()
{
}

void S2SendData(int x, int y, int val, color c) {
}

void S3SendData() {
  String data = "s " + scene + " ";
  for (int i = 0; i < ap.size(); i++) {
    data += ap.get(i).getRawValue() + " ";
  }
  data += "\n";
  sendToClients(data);
}

void sendToClients(String d) {
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
}