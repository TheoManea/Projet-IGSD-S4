class Buildings
{
  PShape buildings; //Forme pour nos bâtiments
  Map3D map; //Carte du système
  JSONArray features; //Array contenant nos données 
  
  /**
  * Constructeur de Buildings
  * @params map : notre cart
  * @return void
  */
  public Buildings(Map3D givenMap)
  {
      this.map = givenMap;
      this.buildings = createShape(GROUP);   
  }
  
  
  /**
  * Fonction d'ajout d'un fichier geojson à nos buildings
  * @params nomFichier : le nom du geojson contenant les différents données
  * @params couleur : une couleur qui varie en fonction du type du building
  */
  public void add(String nomFichier, color myColor)
  {
      //On vérifie l'existence 
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
      this.features = geojson.getJSONArray("features");
      if (features == null) {
        println("WARNING: GeoJSON file doesn't contain any feature.");
        return;
      }
      
      //Pour chaque élement dans notre array on va le construire
      for(int f=0; f < features.size(); f++)
      {
          //On vérifie que notre feature possède bel et bien un attribut "geometry"
          JSONObject feature = features.getJSONObject(f);
          if (!feature.hasKey("geometry"))
            break;
 
          JSONObject geometry = feature.getJSONObject("geometry");
          
          switch(geometry.getString("type","undefined"))
          {
           
              case "Polygon":
              
                JSONArray coordinates = geometry.getJSONArray("coordinates");
                if(coordinates!=null){
                  for(int i = 0 ; i < coordinates.size();i++){
                    JSONArray bat = coordinates.getJSONArray(i);
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
                
                    for(int j = 0 ; j < bat.size() - 1 ; j++){
                      JSONObject properties = feature.getJSONObject("properties");
                      JSONArray hit = bat.getJSONArray(j);
                      int levels = properties.getInt("building:levels",1);
                      float toit = Map3D.heightScale * 3.0f *((float)levels);
                      
                      Map3D.GeoPoint gp = this.map.new GeoPoint(hit.getFloat(0),hit.getFloat(1));
                      Map3D.ObjectPoint op = this.map.new ObjectPoint(gp);
                      
                      if(op.inside())
                      {
                        
                        roof.vertex(op.x,op.y,op.z + toit);
                        
                        walls.vertex(op.x,op.y,op.z);
                        walls.vertex(op.x,op.y,op.z + toit);
                        
                      }
                      
 
                    }
                  
                
                
                walls.endShape();
                roof.endShape();
                this.buildings.addChild(roof);
                this.buildings.addChild(walls);
                  }
                }
                
             default:
               //println("WARNING: GeoJSON '" + geometry.getString("type", "undefined") + "' geometry type not handled.");
                break;
            
          }
          
            
      }
      
      
  }
  
  
  /**
  * Méthode pour afficher les bâtiments
  */
  void update()
  {
    shape(this.buildings); 
  }
  
  /**
  * Méthode pour rendre visible ou non les bâtiments
  */
  void toggle()
  {
    this.buildings.setVisible(!this.buildings.isVisible()); 
  }
  
}
