//Created by Yehan De Silva
//This is a capture the flag game made using processing

//These integer values could be changed to modify aspects of the game
int dimension = 35; //Size of players and flag
int speed = 9; //Speed of the players
int fps = 60; //The fps of the game
int respawnDelay = 3; //Respawn delay after being killed
int textBlink = 1000; //Allows for text to blink in later if/else statment
int gameScreen = 0;
int gameWin = 10;

int XPlayer1 = 312; //Variables to store coordinate values of objects
int XPlayer2 = 1073;
int YPlayers = 393;
int XFlag1 = 43;
int XFlag2 = 1342;
int YFlags = 393;
int XScore1 = 100;
int XScore2 = 1320;
int YScores = 100;

int time, time2;
int now = millis();
int player;

int score1 = 0; //Keeps track of score
int score2 = 0;
int kill1 = 0; //Keeps track of kills
int kill2 = 0;
int flagCarry1 = 0; //Keeps track of amount of times flag is carried
int flagCarry2 = 0;
int cross1 = 0; //Keeps track of amount of times the middle line is crossed
int cross2 = 0;

boolean cont = false; //Helps to kill and revive players and help keep track of counter variables
boolean cont2 = false;
boolean revive = false;
boolean revive2 = false;
boolean firstCapture1 = true;
boolean firstCapture2 = true;
boolean firstCross1 = true;
boolean firstCross2 = true;

color red = color(255, 20, 20); //Defining colors used later in the program
color blue = color(35, 180, 255);
color black = 0;
color white = 255;
color gray = 167;
color darkRed = color(255, 87, 34);
color darkBlue = color(103, 58, 183);

Player p1, p2, winner; //Declaring two players and flags
Flag f1, f2;

void setup () { //Starting up the game
 
  size(1420, 820);
  frameRate(fps);
  
  p1 = new Player(XPlayer1, YPlayers, dimension, 1); //Initializing the two players and flags
  p2 = new Player(XPlayer2, YPlayers, dimension, 2);
  f1 = new Flag(XFlag1, YFlags, blue);
  f2 = new Flag(XFlag2, YFlags, red);
  
}

void draw () {
  
  if (gameScreen == 1) { //Main game screen
    
  PFont zHour = createFont("zHour.ttf", 36); //Creating a new font in the sketch's data directory
  
  textFont(zHour);
  background(black);
  stroke(black);
  strokeWeight(4);
  
  createMap(); //Method for creating the game map
  createBarriers(); //Method for creating the barries at the middle of the map
  
  p1.safety(); //Assigns immortality to players based on where they lie on the map
  p2.safety();
  p1.playerCollide(p2); //Checks if the two players collide
  flagCollide(p2, f1); //Checks if the player takes the oppoents flag
  flagCollide(p1, f2);
  
  f1.capture(); //Changes the color of the flag if it is captured and increments the flagCarry variable
  f2.capture();
  f1.display(); //Displays the flags on the screen
  f2.display();
  
  p1.carryFlag(); //Changes the color of the player if they are carrying the enemy flag
  p2.carryFlag();
  p1.move(); //Moves the two players
  p2.move();
  p1.display(); //Displays the players on the screen
  p2.display();
  
  checkWin(); //Checks if there is a winner
  
  flagReturned(p1, f1, f2); //Checks if the player has taken and retured the enemy flag to score
  flagReturned(p2, f2, f1);
  
  fill(black);
  textAlign(LEFT);
  text(score1, XScore1, YScores); //Displays the score of the first player on the left side of the screen
  textAlign(RIGHT);
  text(score2, XScore2, YScores); //Displays the score of the second player on the right side of the screen
  
  if (p1.dead == true && cont == true) { //First if statment kills player, and second revives player after a given time
    
    p1.kill();
    cont = false;
    time = millis();
    revive = true;
    f2.captured = false;
    firstCapture1 = true;
    
  }
  
  if (revive == true) {
   
    if (millis() >= respawnDelay * 1000 + time) { //Checks if the time right now is greater than the respawn delay added to the time when player was killed
    
      p1.respawn();
      revive = false;
      
    }
    
  }
    
  if (p2.dead == true && cont2 == true) {
    
    p2.kill();
    cont2 = false;
    time2 = millis();
    revive2 = true;
    f1.captured = false;
    firstCapture2 = true;
    
  }
  
  if (revive2 == true) {
   
    if (millis() >= respawnDelay * 1000 + time2) {
    
      p2.respawn();
      revive2 = false;
      
    }
    
  }
  
  }
  
 else if (gameScreen == 0) { //Intro screen 
  
  PImage logo = loadImage("flagLogo.png"); //Initializing images and fonts
  PImage arrowKeys = loadImage("arrowKeys.png");
  PImage wasdKeys = loadImage("wasdKeys.png"); 
  PFont audioWide = createFont("audioWide.ttf", 36); 
  
  background(white);
  fill(black);
  rect(10, 10, 1400, 800);
  fill(white);
  rect(20, 100, 1380, 200);

  textFont(audioWide); //Displaying text and images
  textAlign(LEFT);
  textSize(72);
  fill(red);
  strokeWeight(8);
  text("CAPTURE  THE  FLAG", 100, 200);
  fill(blue);
  textSize(32);
  text("Created by Yehan De Silva", 500, 250);
  image(logo, 1000, 105 , 270, 190);
  
  image(wasdKeys, 100, 325);
  image(arrowKeys, 100, 575);
  textSize(24);
  text("Player 2 \nControls", 450, 650);
  fill(red);
  text("Player 1 \nControls", 450, 400);
  
  fill(white);
  textSize(18);
  text("Capture the opponent’s flag and return it to your base to score.", 700, 400);
  text("Score 10 times to win the match.", 700, 450);
  text("Player 1 can move using the W, A, S and D keys.", 700, 500);
  text("Player 2 can move using the Up, Left, Down and Right keys.", 700, 550);
  text("If you cross the middle, the opponent player can tag and kill you.", 700, 600);
  
  textSize(36);
  
  if (millis() - now > textBlink) { //Blinks the text
    
    fill(black);
    now = millis();
    
  }
  
  else {
    
    fill(white);
    
  }
  
  text("CLICK TO START", 850, 700);
  
 }
 
 else { //Final game screen , if their is a winner
   
   PFont audioWide = createFont("audioWide.ttf", 36); 
   
   background(black);
   stroke(black);
   createMap();
   textAlign(CENTER);
   textSize(60);
   fill(white);
   textFont(audioWide);
   
   rect(500, 80, 400, 100);
   
   if (winner == p1)
     player = 1;
   
   else
     player = 2;
     
   fill(black);
   text("Player " + player + " Wins!", 710, 150); //Displaying who won
   
   textSize(32); //Displaying the different info of each player
   textAlign(LEFT);
   text("Points: " + score1, 210, 400);
   text("Kills: " + kill1, 210, 450);
   text("Deaths: " + kill2, 210, 500);
   text("Flag Carries: " + flagCarry1, 210, 550);
   text("Border Crosses: " + cross1, 210, 600);
   
   textAlign(RIGHT);
   text(score2 + " :Points", 1210, 400);
   text(kill2 + " :Kills", 1210, 450);
   text(kill1 + " :Deaths", 1210, 500);
   text(flagCarry2 + " :Flag Carries", 1210, 550);
   text(cross2 + " :Border Crosses", 1210, 600);
   
   if (millis() - now > textBlink) {
    
    fill(black);
    now = millis();
    
  }
  
  else {
    
    fill(white);
    
  }
  
   textAlign(CENTER);
   textSize(48);
   text("CLICK TO PLAY AGAIN!", 710, 750);
   
 }
   
}

