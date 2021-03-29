class WorkSpace{
   PShape gizmo; 
   
   public WorkSpace(){
    this.gizmo=gizmo();
   }
   
   PShape gizmo(){
      PShape shape = createShape();
      shape.beginShape(LINES);
      shape.noFill();
      shape.strokeWeight(3.0f);
  
      shape.stroke(0xAAFF3F7F);
      shape.vertex(300,0,0);
      shape.vertex(0,0,0);
  
      shape.stroke(0xAA3FFF7F);
      shape.vertex(0,300,0);
      shape.vertex(0,0,0);
  
      shape.stroke(0xAA3F7FFF);
      shape.vertex(0,0,300);
      shape.vertex(0,0,0);
      shape.endShape();
      return shape;
   }
   

   public void update(){
     shape(this.gizmo);

   }
   /**
* Toggle Grid & Gizmo visibility.
*/
void toggle() {
this.gizmo.setVisible(!this.gizmo.isVisible());
}


}
