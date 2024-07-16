class Player { //Class for a player
  
 int x, y, d, p; //Coordinates, size
 int rightInt, leftInt, upInt, downInt; //Integers for movement of the player
 int border = 0; //Border of the player (Changes if the player dies)
 
 boolean up, down, left, right; //Boolean for the movement of the player
 boolean dead = false; //Boolean to state if the player is alive
 boolean safe = true; //Boolean to check if the player is safe
 boolean hasFlag = false; //Boolean to state if the player has captured the enemy flag
 
 color c; //Color of the player
 
 Player (int xx, int yy, int dd, int pp) { //Constructor method for creating a player
  
   x = xx;
   y = yy;
   d = dd;
   p = pp;
 
   if (p == 1)
     c = red;
     
   else
     c = blue;

 }
 
 void display () { //Displays the player on the screen
   
   stroke(border);
   fill(c);
   rect(x, y, d, d);
   
 }
 
  void safety () { //Gives or removes immortality based on where the player lies on the map
   
   if (this.p == 1) {
     
     if (this.x + d > 710) {
       
       this.safe = false;
       
       if (firstCross1 == true) {
         
         cross1++;
         firstCross1 = false;
         
       }
       
     }
       
     else {
       
        this.safe = true;
        firstCross1 = true;
        
     }
     
   }
   
   else {
     
     if (this.x < 710) {
       
       this.safe = false;
       
       if (firstCross2 == true) {
         
         cross2++;
         firstCross2 = false;
         
       }
       
     }
       
     else {
       
        this.safe = true;
        firstCross2 = true;
        
     }
     
   }
   
 }
 
  void playerCollide (Player other) { //Checks if the two players collide and if so, who dies
   
   boolean collision = false;
   
   if (this.x + d >= other.x && this.x <= other.x + d) { //Checks if players collide
     
      if (this.y + d >= other.y && this.y <= other.y + other.d) 
        collision = true;
     
   }
   
   if (collision == true) { //If there is a collision, this determines who dies
     
    collision = false;
    
    if (this.safe == false) {
      
      p1.kill();
      cont = true;
      kill2++;
      
    }
      
    else {
      
      p2.kill();
      cont2 = true;
      kill1++;
      
    }
     
   }
   
 }
 
 void carryFlag () { //Changes the color of the player if they are holding the enemy flag
   
   if (p == 1) {
   
     if (hasFlag == false)
       c = red;
       
     else
       c = darkRed;
   
    }
  
    else {
    
     if (hasFlag == false)
       c = blue;
       
     else
       c = darkBlue;
    
    }
     
  }
 
   void move () { //Allows for the movement of the player
    
    if (dead == false) { //Only moves player if they are not dead
      
     int r = d>>1;   
     int[] moves = move(right, left, up, down); //Sending in the user's input and changing it if they hit any barriers
   
     x = constrain(x + speed * (moves[0] - moves[1]), r - 5, width  - r - 30); //Contstrain limits the movement of the player   
     y = constrain(y + speed * (moves[3] - moves[2]),   r - 5, height - r - 30); //Since false is 0 and true is 1, the movement of the player is based on that multiplied by the speed declared
    
    }
    
  }
  
  public int[] move(boolean right, boolean left, boolean up, boolean down) { //Method that modifies the movement of the player so they are blocked at barriers
   
   rightInt = int(right); //Casting booleans into ints
   leftInt = int(left);
   upInt = int(up);
   downInt = int(down);
   
     if (x > 640 && x < 740) {
      
      if (y > 145 && y < 325) 
        rightInt = 0; //Even if player moves right, the data is modified to 0 because there is a barrier
       if (y > 435 && y < 615) 
        rightInt = 0;
        
    }
    
    if (x > 680 && x < 745) {
      
       if (y > 145 && y < 325) 
         leftInt = 0;
       if (y > 435 && y < 615) 
         leftInt = 0;
        
    }
    
    if (y > 140 && y < 325) {
      
       if (x > 648 && x < 737) 
         downInt = 0;
        
    }
    
    if (y > 425 && y < 615) {
      
       if (x > 648 && x < 737) 
         downInt = 0;
        
    }
    
    if (y > 145 && y < 331) {
      
       if (x > 645 && x < 740) 
         upInt = 0;
        
    }
    
    if (y > 435 && y < 619) {
      
       if (x > 645 && x < 740) 
         upInt = 0;
        
    }
    
    int moves[] = {rightInt, leftInt, upInt, downInt};
    
    return (moves); //Returns the movement of the player taking into consideration the barriers
   
 }
 
 void kill () { //Kills the player, moves them back to their side and removes their flag if they captured it
   
   dead = true;
   border = 255;
   hasFlag = false;
   y = YPlayers;
   
   if (p == 1) 
     x = XPlayer1;
   
   else      
    x = XPlayer2;
   
 }
 
 void respawn () {//Respawns the player
   
  dead = false;
  border = 0;
   
 }
 
  boolean control1 (int code, boolean direct) { //If a key is pressed, it returns true for that direction and false if it is released
   
   switch (code) { //Controls for player1 are W, A, S and D
     
      case +'W':
        return up = direct;
 
      case +'S':
        return down = direct;
 
      case +'A':
        return left = direct;
 
      case +'D':
        return right = direct;
 
      default:
        return direct;
        
   }
   
 }
 
 boolean control2 (int code, boolean direct) { //Different controls for player2
   
   switch (code) { //Controls for player2 are up arrow, down arrow, left arrow and right arrow
     
      case + UP:
        return up = direct;
 
      case + DOWN:
        return down = direct;
 
      case + LEFT:
        return left = direct;
 
      case + RIGHT:
        return right = direct;
 
      default:
        return direct;
        
   }
   
 }
 
} 
