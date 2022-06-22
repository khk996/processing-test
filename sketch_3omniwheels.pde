/****************************
  R4知識メディア方法論課題1
  ・氏名:窪木　響大
  ・学生番号:2250002
 ****************************/
 //オムニ1の速度、角速度
 float vel1 = 0;
 float deg1 = 0;
 //オムニ2の速度、角速度
 float vel2 = 0;
 float deg2 = 0;
 //オムニ3の速度、角速度
 float vel3 = 0; 
 float deg3 = 0;
 void setup()
 {
  size(800, 600);
  rectMode(CENTER);
 }
 
 
 void draw()
 {
  background(255, 255, 255);
  translate(400, 300);
  
  //ウィンドウの中心からマウスの位置に矢印を描画する
  makepointer(0, 0, mouseX-400, mouseY-300);
  
  //各オムニの番号の描画
  fill(0, 0, 255);
  textSize(32);
  text("1", -50, -230);
  text("2", 105*sqrt(3) + 35, 105 - 25*sqrt(3));
  text("3", -105*sqrt(3) - 50, 105 - 25*sqrt(3));
  
  //各オムニの描画
  for(int i=0;i<3;i++)
  {
    if(i != 0)
      rotate(radians(120));
    
    strokeWeight(5);
    line(0, 0, 0, -200);
    strokeWeight(1);
    
    makeomniabove(0, -200, 100, 20);
    
    switch(i)
    {
      case 0:
        vel1 = mouseX - 400;
        makepointer(0, -200, vel1, -200);    
      break;
      case 1:
        vel2 = (mouseX - 400)/2 - (mouseY - 300)*sqrt(3)/2;
        makepointer(0, -200, -vel2, -200);
      break;
      case 2:
        vel3 = (mouseX - 400)/2 + (mouseY - 300)*sqrt(3)/2;
        makepointer(0, -200, -vel3, -200);
      break;
    }
  }
  rotate(radians(120));
  
  makeomniside(350, -250, 100, 100, vel1, 1);
  makeomniside(350, -150, 100, 100, -vel2, 2);
  makeomniside(350, -50, 100, 100, -vel3, 3);
  
 }
 
 //与えられた2点間に矢印を描画する関数
 int makepointer(float x0, float y0, float x1, float y1)
 {
  //中心からマウスの位置までの距離ベクトル
  float disX = 0;
  float disY = 0;
  float dis = 0;
  //上記の単位ベクトル
  float univecX = 0;
  float univecY = 0;
  //中心からマウスの位置までの線分を1;4に内分する点の座標
  float divX = 0;
  float divY = 0;
  //矢印を構成する三角形の二つの座標
  float X1 = 0;
  float Y1 = 0;
  float X2 = 0;
  float Y2 = 0;
 
  //始点から終点までの距離ベクトルを求める
  disX = x1 - x0; 
  disY = y1 - y0;
  dis = dist(x0, y0, x1, y1);
  
  //単位ベクトルを求める
  univecX = disX/dis;
  univecY = disY/dis;
  
  //内分点を求める
  divX = disX*4/5; 
  divY = disY*4/5;
  
  //矢印を構成する三角形の二つの座標を求める
  X1 = divX + -univecY*dis/10;
  Y1 = divY + univecX*dis/10;
  X2 = divX + univecY*dis/10;
  Y2 = divY + -univecX*dis/10;
  
  //始点から内分点までの線の描画
  stroke(255, 0, 0);
  line(x0, y0, divX+x0, divY+y0);
  stroke(0, 0, 0);
  
  //内分点から終点までの三角形の描画
  fill(255, 0, 0);
  triangle(x1, y1, X1+x0, Y1+y0, X2+x0, Y2+y0);
  fill(255, 255, 255);
  
  return 0;
 }
 
 //真上からみたオムニの描画
 int makeomniabove(int cenX, int cenY, int width, int height)
 { 
  fill(125, 125, 125);
  rect(cenX, cenY, width, height);
  fill(0, 0, 0);
  for(int i=0;i<5;i++)
    rect(-40 + i*20, -200, 10, 30);
  fill(255, 255, 255);
  
  return 0;
 }
 
 //真横から見たオムニの描画
 int makeomniside(int cenX, int cenY, int width, int height, float vel, int mode)
 {
   pushMatrix();
   translate(cenX, cenY);
   fill(125, 125, 0);
   text(mode, -80, 0);
   fill(255, 255, 255);
   rect(0, 0, width, height);
   fill(125, 125, 125);
   ellipse(0, 0, width-30, height-30);
   fill(255, 255, 255);
   
   switch(mode)
   {
     case 1:
       deg1 += radians(vel1);
       rotate(deg1*PI/180);
     break;
     case 2:
       deg2 += radians(vel2);
       rotate(deg2*PI/180);
     break;
     case 3:
       deg3 += radians(vel3);
       rotate(deg3*PI/180);
     break;
   }
   
   fill(0, 0, 0);
   for(int i=0;i<16;i++)
   {
     rotate(radians(i*22.5));
     rect(0, -35, 5, 10);
   }
   fill(255, 255, 255);
   
   popMatrix();
   return 0;
 }
