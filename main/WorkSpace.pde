class WorkSpace 
{
  PShape gizmo;
  PShape grid;
  PShape thinX, thinY; //l'axe X et Y
  PShape SE,NE,SW,NW; //Délimitation du terrain
  
  public WorkSpace(int size)
  {
    
   this.SE = createShape(BOX,40);
   this.SE.setFill(color(0,0,255));
   this.SE.endShape();
   
   this.SW = createShape(BOX,40);
   this.SW.setFill(color(0,0,255));
   this.SW.endShape();
   
   this.NE = createShape(BOX,40);
   this.NE.setFill(color(0,0,255));
   this.NE.endShape();
   
   this.NW = createShape(BOX,40);
   this.NW.setFill(color(0,0,255));
   this.NW.endShape();
    
    

    //On dessine le Gizmo
   this.gizmo = createShape();
   this.gizmo.beginShape(LINES);
   this.gizmo.noFill();
   this.gizmo.strokeWeight(3.0f);
   // Red X
   this.gizmo.stroke(0xAAFF3F7F);
   this.gizmo.vertex(0, 0, 0);
   this.gizmo.vertex(300, 0, 0);
   // Green Y
   this.gizmo.stroke(0xAA3FFF7F);
   this.gizmo.vertex(0, 0, 0);
   this.gizmo.vertex(0, 300, 0);
   // Blue Z
   this.gizmo.stroke(0xAA3F7FFF);
   this.gizmo.vertex(0, 0, 0);
   this.gizmo.vertex(0, 0, 300);
   this.gizmo.endShape();
   
   
   //Et maintenant on dessine la grille
   this.grid = createShape();
    this.grid.beginShape(QUADS);
    this.grid.noFill();
    this.grid.stroke(207, 121, 29);
    this.grid.strokeWeight(0.5f);
    for(int i=-size/2; i<size/2; i+=100){
      for(int j=-size/2; j<size/2; j+=100){
        this.grid.vertex(i,j);
        this.grid.vertex(i+100,j);
        this.grid.vertex(i+100,j+100);
        this.grid.vertex(i,j+100);
      }
    }
    this.grid.endShape();
    
    
    //Ajout des lignes fines
    this.thinX = createShape();
    this.thinX.beginShape(LINES);
    this.thinX.noFill();
    this.thinX.strokeWeight(0.2f);
    this.thinX.stroke(255,0,0);
    this.thinX.vertex(-size, 0, 0);
    this.thinX.vertex(size, 0, 0);
    this.thinX.endShape();
    
    this.thinY = createShape();
    this.thinY.beginShape(LINES);
    this.thinY.noFill();
    this.thinY.strokeWeight(0.2f);
    this.thinY.stroke(0,255,0);
    this.thinY.vertex(0, -size, 0);
    this.thinY.vertex(0, size, 0);
    this.thinY.endShape();
     
   



  }

  /**
  * Update Gizmo
  */
  public void update(){
    shape(this.gizmo);
    shape(this.grid);
    shape(this.thinX);
    shape(this.thinY);
    shape(this.SE,2500,1500);
    shape(this.SW,-2500,1500);
    shape(this.NW,-2500,-1500);
    shape(this.NE,2500,-1500);
  }

  /**
  * Toggle Grid & Gizmo visibility.
  */
  public void toggle() 
  {
     this.gizmo.setVisible(!this.gizmo.isVisible());
     this.grid.setVisible(!this.grid.isVisible());
     this.thinX.setVisible(!this.thinX.isVisible());
     this.thinY.setVisible(!this.thinY.isVisible());
     this.SE.setVisible(!this.SE.isVisible());
     this.SW.setVisible(!this.SW.isVisible());
     this.NE.setVisible(!this.NE.isVisible());
     this.NW.setVisible(!this.NW.isVisible());
     
  }
}
