import java.util.*;
import java.io.*;

class Land 
{
  Map3D map;
  PShape shadow, wireFrame, satellite; //Les différentes PShape
   
  
  
   /**
   * Returns a Land object.
   * Prepares land shadow, wireframe and textured shape
   * @param map Land associated elevation Map3D object 
   * @return Land object
   */
   public Land(Map3D map, String nomFichier) 
   {
         this.map = map;
       
       
       
       //HashMap<PVector,PVector> poiParkingMin = new HashMap<PVector,PVector>();
     
         File ressource = dataFile(nomFichier);
        if (!ressource.exists() || ressource.isDirectory()) {
          println("ERROR: Land texture file " + nomFichier + " not found.");
          exitActual();
        }
        PImage uvmap = loadImage(nomFichier);
         
       
        
        
       
     
     
         final float tileSize = 25.0f;
        
         
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
         
         this.satellite = createShape();
         
         this.satellite.beginShape(QUADS);
          this.satellite.texture(uvmap);
          this.satellite.noFill();
          this.satellite.noStroke();
          this.satellite.emissive(0xD0);
          int u = 0;
          for (int i = (int)(-w/(2*tileSize)); i < w/(2*tileSize); i++){
            int v = 0;
            for (int j = (int)(-h/(2*tileSize)); j < h/(2*tileSize); j++){
              Map3D.ObjectPoint bl = this.map.new ObjectPoint(i*tileSize, j*tileSize);
              Map3D.ObjectPoint tl = this.map.new ObjectPoint((i+1)*tileSize, j*tileSize);
              Map3D.ObjectPoint tr = this.map.new ObjectPoint((i+1)*tileSize, (j+1)*tileSize);
              Map3D.ObjectPoint br = this.map.new ObjectPoint(i*tileSize, (j+1)*tileSize);
              
              
              
              PVector nbl = bl.toNormal();
              PVector ntl = tl.toNormal();
              PVector ntr = tr.toNormal();
              PVector nbr = br.toNormal();
              
              
             
              
              
              
              
              this.satellite.normal(nbl.x, nbl.y, nbl.z);
              // ... on ajoute un attribut "heat" pour afficher les cartes de chaleur
              this.satellite.attrib("heat", 0.0f, 0.0f);
              
              this.satellite.vertex(bl.x, bl.y, bl.z, u, v);
              this.satellite.normal(ntl.x, ntl.y, ntl.z);
              this.satellite.attrib("heat", 0.0f, 0.0f);
              this.satellite.vertex(tl.x, tl.y, tl.z, u+tileSize/5, v);
              this.satellite.normal(ntr.x, ntr.y, ntr.z);
              this.satellite.attrib("heat", 0.0f, 0.0f);
              this.satellite.vertex(tr.x, tr.y, tr.z, u+tileSize/5, v+tileSize/5);
              this.satellite.normal(nbr.x, nbr.y, nbr.z);
              this.satellite.attrib("heat", 0.0f, 0.0f);
              this.satellite.vertex(br.x, br.y, br.z, u, v+tileSize/5);
              v += tileSize/5;
            }
            u += tileSize/5;
          }
          this.satellite.endShape();

         
         
         // Wireframe shape
        
         this.wireFrame = createShape();
         this.wireFrame.beginShape(QUADS);
         this.wireFrame.noFill();
         this.wireFrame.stroke(#888888);
         this.wireFrame.strokeWeight(0.5f);
         
         
         
       
         for(int i = (int)(-w/(2*tileSize)); i < w/(2*tileSize); i++ )
         {
       
           
           for(int j = (int)(-h/(2*tileSize)); j < h/(2*tileSize); j++)
           {
              Map3D.ObjectPoint un  = this.map.new ObjectPoint( i*tileSize, j*tileSize  );
              Map3D.ObjectPoint deux  = this.map.new ObjectPoint( (i+1)*tileSize, j*tileSize  );
              Map3D.ObjectPoint trois  = this.map.new ObjectPoint( (i+1)*tileSize, (j+1)*tileSize  );
              Map3D.ObjectPoint quatre  = this.map.new ObjectPoint( i*tileSize, (j+1)*tileSize  );
              
              
              
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
         this.satellite.setVisible(true);
   }
   
   
   
   
   
   
  
   
   /**
    * Méthodes pour afficher les formes
    */
    public void update()
    {
     shape(this.shadow);
     shape(this.wireFrame);
     shape(this.satellite); 
    }
    
    /**
    * Toggle Shadow & Wireframe visibility.
    */
    public void toggle() 
    {
       this.shadow.setVisible(!this.shadow.isVisible());
       this.wireFrame.setVisible(!this.wireFrame.isVisible());
       this.satellite.setVisible(!this.satellite.isVisible());
    }
  
  
  
}
