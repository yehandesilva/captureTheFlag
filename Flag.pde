class Flag { //Class for a flag
  
  int x, y, f; //Coordinates and which flag
  color c; //Color of the flag
  boolean captured = false; //Boolean to state if the flag has been captured
  
  public Flag (int xx, int yy, color cc) { //Constructor method for creating a flag
    
    x = xx;
    y = yy;
    c = cc;
    
    if (c == blue)
      f = 1;
      
    else      
      f = 2; 
    
  }
  
  void display () {
    
   stroke(black);
   fill(c);
   ellipseMode(CORNER); //Draws the circle utilizing the cornor for the x and y coordinates
   ellipse(x, y, dimension, dimension);
    
  }
  
  void capture () { //Changes the color of the flag if it is captured
    
    if (f == 1) {
   
     if (captured == false)
       c = blue;
       
     else {
       
       c = gray;
       
       if (firstCapture2 == true) {
         
         flagCarry2++;
         firstCapture2 = false;
         
       }
         
      }
   
    }
  
    else {
    
     if (captured == false)
       c = red;
       
     else {
       
       c = gray;
       
       if (firstCapture1 == true) {
         
         flagCarry1++;
         firstCapture1 = false;
         
       }
       
     }
    
    }
     
  }
  
}
