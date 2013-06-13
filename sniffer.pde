import org.rsg.carnivore.net.*;
import org.rsg.carnivore.*;
CarnivoreP5 c;
ArrayList<String> ips = new ArrayList<String>();
ArrayList<Integer> lifes = new ArrayList<Integer>();
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
  x = 0;
  y = 0;
  for(int i = ips.size()-1; i >= 0; i--){
    if(lifes.get(i)>0){
      stroke(0);
      fill(255);
      rect(x*2*bsize, y*2*bsize, bsize, bsize);
      fill(0);
      noStroke();
      text(ips.get(i),x*2*bsize,y*2*bsize+bsize+20);
      x++;
      if(x>=width/(2*bsize)){
        x=0;
        y++;
      }
      lifes.set(i, lifes.get(i)-1);
    }
    else{
      lifes.remove(i);
      ips.remove(i);
    }
  }
}
// Called each time a new packet arrives
void packetEvent(CarnivorePacket p){
  if(!ips.contains(p.receiverAddress.toString())){
    ips.add(p.receiverAddress.toString());
    lifes.add(1000);
  }
  if(!ips.contains(p.senderAddress.toString())){
    ips.add(p.senderAddress.toString());
    lifes.add(1000);
  }
}
