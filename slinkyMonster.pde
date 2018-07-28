// Template for 2D projects
// Author: Jarek ROSSIGNAC
import processing.pdf.*;    // to save screen shots as PDFs, does not always work: accuracy problems, stops drawing or messes up some curves !!!

//**************************** global variables ****************************
pts P = new pts(); // class containing array of points, used to standardize GUI
float t=0, f=0;
boolean animate=true, fill=false, timing=false;
boolean lerp=true, slerp=true, spiral=true; // toggles to display vector interpoations
int ms=0, me=0; // milli seconds start and end for timing
int npts=20000; // number of points


float angle = 0;
float radius = 0;
//**************************** initialization ****************************
void setup()               // executed once at the begining 
  {
  size(800, 800);            // window size
  frameRate(60);             // render 60 frames per second
  smooth();                  // turn on antialiasing
  P.declare(); // declares all points in P. MUST BE DONE BEFORE ADDING POINTS 
  // P.resetOnCircle(4); // sets P to have 4 points and places them in a circle on the canvas
  P.loadPts("data/pts");  // loads points form file saved with this program
  
  
  } // end of setup

//**************************** display current frame ****************************
void draw()      // executed at each frame
  {
  if(recordingPDF) startRecordingPDF(); // starts recording graphics to make a PDF
  
    background(white); // clear screen and paints white background
    pt A=P.G[0], B=P.G[1], C=P.G[2], D=P.G[3], E = P.G[4], F = P.G[6];     // creates points with more convenient names 
    
    E.x = 400;
    E.y = 200;
     
    pen(green,3); edge(A,B); 
    
    pen(red,70); edge(C,D); 

    //pen(black,2); showId(A,"A"); showId(B,"B");
    noFill(); 
    //pen(blue,2); show(SpiralCenter2(A,B,C,D),16);
    //pen(magenta,2); show(SpiralCenter3(A,B,C,D),20);
    
    pen(#FF6B08,10); showSpiralPattern(A,B,D,C);
    
    F.rotate(0.1, E); //Rotates F about E at a constant rate (0.1)
    C.rotate(0.03,F); //Rotates C and D about F at a constant rate
    D.rotate(0.03,F);
    
    
    pen(red,70); edge(C,D);
    
    //taken from http://www.openprocessing.org/sketch/52159
    pen(black,0);
    fill(255); 

    ellipse(C.x, C.y, 40, 40);
    ellipse(D.x, D.y, 40, 40);
    
    fill(0);
    float mx1 = constrain(mouseX, C.x - 15, C.x + 15);  
    float my1 = constrain(mouseY, C.y - 15, C.y + 15);
    ellipse(mx1, my1, 10, 10);  
    float mx2 = constrain(mouseX, D.x - 15, D.x + 15);
    float my2 = constrain(mouseY, D.y - 15, D.y + 15);
    ellipse(mx2, my2, 10, 10);
   
     
  if(recordingPDF) endRecordingPDF();  // end saving a .pdf file with the image of the canvas

  fill(black); displayHeader(); // displays header
  if(scribeText && !filming) displayFooter(); // shows title, menu, and my face & name 

  if(filming && (animating || change)) snapFrameToTIF(); // saves image on canvas as movie frame 
  if(snapTIF) snapPictureToTIF();   
  if(snapJPG) snapPictureToJPG();   
  change=false; // to avoid capturing movie frames when nothing happens
  }  // end of draw
  