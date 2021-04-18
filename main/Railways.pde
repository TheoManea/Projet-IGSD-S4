class Railways
{
  PShape railways;
  Map3D map;
  JSONArray features;
  
   /**
  * Constructeur du chemin de fer
  * @params map : La carte sur laquelle on travaille
  * @params fileName : le nom du fichier geojson représentant la ligne du RER B
  */
  public Railways(Map3D givenMap, String nomFichier)
  {
      this.map = givenMap;
      this.railways = createShape(GROUP);
      int laneWidth = 5;
      
      File ressource = dataFile(nomFichier);
      if(!ressource.exists() || ressource.isDirectory())
      {
         println("ERROR : Trail file " + nomFichier + "not found.");
         exitActual();
      }
      
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
      
      
      for (int f=0; f<features.size(); f++) 
      {

        PShape lane = createShape();
  
        lane.beginShape(QUAD_STRIP);
        lane.fill(255, 255, 255);
        lane.noStroke();
        lane.emissive(0x7F);


        JSONObject feature = features.getJSONObject(f);
        if (!feature.hasKey("geometry"))
          break;
        JSONObject geometry = feature.getJSONObject("geometry");
        switch (geometry.getString("type", "undefined")) 
        
        {

        case "LineString":
  
            JSONArray coordinates = geometry.getJSONArray("coordinates");
            JSONArray first_point = coordinates.getJSONArray(0);
            Map3D.GeoPoint f_gp = this.map.new GeoPoint(first_point.getFloat(0), first_point.getFloat(1));
            f_gp.elevation += 7.5d;
            Map3D.ObjectPoint f_mp = this.map.new ObjectPoint(f_gp);
            Map3D.ObjectPoint s_mp = f_mp;
  
            for (int p=0; p < coordinates.size(); p++) 
            {
              if (s_mp.inside()) 
              {
  
                Map3D.ObjectPoint t_mp = s_mp;
                if (p != coordinates.size()-1)
                {
                  JSONArray third_point = coordinates.getJSONArray(p+1);
                  Map3D.GeoPoint t_gp = this.map.new GeoPoint(third_point.getFloat(0), third_point.getFloat(1));
                  t_gp.elevation += 7.5d;
                  t_mp = this.map.new ObjectPoint(t_gp);
                }
  
                PVector Va = new PVector(t_mp.y - f_mp.y, t_mp.x - f_mp.x).normalize().mult(laneWidth/2.0f);
                lane.normal(0.0f, 0.0f, 1.0f);
                lane.vertex(s_mp.x - Va.x, s_mp.y - Va.y, s_mp.z);
                lane.normal(0.0f, 0.0f, 1.0f);
                lane.vertex(s_mp.x + Va.x, s_mp.y + Va.y, s_mp.z);
  
                f_mp = s_mp;
                s_mp = t_mp;
              }
            }
  
          break;

      default:
        println("WARNING: GeoJSON '" + geometry.getString("type", "undefined") + "' geometry type not handled.");
        break;
      }
      lane.endShape();
      this.railways.addChild(lane);
     }
      
      
  }
  
  /**
  * Méthode pour afficher le chemin de fer
  */
  void update()
  {
    shape(this.railways); 
  }
  
  /**
  * Méthode pour rendre visible ou non la voie ferrée
  */
  void toggle()
  {
    this.railways.setVisible(!this.railways.isVisible()); 
  }
  
}
