float rx=0.32,ry=-1.15;
float sc=0.010;
float multiplier=1.4;
float vsc = 0.18;
boolean CombinedOrMoved=false;

Integer[][] v = new Integer[4][4];
color[] colors= new color[12];
void setup() {
  size(900, 900, P3D);
  noFill();
  fill(255);
  strokeWeight(0.02);
  //strokeJoin(MITER);
  clearValues();
  colors[0]=color(10,10,10,10);
  colors[1]=color(180,40,0,120+2*30);
  colors[2]=color(140,60,10,120+2*30);
  colors[3]=color(90,130,10,120+2*30);
  colors[4]=color(50,215,50,120+2*30);
  colors[5]=color(20,130,90,120+2*30);
  colors[6]=color(145,30,160,120+2*30);
  colors[7]=color(145,180,10,120+3*30);
  colors[8]=color(90,200,10,120+3*30);
  colors[9]=color(5,150,200,120+3*30);
  colors[10]=color(10,100,180,120+3*30);
  colors[11]=color(0,0,0,255);

  //v[1][1]=2;
  //v[2][1]=2;
  //v[2][2]=4;
  //v[2][3]=3;
  //v[3][0]=5;
  //v[3][1]=5;
}

void draw(){
 
 background(90);
 translate(450,490,0);
 scale(70*multiplier);
 rotateY(rx);
 rotateX(-ry);
 for(int i=0; i<4; i++)
 for(int j=0; j<4; j++)
  {
    if(v[i][j]!=0)
    {
    translate((i-2),(j-2),0);
    translate(0,0,(v[i][j]-1)*vsc/2.0);
    fill(color(180,10,5,0));
    noFill();
    box(1,1,(v[i][j]-1)*vsc);
    translate(0,0,-(v[i][j]-1)*vsc/2.0);
    
    //fill(color(160+21*v[i][j],150,20,120+30*v[i][j]));
    fill(colors[v[i][j]]);
    translate(0,0,(v[i][j]-0.5)*vsc);
    box(1,1,vsc);
    translate(0,0,-(v[i][j]-0.5)*vsc);
    
    translate(-(i-2),-(j-2),0);
    }
    else
    {
    translate((i-2),(j-2),0);
    fill(color(120,120,120,250));
    box(1,1,0);
    translate(-(i-2),-(j-2),0);
    }
  }
}

void mouseDragged(){
float nrx = rx+sc*(mouseX-pmouseX);
float nry = ry+sc*(mouseY-pmouseY);
 if(nrx < PI/3 && nrx >-PI/3)
 rx=nrx;
 if(nry < PI/8 && nry >-3*PI/4)
 ry=nry;
}

void keyPressed(){
 if(key == 'r')
 {
   clearValues();
 }
 if(key == '1')
   addRandom2or4();
 if(key == 'q')
   multiplier*=1.09;
 if(key == 'a')
   multiplier/=1.09;

CombinedOrMoved=false;
  if(keyCode == LEFT)
  {
    for(int j=0; j<4; j++)
    {
     moveLeft(j,0);
     for(int i=0; i<3; i++)
     {
       if(v[i][j]==v[i+1][j] && v[i][j]!=0)
       {
         v[i][j]++;
         v[i+1][j]=0;
         CombinedOrMoved=true;
       }
       moveLeft(j,i);
     }
    }
  }
  
  if(keyCode == RIGHT)
  {
    for(int j=0; j<4; j++)
    {
     moveRight(j,3);    
     for(int i=3; i>0; i--)
     {
       if(v[i][j]==v[i-1][j] && v[i][j]!=0)
       {
         v[i][j]++;
         v[i-1][j]=0;
         CombinedOrMoved=true;
       }
       moveRight(j,i);
     }    
    }
  }
  
  if(keyCode == UP)
  {
    for(int i=0; i<4; i++)
    {
     moveUp(i,0);    
     
     for(int j=0; j<3; j++)
     {
       if(v[i][j]==v[i][j+1] && v[i][j]!=0)
       {
         v[i][j]++;
         v[i][j+1]=0;
         CombinedOrMoved=true;
       }
       moveUp(i,j);
     }
     
    }
  }
  
  if(keyCode == DOWN)
  {
    for(int i=0; i<4; i++)
    {
     moveDown(i,3);
     
     for(int j=3; j>0; j--)
     {
       if(v[i][j]==v[i][j-1] && v[i][j]!=0)
       {
         v[i][j]++;
         v[i][j-1]=0;
         CombinedOrMoved=true;
       }
       moveDown(i,j);
     }    
    
    }
  }

  if(CombinedOrMoved)
    addRandom2or4();
}