void createMap () { //Method to create the map, half red other half blue
  
  fill(red);
  rect(10, 10, 700, 800);
  fill(blue);
  rect(710, 10, 700, 800);
  
}

void createBarriers () { //Method to create barriers and bases
  
  fill(black);
  rect(680, 180, 60, 145); //Making center black barriers
  rect(680, 470, 60, 145);
  
  fill(white);
  rect(10, 360, 100, 100); //Making white bases
  rect(1310, 360, 100, 100);
  
}

void flagCollide(Player pl, Flag f) {
  
  if (pl.p == 2) { //Checks if second player takes first flag
    
    if (f.x + dimension > pl.x) {
      
      if (f.y < pl.y + dimension && f.y + dimension > pl.y) {
        
        f.captured = true;
        pl.hasFlag = true;
        
      }
        
    }
      
  }  
  
  else { //Checks if first player takes second flag
  
    if (pl.x + dimension > f.x) {
      
      if (f.y < pl.y + dimension && f.y + dimension > pl.y) {
        
        f.captured = true;
        pl.hasFlag = true;
        
      }
      
     }
  
  }
  
}

void flagReturned (Player pl, Flag homeF, Flag enemyF) { //Method that checks if the player has scored by returning the enemy flag
  
  if (pl.p == 1 && pl.hasFlag == true) { //For the first player
    
    if (homeF.x + dimension > pl.x) {
      
      if (homeF.y < pl.y + dimension && homeF.y + dimension > pl.y) {
        
        score1++; //Player1's score increments
        pl.hasFlag = false;
        enemyF.captured = false;
        p1.kill(); //Kills both players to restart battle
        p2.kill();
        cont = true;
        cont2 = true;
        
      }
      
    }
    
  }
  
  else if (pl.p == 2 && pl.hasFlag == true) { //For the second player
    
    if (pl.x + dimension > homeF.x) {
      
      if (homeF.y < pl.y + dimension && homeF.y + dimension > pl.y) {
        
        score2++;
        pl.hasFlag = false;
        enemyF.captured = false;
        p1.kill();
        p2.kill();
        cont = true;
        cont2 = true;
        
      }
    
  }
  
}

}

void checkWin () { //Determines if there is a winner and who it is
  
 if (score1 >= gameWin) {
   
   gameScreen = 2;
   winner = p1;
   
 }
 
 else if (score2 >= gameWin) {
   
  gameScreen = 2;
  winner = p2;
   
 }
  
}

void keyPressed () { //Runs if a key is pressed down
  
  p1.control1(keyCode, true); //Controls for player1
  p2.control2(keyCode, true); //Controls for player2
  
}
 
void keyReleased () { //Runs if a key is released
  
  p1.control1(keyCode, false);
  p2.control2(keyCode, false);
  
}

void mousePressed () { //Starts game when mouse is pressed
  
  if (gameScreen == 0) { //Starts the game
    
  gameScreen = 1;
  
  p1.kill();
  p2.kill();
  cont = true;
  cont2 = true;
  
  }
  
  if (gameScreen == 2) { //Restarts the game and the different counters
    
    gameScreen = 1;
    score1 = 0; 
    score2 = 0;
    kill1 = 0; 
    kill2 = 0;
    flagCarry1 = 0; 
    flagCarry2 = 0;
    cross1 = 0; 
    cross2 = 0;
    p1.kill();
    p2.kill();
    cont = true;
    cont2 = true;
    
  }

}
