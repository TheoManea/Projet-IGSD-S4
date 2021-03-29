WorkSpace workspace;


void setup() {
  // Display setup
  size(1500,500,P3D);
  // Setup Head Up Display
 
  smooth(4);
  frameRate(60);
  // Initial drawing
  background(0x40);
  // Prepare local coordinate system grid & gizmo
  this.workspace = new WorkSpace();

  camera(
     0, 2500, 1000, 
     0, 0, 0, 
     0, 0, -1
     );

}

void draw(){
  background(0x40);
  this.workspace.update();
}

void keyPressed() {
 switch (key) {
 case 'w': 
 case 'W':
 // Hide/Show grid & Gizmo
 this.workspace.toggle(); 
 break;
 }
}
