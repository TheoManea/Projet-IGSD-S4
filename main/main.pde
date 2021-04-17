WorkSpace workspace;
Hud hud;
Camera camera;
Map3D map;
Land land;
Gpx gpx;
Railways railways;
Roads roads;
Buildings buildings;
Poi poi;

PShader progShader;

boolean picnic; // Booléen sur l'affichage des table de picnic dans le shader
boolean bicycle; // Booléen sur l'affichage des stations velo dans le shader

void setup() {
  
  // Display setup
  size(1500,1000,P3D);
  
  // Setup Head Up Display
  this.hud = new Hud();
  
  smooth(8);
  frameRate(60);
  
  // Initial drawing
  background(0x40);
  
  hint(ENABLE_KEY_REPEAT);
  
  // Prepare local coordinate system grid & gizmo
  this.workspace = new WorkSpace(250*100);
  
  //Initialisation de la camera
  this.camera = new Camera();
  
  //Initialisation de la map
  this.map = new Map3D("paris_saclay.data");
  
  //Chargement du Shader
  progShader = loadShader("myFrag.glsl", "myGreen.glsl");
  
  //Booleen pour afficher ou pas les points d'intérêts
  this.picnic = true;
  this.bicycle = true;
  
  //Initialisation du terrain
  this.land = new Land(this.map,"paris_saclay.jpg");
  
  //Initialisation des points d'intérêts
  this.poi = new Poi(this.land);
  this.poi.calculdistance();
  
  //Initialisation du tracé GPS
  this.gpx = new Gpx(this.map);
  
  //Initialisation du chemin de fer
  this.railways = new Railways(this.map, "railways.geojson");
  
  //Initialisation des routes
  this.roads = new Roads(this.map,"roads.geojson");
  
  //Création des différents bâtiments
  this.buildings = new Buildings(this.map);
  this.buildings.add("buildings_city.geojson", 0xFFaaaaaa);
  this.buildings.add("buildings_IPP.geojson", 0xFFCB9837);
  this.buildings.add("buildings_EDF_Danone.geojson", 0xFF3030FF);
  this.buildings.add("buildings_CEA_algorithmes.geojson", 0xFF30FF30);
  this.buildings.add("buildings_Thales.geojson", 0xFFFF3030);
  this.buildings.add("buildings_Paris_Saclay.geojson", 0xFFee00dd);
  
  

  

}

void draw(){
  
  background(0x40);
  this.workspace.update();
  this.camera.update();
  
  // On crée no shader avec le booleen correspondant
  progShader.set("picnic", this.picnic);
  progShader.set("bicycle", this.bicycle);
  shader(progShader);
  this.land.update();
  resetShader();
  
  this.railways.update();
  this.roads.update();
  this.buildings.update();
  this.gpx.update();
  this.hud.update(this.camera);
  
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
        this.camera.adjustRadius(-60);
        break;
      case '-':
      case 'm':
      case 'M':
        this.camera.adjustRadius(60);
        break;
      case 'l':
      case 'L':
        this.camera.toggle();
        break;
      case 'r':
      case 'R':
        this.railways.toggle();
        this.roads.toggle();
        break;
      case 'X':
      case 'x':
        this.gpx.toggle();
        break;
      case 'b':
      case 'B':
        this.buildings.toggle();
        break;
        
      }
    }

}


void mousePressed() {
  if (mouseButton == LEFT)
    this.gpx.click(mouseX, mouseY);
}
