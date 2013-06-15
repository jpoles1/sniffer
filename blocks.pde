class Box{
int x,y,life;
String ip;
String host = "";
int lifetime = 1000;
  Box(String thisip, String ho){
    x=0;
    y=0;
    ip = thisip;
    host = ho;
    life = lifetime;
  }
  void revive(){
    life = lifetime; 
  }
  String getIP(){
    return ip; 
  }
  int getLife(){
    life--;
    return life; 
  }
  int getX(){
    return x; 
  }
  int getY(){
    return y; 
  }
  String getHost(){
    return host; 
  }
  void setXY(int newx, int newy){
    x=newx;
    y=newy;
  }
}
