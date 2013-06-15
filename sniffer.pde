import org.rsg.carnivore.net.*;
import org.rsg.carnivore.*;
import java.net.*;
CarnivoreP5 c;
ArrayList<Box> ips = new ArrayList<Box>();
ArrayList<Line> conn = new ArrayList<Line>();
int x, y, sx, sy, rx, ry;
int bsize = 45;
String host;
void setup(){
  smooth();
  size(1200, 900);
  background(255);
  //Log.setDebug(true); // Uncomment for verbose mode
  c = new CarnivoreP5(this); 
  //c.setVolumeLimit(4); //limit the output volume (optional)
  //c.setShouldSkipUDP(true); //tcp packets only (optional)
}

void draw(){
  background(255);
  println(conn.size());
  drawboxes();
  drawlines();
}
// Called each time a new packet arrives
void packetEvent(CarnivorePacket p){
  Boolean sender = true;
  Boolean receiver = true;
  for(int i = ips.size()-1; i >= 0; i--){
    if(ips.get(i).getIP().equals(p.receiverAddress.toString())){
      ips.get(i).revive();
      receiver=false;
    }
    if(ips.get(i).getIP().equals(p.senderAddress.toString())){
      ips.get(i).revive();
      sender=false;
    }
  }
  if(sender){
    try{
      host = InetAddress.getByName(p.senderAddress.toString()).getHostName();
    }
    catch (IOException e) {
      host = "";
    }
    ips.add(new Box(p.senderAddress.toString(), host));
  }
  if(receiver){
    try{
      host = InetAddress.getByName(p.receiverAddress.toString()).getHostName();
    }
    catch (IOException e) {
      host = "";
    }
    ips.add(new Box(p.receiverAddress.toString(), host));
  }
  Boolean newline = true;
  for(int i = conn.size()-1; i >= 0; i--){
    if(conn.get(i).getReceiver().equals(p.receiverAddress.toString()) && conn.get(i).getSender().equals(p.senderAddress.toString())){
      conn.get(i).revive();
      conn.get(i).incweight();
      newline = false;
    }
  }
  if(newline){
    conn.add(new Line(p.senderAddress.toString(), p.receiverAddress.toString()));  
  }
}
void drawboxes(){
  x = 0;
  y = 0;
  for(int i = ips.size()-1; i >= 0; i--){
    if(ips.get(i).getLife()>0){
      strokeWeight(1);
      stroke(0);
      fill(255);
      ips.get(i).setXY((x*2*bsize)+bsize/2,(y*3*bsize)+bsize/2);
      rect(x*2*bsize, y*3*bsize, bsize, bsize);
      fill(0);
      noStroke();
      text(ips.get(i).getIP()+"\n"+ips.get(i).getHost(),x*2*bsize,y*3*bsize+bsize, x+2*bsize, y+3*bsize);
      x++;
      if(x>=width/(2*bsize)){
        x=0;
        y++;
      }
    }
    else{
      ips.remove(i);
    }
  }
}
void drawlines(){
  for(int i = conn.size()-1; i >= 0; i--){
    if(conn.get(i).getLife()>0){
      for(int j = ips.size()-1; j >= 0; j--){
          if(conn.get(i).getSender().equals(ips.get(j).getIP())){
            sx = ips.get(j).getX();
            sy = ips.get(j).getY();
            println(sx+","+sy);
          }
          if(conn.get(i).getReceiver().equals(ips.get(j).getIP())){
            rx = ips.get(j).getX();
            ry = ips.get(j).getY();
            println(rx+","+ry);
          }
      }
      strokeWeight(2);
      stroke(conn.get(i).getWeight()+20,0,0);
      line(sx, sy, rx, ry);
    }
    else{
      conn.remove(i);
    }
  }
}