void moveLeft(int j,int start)
{
  int w=start;
  while(w!=3)
  {
    if(v[start][j]==0)
    {
      for(int k=start;k<3;k++)
      {
        v[k][j]=v[k+1][j];
        if(v[k][j]!=0)
          CombinedOrMoved=true;
      }
      v[3][j]=0;
      w++;
    }  
    else
    {w=3;}
  }
}

void moveRight(int j,int start)
{
  int w=start;
  while(w!=-1)
  {
    if(v[start][j]==0)
    {
      for(int k=start;k>0;k--)
      {
        v[k][j]=v[k-1][j];
        if(v[k][j]!=0)
          CombinedOrMoved=true;
      }
      v[0][j]=0;
      w--;
    }  
    else
    {w=-1;}
  }
}

void moveUp(int i,int start)
{
  int w=start;
  while(w!=3)
  {
    if(v[i][start]==0)
    {
      for(int k=start;k<3;k++)
      {
        v[i][k]=v[i][k+1];
        if(v[i][k]!=0)
          CombinedOrMoved=true;
      }
      v[i][3]=0;
      w++;
    }  
    else
    {w=3;}
  }
}


void moveDown(int i,int start)
{
  int w=start;
  while(w!=-1)
  {
    if(v[i][start]==0)
    {
      for(int k=start;k>0;k--)
      {
        v[i][k]=v[i][k-1];
        if(v[i][k]!=0)
          CombinedOrMoved=true;
      }
      v[i][0]=0;
      w--;
    }  
    else
    {w=-1;}
  }
  
  //if(v[i][3-0]==0)
  //{
  //  CombinedOrMoved=true;
  // v[i][3-0]=v[i][3-1];
  // v[i][3-1]=v[i][3-2];
  // v[i][3-2]=v[i][3-3];
  // v[i][3-3]=0;
  // if(v[i][3-0]==0)
  // {
  //  v[i][3-0]=v[i][3-1];
  //  v[i][3-1]=v[i][3-2];
  //  v[i][3-2]=0;
  //  if(v[i][3-0]==0)
  //  {
  //   v[i][3-0]=v[i][3-1];
  //   v[i][3-1]=0;
  //  }
  // }
  //}
}

void addRandom2or4()
{
  int newValue=0;
  float r = random(1.0);
  if(r<0.9)
  {
    newValue=1;
  }
  else
  {
    newValue=2;
  }
  
  int index=-1;
  int n = numberOfEmpties();
  r = random(n+1);
  for(int w=0; w<n+1; w++)
    if(r>w)
    {
      index++;
    }
  for(int i=0; i<4; i++)
    for(int j=0; j<4; j++)
    {
     if(v[i][j]==0)
     {
       index--;
       if(index == 0)
       {
         v[i][j]=newValue;
         return;
       }
     }
    }

}

int numberOfEmpties()
{
  int n=0;
  for(int i=0; i<4; i++)
    for(int j=0; j<4; j++)
      if(v[i][j]==0)
        n++;
  return n;
}

void clearValues()
{
  for(int i=0; i<4; i++)
  for(int j=0; j<4; j++)
  {
    v[i][j]=0;
  }
    addRandom2or4();
  addRandom2or4();

}
