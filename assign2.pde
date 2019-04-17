PImage imgBg, imgLife1, imgLife2, imgLife3, imgSoil, imgSoldier;
PImage imgGroundhogIdle, imgCabbage;
PImage imgStart, imgGameOver, imgStartNormal, imgStartHovered;
PImage imgRestartNormal, imgRestartHovered;
PImage imgGroundhogDown, imgGroundhogLeft, imgGroundhogRight;

int soldierX, soldierY;
int cabbageX, cabbageY;
int groundhogX, groundhogY, groundhogSpeed;

final int SQUARE_UNIT=80;
final int BUTTON_X= 248;
final int BUTTON_Y= 360;

int totalLife=2;
int score=1;

// moving
boolean downPressed=false;
boolean leftPressed=false;
boolean rightPressed=false;


// game
final int GAME_START=0;
final int GAME_RUN=1;
final int GAME_OVER=2;
int gameState=GAME_START;

// grounghog image
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
  soldierX =-SQUARE_UNIT;
  soldierY =SQUARE_UNIT*floor(random(2,6));
  
  // cabbage appearance
  cabbageX =SQUARE_UNIT*floor(random(0,6));
  cabbageY =SQUARE_UNIT*floor(random(2,6));
  
  //groundhog
  groundhogX=SQUARE_UNIT*4;
  groundhogY=SQUARE_UNIT;
  groundhogSpeed+=80/16; 

}


void draw() {
  switch(gameState){
    
    case GAME_START:
    
      image(imgStart,0,0);
      if(mouseX>BUTTON_X && mouseX<BUTTON_X+144 
      && mouseY>BUTTON_Y && mouseY<BUTTON_Y+60 ){
        image(imgStartHovered,BUTTON_X,BUTTON_Y);
        if(mousePressed){
         gameState=GAME_RUN; 
        }
      }else{
        image(imgStartNormal,BUTTON_X,BUTTON_Y);
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
    if(totalLife==0){
      gameState=GAME_OVER;
    }
    if(totalLife==1){
      image(imgLife1,10,10);
    }
    if(totalLife==2){
      image(imgLife1,10,10);
      image(imgLife2,80,10);
    }
    if(totalLife==3){
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
    
    // Grounghog boundary detection
    if(groundhogX<0){
      leftPressed= false;
      groundhogIdle=true;
      groundhogX=0;
    }
    if(groundhogX>width-SQUARE_UNIT){
      rightPressed= false;
      groundhogIdle=true;
      groundhogX=width-SQUARE_UNIT;
    }
    if(groundhogY>height-SQUARE_UNIT){
      downPressed= false;
      groundhogIdle=true;
      groundhogY=height-SQUARE_UNIT;
    }
    
    // grounghog eat cabbage
    if(groundhogX<cabbageX+SQUARE_UNIT && groundhogX+SQUARE_UNIT>cabbageX
      && groundhogY<cabbageY+SQUARE_UNIT && groundhogY+SQUARE_UNIT>cabbageY){
      cabbageX= width+SQUARE_UNIT;
      cabbageY= height+SQUARE_UNIT;
      totalLife+=score;
     }
    
    // soldier movement
    soldierX+=4;
    if(soldierX>=width){
     soldierX=-SQUARE_UNIT; 
    }
    
    // soldier touch groundhog
    if(groundhogX<soldierX+SQUARE_UNIT && groundhogX+SQUARE_UNIT>soldierX
    && groundhogY<soldierY+SQUARE_UNIT && groundhogY+SQUARE_UNIT>soldierY){
      groundhogIdle=true;
      groundhogX=SQUARE_UNIT*4;
      groundhogY=SQUARE_UNIT;
      downPressed= false;
      leftPressed= false;
      rightPressed= false;
      totalLife-=score;
     }
    
   break;
   
   case GAME_OVER:
   image(imgGameOver,0,0);
   if(mouseX>BUTTON_X && mouseX<BUTTON_X+144 
      && mouseY>BUTTON_Y && mouseY<BUTTON_Y+60 ){
        image(imgRestartHovered,BUTTON_X,BUTTON_Y);
        if(mousePressed){
         gameState=GAME_RUN;
         totalLife=2;
         
         // soldier move
        soldierX =-SQUARE_UNIT;
        soldierY =SQUARE_UNIT*floor(random(2,6));
  
        // cabbage move
        cabbageX =SQUARE_UNIT*floor(random(0,6));
        cabbageY =SQUARE_UNIT*floor(random(2,6));
        }
      }else{
        image(imgRestartNormal,BUTTON_X,BUTTON_Y);
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
