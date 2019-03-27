PImage bgImg, soilImg, lifeImg, groundhogIdleImg, robotImg, soldierImg, 
groundhogDownImg, groundhogLeftImg, groundhogRightImg,
cabbageImg, titleImg, startNormalImg,startHoveredImg;

float groundhogIdleX=320;
float groundhogIdleY=80;
float groundhogSpeed=3;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

float soldierX=-80;
float soldierY=80+80*floor(random(4)+1);
float speedSoldierX=3;
float cabbageX = 80*(floor(random(8)));
float cabbageY = 80+80*floor(random(4)+1);

int gameState;
final int GAME_START=1;
final int GAME_RUN=2;
final int GAME_OVER=3;


void setup() {
	size(640, 480, P2D);
	bgImg = loadImage("img/bg.jpg");
soilImg = loadImage("img/soil.png");
lifeImg = loadImage("img/life.png");
groundhogIdleImg = loadImage("img/groundhogIdle.png");
robotImg = loadImage("img/robot.png");
soldierImg = loadImage("img/soldier.png");
groundhogDownImg = loadImage("img/groundhogDown.png");
groundhogLeftImg = loadImage("img/groundhogLeft.png");
groundhogRightImg = loadImage("img/groundhogRight.png");
cabbageImg = loadImage("img/cabbage.png");
titleImg= loadImage("img/title.jpg");
startNormalImg=loadImage("img/startNormal.png");
startHoveredImg=loadImage("img/startHovered.png");

gameState=GAME_START;}

void draw() {
		// Game Start
//title
image(titleImg,0,0);

//button
image(startNormalImg,248,360);

// Switch Game State
switch(gameState){
case GAME_START:
if(248<mouseX&&mouseX<392|360<mouseY&&mouseY<420)
{if(mousePressed){gameState=GAME_RUN;}
else{image(startHoveredImg,248,360);
}
}
   
   case GAME_RUN:
   // Game Run
// background
  image(bgImg,0,0);
 
 //soil
 image(soilImg,0,160);
 
 //life
 image(lifeImg,10,10);
 image(lifeImg,80,10);
 
 // grass
 noStroke();
 fill(124, 204, 25);
 rect(0,145,640,15);
 
 // cabbage
 image(cabbageImg,cabbageX,cabbageY);
 
 // groundhog movement
 if(downPressed){
 image(groundhogDownImg, groundhogIdleX, groundhogIdleY);
   groundhogIdleY+=groundhogSpeed;  
 }
 else if(leftPressed){
   image(groundhogLeftImg, groundhogIdleX, groundhogIdleY);
   groundhogIdleX-=groundhogSpeed;
 }
 else if(rightPressed){
   image(groundhogRightImg, groundhogIdleX, groundhogIdleY);
   groundhogIdleX+=groundhogSpeed;
 }
 else{
   image(groundhogIdleImg,groundhogIdleX,groundhogIdleY);
 };

//collision of groundhog and soldier
if(soldierX<groundhogIdleX && groundhogIdleX<soldierX+80 &&soldierY<groundhogIdleY && groundhogIdleY<soldierY+80)
{groundhogIdleX=320;
groundhogIdleY=80;}

//eating cabbage
if(cabbageX<groundhogIdleX && groundhogIdleX<cabbageX+80 && cabbageY<groundhogIdleY && groundhogIdleY<cabbageY+80)
{cabbageX=-160;cabbageY=-160;
}
else{image(cabbageImg,cabbageX,cabbageY);}

 // boundary detection
   if(groundhogIdleX>width-80){
     groundhogIdleX=width-80;
   }
   if(groundhogIdleX<0){
     groundhogIdleX=0;
   }
   if(groundhogIdleY>height-80){
     groundhogIdleY=height-80;
   }
   
 //sun
 stroke(255, 255, 0);
 strokeWeight(5);
 fill(253, 184, 19);
 ellipse(590,50,120,120);
 
 //soldier animation
 image(soldierImg,soldierX,soldierY);
soldierX+=speedSoldierX;
soldierX%=640;}}

 // Game Over
 
 
void keyPressed(){
  if (key==CODED){
    switch(keyCode){
      case UP:
      upPressed=true;
      break;
      case DOWN:
      downPressed=true;
      break;
      case LEFT:
      leftPressed=true;
      break;
      case RIGHT:
      rightPressed=true;
      break;
    }
  }
}

void keyReleased(){
  if (key==CODED){
    switch(keyCode){
      case UP:
      upPressed=false;
      break;
      case DOWN:
      downPressed=false;
      break;
      case LEFT:
      leftPressed=false;
      break;
      case RIGHT:
      rightPressed=false;
      break;
  }
  }
}
