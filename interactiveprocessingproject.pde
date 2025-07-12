/* Author of the code : 48538817 //<>//
program for COMP1000 SUBMISSION
link for meme: https://www.tiktok.com/@mr.cattttttt/video/7280590289578839338?is_from_webapp=1&sender_device=pc&web_id=7429931679995020807
interactive program */


boolean fallingDown = true;
boolean REDCHEEKS = false;
color cheeks = color(245,203,183);
float[] spXArray = new float[5];
float[] spYArray = new float[5];
float[] dxArray = new float[5];
float[] dyArray = new float[5];
boolean[] mouthStates = new boolean[5]; 

void setup() {
  size(700, 700);
  for (int i = 0; i < spXArray.length; i++) {
    spXArray[i] = random(width);
    spYArray[i] = random(height);
    dxArray[i] = random(-5, 5);
    dyArray[i] = random(-5, 5);
    mouthStates[i] = false; // Initialize mouth states
  }
}

void background() {
  //draw backstage
  fill(150, 75, 0); // Brown color
  rect(0, height - 50, width, 50); 
  fill(100, 100, 255); // Light blue color
  rect(0, 0, width, height - 50); 
  //draw curtains
  fill(255, 0, 0); // Red color
  rect(0, 0, 50, height); // Left curtain
  rect(width - 50, 0, 50, height); // Right curtain
  noFill();
  stroke(0); // Black color for the border
  strokeWeight(5);
  rect(0, 0, width, height - 50);
}

void drawText(){ //function to drawtext
  fill(255);
  textSize(20); 
  text("press s or S to collect all faces to the middle", width/4, height-1/3*height-25);
 text("press o or O to stop faces from moving", width/3.5, height-1/3*height-50); 
  text("press m or M to move faces to random directions", width/5, height-1/3*height-75); 
text ("click on the cat to pet it", width/2.75, height-1/3*height-100);
}

void drawFace(float spX, float spY, boolean mouthState) {
   //cat ears
   strokeWeight(1);
  fill(245, 203, 183);
  circle(spX - 70, spY - 70, 50); // Left ear
  circle(spX + 70, spY - 70, 50); // Right ear
  fill(255); // Inner ear color
  circle(spX - 70, spY - 70, 30); // Inner left ear
  circle(spX + 70, spY - 70, 30); // Inner right ear

  //face
  noStroke();
  fill(245, 203, 183);
  circle(spX,spY,170);
  //left brows and eyes
  stroke(0);
  strokeWeight(1);
  fill(0);
  rect(spX-25,spY-56,30,10);
  fill(255,255,255);
  circle(spX-25,spY-36,20);
  fill(0,0,255);
  ellipse(spX-25,spY-36,10,20);
  //right brows and eyes
  strokeWeight(1);
  fill(0,0,0);
  rect(spX+15,spY-56,30,10);
  fill(255,255,255);
  circle(spX+35,spY-36,20);
  fill(0,0,255);
  ellipse(spX+35,spY-36,10,20);
  //nose
  fill(0);
  noStroke();
  circle(spX,spY,16);
  circle(spX+15,spY,16);
  circle (spX+7,spY, 25);
  //mouth
  if (mouthState){ //change based on boolean
  fill(255, 0, 0); 
  circle(spX+10, spY+40, 30);}
  else{
    fill(255,0,0);
    rect(spX-40,spY+24,90,15);
  }
  //cheeks
  noStroke();
  fill(cheeks); //cheeks colour
  ellipse(spX-45,spY-6,50,20);
  if (REDCHEEKS){ //boolean if redcheeks = true
    cheeks = color(255,0,0);
  } else {
    cheeks = color(245, 203, 183);
  }
  fill(cheeks);
  ellipse(spX+55,spY-6,50,20);
    //whiskers
    stroke(0);
    strokeWeight(2);
  line(spX - 100, spY, spX-50, spY); // Left whiskers
  line(spX - 100, spY + 10, spX-50, spY + 10);
  line(spX - 100, spY - 10, spX - 50, spY - 10);
  line(spX + 100, spY, spX + 50, spY); // Right whiskers
  line(spX + 100, spY + 10, spX + 50, spY + 10);
  line(spX + 100, spY - 10, spX + 50, spY - 10);
}


void bounceoff(int i) { //function to bounce off walls
  if (spXArray[i] > width || spXArray[i] < 0) {
    dxArray[i] = -dxArray[i];
  }
  if (spYArray[i] >= height || spYArray[i] < 0) {
    dyArray[i] = -dyArray[i];
  }

  spXArray[i] += dxArray[i];
  spYArray[i] += dyArray[i];
}

boolean checkCollision(int i, int j) { //function to check collision between faces
  float distance = dist(spXArray[i], spYArray[i], spXArray[j], spYArray[j]);
  return distance < 85;
}

void draw() {
  background();
  for (int i = 0; i < spXArray.length; i++) {
    bounceoff(i);
    drawFace(spXArray[i], spYArray[i], mouthStates[i]);
    drawText();

    // Check for collisions with other faces
    for (int j = 0; j < spXArray.length; j++) {
      if (i != j && checkCollision(i, j)) { //to make sure its not the same face
       mouthStates[i] =! mouthStates[i];  
        mouthStates[j] =! mouthStates[j];  
        
       float cx = averageX (spXArray[i],spXArray[j]); //to find average x pos from collisions
       float cy =  averageY (spYArray[i], spYArray[j]);
        
        fill(255);
        textSize(20); 
        text("hellow there!", cx, cy); //text
        
        
      }
    }
  }
}

float averageX(float a, float b){ //function that return float value
  return (a+b)/2;
}
float averageY(float a, float b){
  return (a+b)/2 +100;
}

void keyPressed (){ //keypressed functions
  if (key =='s' || key=='S'){
    for (int i =0; i<spXArray.length;i++){
      spXArray [i] = width/2;
      spXArray[i] = height/2;
    }
  }
  else if (key=='o'||key=='O'){ // dxArray[i] = random(-5, 5);
   //  dyArray[i] = random(-5, 5);
   for (int i=0; i<dxArray.length;i++){
     dxArray[i] = 0;
     dyArray[i] = 0;
   }
  }
  else if (key == 'm' || key=='M'){
    for (int i=0;i<dxArray.length;i++){
      dxArray[i] = random(-5,5);
      dyArray[i] = random(-5, 5);
    }
  }
}
      
    

void mousePressed() { //mouse press functions for redcheeks
  for (int i = 0; i < spXArray.length; i++) {
    if (dist(mouseX, mouseY, spXArray[i], spYArray[i]) < 85) { // Check if mouse is over the face
      REDCHEEKS = !REDCHEEKS;
    }
  }
}
