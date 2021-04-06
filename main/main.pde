WorkSpace workspace;
Hud hud;
Camera camera;
Map3D map;
Land land;
Gpx gpx;
Railways railways;
Roads roads;


void setup() {
  // Display setup
  fullScreen(P3D);
  // Setup Head Up Display
  this.hud = new Hud();
  smooth(8);
  frameRate(60);
  // Initial drawing
  background(0x40);
  
  hint(ENABLE_KEY_REPEAT);
  
  // Prepare local coordinate system grid & gizmo
  this.workspace = new WorkSpace(250*100);
  
  this.camera = new Camera();
  
  this.map = new Map3D("paris_saclay.data");
  
  this.land = new Land(this.map,"paris_saclay.jpg");
  
  this.gpx = new Gpx(this.map);
  
  this.railways = new Railways(this.map, "railways.geojson");
  
  this.roads = new Roads(this.map,"roads.geojson");
  
  

  

}

void draw(){
  background(0x40);
  this.workspace.update();
  this.camera.update();
  this.hud.update(this.camera);
  this.land.update();
  this.gpx.update();
  this.railways.update();
  this.roads.update();
}

void keyPressed() {
  if (key == CODED){
    switch(keyCode){
      case UP:
        this.camera.adjustLongitude(-PI/100);
        break;
      case DOWN:
        this.camera.adjustLongitude(PI/100);
        break;
      case LEFT:
        this.camera.adjustColatitude(-PI/100);
        break;
      case RIGHT:
        this.camera.adjustColatitude(PI/100);
        break;
    }
  } else {
    switch (key) {
      case 'w':
      case 'W':
        // Hide/Show grid & Gizmo
        this.workspace.toggle();
        this.land.toggle();
        break;
      case '+':
      case 'p':
      case 'P':
        this.camera.adjustRadius(-10);
        break;
      case '-':
      case 'm':
      case 'M':
        this.camera.adjustRadius(10);
        break;
      case 'l':
      case 'L':
        this.camera.toggle();
        break;
      case 'r':
        this.railways.toggle();
        this.roads.toggle();
        break;
      case 'X':
      case 'x':
        this.gpx.toggle();
        break;
        
      }
    }

}


void mousePressed() {
  if (mouseButton == LEFT)
    this.gpx.click(mouseX, mouseY);
}
