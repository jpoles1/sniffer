import org.rsg.carnivore.net.*;
import org.rsg.carnivore.*;
CarnivoreP5 c;
ArrayList<Box> ips = new ArrayList<Box>();
int x,y;

int bsize = 50;
void setup(){
  smooth();
  size(800, 800);
  background(255);
  //Log.setDebug(true); // Uncomment for verbose mode
  c = new CarnivoreP5(this); 
  //c.setVolumeLimit(4); //limit the output volume (optional)
  //c.setShouldSkipUDP(true); //tcp packets only (optional)
}

void draw(){
  background(255);
  println(ips.size());
  x = 0;
  y = 0;
  for(int i = ips.size()-1; i >= 0; i--){
    if(ips.get(i).getLife()>0){
      stroke(0);
      fill(255);
       rect(x*2*bsize, y*2*bsize, bsize, bsize);
      fill(0);
      noStroke();
      text(ips.get(i).getIP(),x*2*bsize,y*2*bsize+bsize+20);
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
    ips.add(new Box(p.senderAddress.toString()));
  }
  if(receiver){
    ips.add(new Box(p.receiverAddress.toString()));
  }
}
