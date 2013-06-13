class Box{
int x,y,life;
String ip;
int lifetime = 1000;
  Box(String thisip){
    x=0;
    y=0;
    ip = thisip;
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
    return Y; 
  }
  void setX(int newx){
    x=newx;
  }
  void setY(int newy){
    x=newy;
  }
}
