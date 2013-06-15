class Line{
 String rip, sip;
 int life, weight; 
 int mult = 3;
 int lifetime = 200;
 int c = 255;
 Line(String sender, String receiver){
  rip = receiver; 
  sip = sender;
  weight=1;
 }
 String getSender(){
   return sip;
 }
 String getReceiver(){
   return rip;
 }
 int getLife(){
  life--;
  return life; 
 }
 int getWeight(){
  return weight*mult; 
 }
 void revive(){
  life=lifetime; 
 }
 void incweight(){
   weight++;
 }
}
