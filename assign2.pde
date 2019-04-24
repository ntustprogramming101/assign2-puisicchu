PImage imgBg, imgLife1, imgLife2, imgLife3, imgSoil, imgSoldier;
PImage imgGroundhogIdle, imgCabbage;
PImage imgStart, imgGameOver, imgStartNormal, imgStartHovered;
PImage imgRestartNormal, imgRestartHovered;
PImage imgGroundhogDown, imgGroundhogLeft, imgGroundhogRight;

int soldierX, soldierY;
int cabbageX, cabbageY;
int groundhogX, groundhogY, groundhogSpeed;

final int squareUnit=80;
final int buttonX= 248;
final int buttonY= 360;

int initialLife=2;
int score=1;

// movment
boolean downPressed=false;
boolean leftPressed=false;
boolean rightPressed=false;


// game state
final int GAME_START=0;
final int GAME_RUN=1;
final int GAME_OVER=2;
int gameState=GAME_START;

boolean groundhogIdle=true;

void setup() {
  size(640, 480, P2D);
  // image
  imgBg= loadImage("img/bg.jpg");
  imgLife1= loadImage("img/life.png");
  imgLife2= loadImage("img/life.png");
  imgLife3= loadImage("img/life.png");
  imgSoil= loadImage("img/soil.png");
  imgSoldier= loadImage("img/soldier.png");
    imgGroundhogIdle= loadImage("img/groundhogIdle.png");
  imgCabbage= loadImage("img/cabbage.png");
  imgStart= loadImage("img/title.jpg");
  imgGameOver= loadImage("img/gameover.jpg");
  imgStartNormal= loadImage("img/startNormal.png");
  imgStartHovered= loadImage("img/startHovered.png");
  imgRestartNormal= loadImage("img/restartNormal.png");
  imgRestartHovered= loadImage("img/restartHovered.png");
  imgGroundhogDown= loadImage("img/groundhogDown.png");
  imgGroundhogLeft= loadImage("img/groundhogLeft.png");
  imgGroundhogRight= loadImage("img/groundhogRight.png");

  // soldier movement
  soldierX =-squareUnit;
  soldierY =squareUnit*floor(random(2,6));
  
  // cabbage appearance
  cabbageX =squareUnit*floor(random(0,6));
  cabbageY =squareUnit*floor(random(2,6));
  
  //groundhog initial position
  groundhogX=squareUnit*4;
  groundhogY=squareUnit;
  groundhogSpeed+=80/16; 

}


void draw() {
  switch(gameState){
    
    case GAME_START:
    
      image(imgStart,0,0);
      if(mouseX>buttonX && mouseX<buttonX+144 
      && mouseY>buttonY && mouseY<buttonY+60 ){
        image(imgStartHovered,buttonX,buttonY);
        if(mousePressed){
         gameState=GAME_RUN; 
        }
      }else{
        image(imgStartNormal,buttonX,buttonY);
      }
      break;
    
    case GAME_RUN:
    
    // image
    image(imgBg,0,0);
    image(imgSoil,0,160);
    image(imgSoldier,soldierX,soldierY);
    image(imgCabbage,cabbageX,cabbageY);
    
    // lawn
    noStroke();
    colorMode(RGB);
    fill(124,204,25);  
    rect(0,145,640,15);
    
    // sun
    stroke(255,255,0);  
    strokeWeight(5);
    fill(253,184,19);  
    ellipse(590,50,120,120);
    
    // life score
    if(initialLife==0){
      gameState=GAME_OVER;
    }
    if(initialLife==1){
      image(imgLife1,10,10);
    }
    if(initialLife==2){
      image(imgLife1,10,10);
      image(imgLife2,80,10);
    }
    if(initialLife==3){
      image(imgLife1,10,10);
      image(imgLife2,80,10);
      image(imgLife3,150,10);
    }
    
    // Grounghog movement
    if(groundhogIdle){
      image(imgGroundhogIdle,groundhogX,groundhogY);
    }
    
    if(downPressed){
      groundhogIdle=false;
      image(imgGroundhogDown,groundhogX,groundhogY);
      leftPressed= false;
      rightPressed= false;
      groundhogY+=groundhogSpeed;
      if(groundhogY%80==0){
        downPressed= false;
        groundhogIdle=true;
        }
    }
    if(leftPressed){
      groundhogIdle=false;
      image(imgGroundhogLeft,groundhogX,groundhogY);
      downPressed= false;
      rightPressed= false;
      groundhogX-=groundhogSpeed;
      if(groundhogX%80==0){
        leftPressed= false;
        groundhogIdle=true;
        }
    }
    if(rightPressed){
      groundhogIdle=false;
      image(imgGroundhogRight,groundhogX,groundhogY);
      leftPressed= false;
      downPressed= false;
      groundhogX+=groundhogSpeed;
      if(groundhogX%80==0){
        rightPressed= false;
        groundhogIdle=true;
        }
    }
    
    // boundary detection
    if(groundhogX<0){
      leftPressed= false;
      groundhogIdle=true;
      groundhogX=0;
    }  
    if(groundhogX>width-squareUnit){
      rightPressed= false;
      groundhogIdle=true;
      groundhogX=width-squareUnit;
    }
    if(groundhogY>height-squareUnit){
      downPressed= false;
      groundhogIdle=true;
      groundhogY=height-squareUnit;
    }
    
    // grounghog eat cabbage
    if(groundhogX<cabbageX+squareUnit && groundhogX+squareUnit>cabbageX
      && groundhogY<cabbageY+squareUnit && groundhogY+squareUnit>cabbageY){
      cabbageX= width+squareUnit;
      cabbageY= height+squareUnit;
     initialLife+=score;
     }
    
    // soldier movement
    soldierX+=4;
    if(soldierX>=width){
     soldierX=-squareUnit; 
    }
    
    // soldier catch groundhog
    if(groundhogX<soldierX+squareUnit && groundhogX+squareUnit>soldierX
    && groundhogY<soldierY+squareUnit && groundhogY+squareUnit>soldierY){
      groundhogIdle=true;
      groundhogX=squareUnit*4;
      groundhogY=squareUnit;
      downPressed= false;
      leftPressed= false;
      rightPressed= false;
      initialLife-=score;
     }
    
   break;
   
   case GAME_OVER:
   image(imgGameOver,0,0);
   if(mouseX>buttonX && mouseX<buttonX+144 
      && mouseY>buttonY && mouseY<buttonY+60 ){
        image(imgRestartHovered,buttonX,buttonY);
        if(mousePressed){
         gameState=GAME_RUN;
         initialLife=2;
         
         // soldier move
        soldierX =-squareUnit;
        soldierY =squareUnit*floor(random(2,6));
  
        // cabbage move
        cabbageX =squareUnit*floor(random(0,6));
        cabbageY =squareUnit*floor(random(2,6));
        }
      }else{
        image(imgRestartNormal,buttonX,buttonY);
      }
   break;
 
  } // switch
  
} // draw

 

void keyPressed(){
   if (key == CODED) {
    switch (keyCode) {
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}
