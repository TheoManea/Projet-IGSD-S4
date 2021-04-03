class Land 
{
  Map3D map;
  PShape shadow, wireFrame;
  
  
   /**
   * Returns a Land object.
   * Prepares land shadow, wireframe and textured shape
   * @param map Land associated elevation Map3D object 
   * @return Land object
   */
   public Land(Map3D map) 
   {
         
     
     
         final float tileSize = 25.0f;
         this.map = map;
         float w = (float)Map3D.width;
         float h = (float)Map3D.height;
         // Shadow shape
         this.shadow = createShape();
         this.shadow.beginShape(QUADS);
         this.shadow.fill(0x992F2F2F);
         this.shadow.noStroke();
         this.shadow.vertex(-w/2, -h/2, -10.0f); //NW
         this.shadow.vertex(-w/2, h/2, -10.0f); //SW 
         this.shadow.vertex(w/2, h/2, -10.0f); //SE
         this.shadow.vertex(w/2, -h/2, -10.0f); //NE
         this.shadow.endShape();
         // Wireframe shape
         this.wireFrame = createShape();
         this.wireFrame.beginShape(QUADS);
         this.wireFrame.noFill();
         this.wireFrame.stroke(#888888);
         this.wireFrame.strokeWeight(0.5f);
         
         float size = 20.0f;
         
       
         for(int i = (int)(-w/(2*size)); i < w/(2*size); i++ )
         {
       
           
           for(int j = (int)(-h/(2*size)); j < h/(2*size); j++)
           {
              Map3D.ObjectPoint un  = this.map.new ObjectPoint( i*size, j*size  );
              Map3D.ObjectPoint deux  = this.map.new ObjectPoint( (i+1)*size, j*size  );
              Map3D.ObjectPoint trois  = this.map.new ObjectPoint( (i+1)*size, (j+1)*size  );
              Map3D.ObjectPoint quatre  = this.map.new ObjectPoint( i*size, (j+1)*size  );
              
              
              this.wireFrame.vertex(un.x, un.y, un.z);
              this.wireFrame.vertex(deux.x, deux.y, deux.z);
              this.wireFrame.vertex(trois.x, trois.y, trois.z);
              this.wireFrame.vertex(quatre.x, quatre.y, quatre.z);
              
              
              
              
           }
           
         }
         
         
         
         this.wireFrame.endShape();
         // Shapes initial visibility
         this.shadow.setVisible(true);
         this.wireFrame.setVisible(true);
   }
   
   
   
    public void update()
    {
     shape(this.shadow);
     shape(this.wireFrame);
      
    }
    
    /**
    * Toggle Shadow & Wireframe visibility.
    */
    public void toggle() 
    {
       this.shadow.setVisible(!this.shadow.isVisible());
       this.wireFrame.setVisible(!this.wireFrame.isVisible());
       
    }
  
  
  
}
