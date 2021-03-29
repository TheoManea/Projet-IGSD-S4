
//Appel du workspace
WorkSpace workspace;

void setup() {
   size(1000,500,P3D); 
   background(0,0,0);
   frameRate(60);
   
   this.workspace = new WorkSpace();
   
   
   
   camera(
     0, 2500, 1000, 
     0, 0, 0, 
     0, 0, -1
     );
   
}

void draw() {
  
  
    //on dessine le gizmo
    this.workspace.update();
    
}


void keyPressed() 
{
     switch (key) 
     {
       case 'w':
       case 'W':
       // Hide/Show grid & Gizmo
       this.workspace.toggle();
       break;
      }
}
