class Buildings
{
  PShape buildings;
  Map3D map;
  JSONArray features;
  
  
  public Buildings(Map3D givenMap)
  {
      this.map = givenMap;
      this.buildings = createShape(GROUP);   
  }
  
  public void add(String nomFichier, color myColor)
  {
      //Récuperation du fichier mgl
      File ressource = dataFile(nomFichier);
      if(!ressource.exists() || ressource.isDirectory())
      {
         println("ERROR : Trail file " + nomFichier + "not found.");
         exitActual();
      }
      
      
      //On récupère le JSON
      JSONObject geojson = loadJSONObject(nomFichier);
      if (!geojson.hasKey("type")) 
      {
             println("WARNING: Invalid GeoJSON file.");
             return;
      } 
      else if (!"FeatureCollection".equals(geojson.getString("type", "undefined"))) 
      {
             println("WARNING: GeoJSON file doesn't contain features collection.");
             return;
      }
      
      // Parse features
      this.features =  geojson.getJSONArray("features");
      if (features == null) {
        println("WARNING: GeoJSON file doesn't contain any feature.");
        return;
      }
      
      
      for(int f=0; f < features.size(); f++)
      {
          JSONObject feature = features.getJSONObject(f);
          if (!feature.hasKey("geometry"))
            break;
            
          int levels = feature.getInt("building:levels", 1);
          JSONObject geometry = feature.getJSONObject("geometry");
          
          switch(geometry.getString("type","undefined"))
          {
           
              case "Polygon":
              
                PShape roof, walls;
                roof = createShape();
                walls = createShape();
                roof.beginShape();
                walls.beginShape(QUAD_STRIP);
                roof.fill(myColor);
                walls.fill(myColor);
                walls.emissive(0x30);
                walls.noStroke();
                roof.emissive(0x60);
                roof.noStroke();
                
                JSONArray coord = geometry.getJSONArray("coordinates");
                
                for(int bar = 0 ; bar < coord.size(); bar++)
                {
                    JSONArray num_bat = coord.getJSONArray(bar);
                    
                    for(int foo = 0; foo < num_bat.size(); foo++)
                    {
                      JSONArray hit = num_bat.getJSONArray(foo);
                      
                      Map3D.GeoPoint gp = this.map.new GeoPoint(hit.getFloat(0),hit.getFloat(1));
                      Map3D.ObjectPoint op = this.map.new ObjectPoint(gp);
                      
                      if(op.inside())
                      {
                       
                        float toit = Map3D.heightScale*8.0f*(float)levels;
                        
                        roof.vertex(op.x,op.y,op.z + toit);
                        
                        walls.vertex(op.x,op.y,op.z);
                        walls.vertex(op.x,op.y,op.z + toit);
                        
                      }
                      
                      
                    }
                  
                }
                
                walls.endShape();
                roof.endShape();
                this.buildings.addChild(roof);
                this.buildings.addChild(walls);
                break;
                
              default:
                println("WARNING: GeoJSON '" + geometry.getString("type", "undefined") + "' geometry type not handled.");
                break;
            
          }
          
            
      }
      
      
  }
  
  void update()
  {
    shape(this.buildings); 
  }
  
  void toggle()
  {
    this.buildings.setVisible(!this.buildings.isVisible()); 
  }
  
}
