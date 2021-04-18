class Hud {
  private PMatrix3D hud;
  Hud() {
     // Should be constructed just after P3D size() or fullScreen()
     this.hud = g.getMatrix((PMatrix3D) null);
  }

  
  private void begin() {
    g.noLights();
    g.pushMatrix();
    g.hint(PConstants.DISABLE_DEPTH_TEST);
    g.resetMatrix();
    g.applyMatrix(this.hud);
  }

  private void end() {
    g.hint(PConstants.ENABLE_DEPTH_TEST);
    g.popMatrix();
  }

  /**
  * Méthode pour afficher les FPS
  */
  private void displayFPS() {
    // Bottom left area
    noStroke();
    fill(96);
    rectMode(CORNER);
    rect(10, height-30, 60, 20, 5, 5, 5, 5);
    // Value
    fill(0xF0);
    textMode(SHAPE);
    textSize(14);
    textAlign(CENTER, CENTER);
    text(String.valueOf((int)frameRate) + " fps", 40, height-20);
  }
  
  /**
  * Méthode pour afficher la Caméra et les touches actives
  */
  public void displayCamera(Camera camera){
    // Top left area
    noStroke();
    fill(96);
    rectMode(CORNER);
    rect(0, 0, width/8, height/4, 5, 5, 5, 5);
    // Value
    fill(0xF0);
    textMode(SHAPE);
    textSize(14);
    textAlign(CENTER, CENTER);
    text("Camera", width/16, 20);
    text("Longitude  "+ String.valueOf((int)(camera.longitude*180/PI) + " °"),width/16, 50);
    text("Colatitude  "+ String.valueOf((int)(camera.colatitude*180/PI) + " °"),width/16, 80);
    text("Radius  "+ String.valueOf((int)camera.radius) + " m",width/16, 110);
    text("X " + String.valueOf((int)camera.x),width/16,140);
    text("Y " + String.valueOf((int)camera.y),width/16,170);
    text("Z " + String.valueOf((int)camera.z),width/16,200);
    
    //touches active
    noStroke();
    fill(96);
    rect((width-width/8), 0, width/8, height/4, 5, 5, 5, 5);
    fill(0xF0);
    textMode(SHAPE);
    textSize(14);
    textAlign(CENTER, CENTER);
    text("Grille & Gizmo [W]",(width-width/16),20);
    text("Zoom [+ ; P]",(width-width/16),50);
    text("Dézoom [- ; M]",(width-width/16),80);
    text("Luminosité [L]",(width-width/16),110);
    text("Route & chemin de fer [R]",(width-width/16),140);
    text("Tracé GPS [X]",(width-width/16),170);
    text("Bâtiments [B]",(width-width/16),200);
  }

  /**
  * Méthode pour afficher le HUD
  */
  public void update(Camera camera) {
    this.begin();
    this.displayFPS();
    this.displayCamera(camera);
    this.end();
  }
}
