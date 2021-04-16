class Poi
{
  private Map3D map;
  
  
  
  public Poi(Map3D mymap) {
    this.map = mymap;
  }
  
  public ArrayList<PVector> getPoints(String jsonFile)
  {
      ArrayList<PVector> points = new ArrayList<PVector>();
    
      File ressource = dataFile(jsonFile);
      if(!ressource.exists() || ressource.isDirectory())
      {
         println("ERROR : Trail file " + jsonFile + "not found.");
         exitActual();
      }
    
      JSONObject geojson = loadJSONObject(jsonFile);
      
      if (!geojson.hasKey("type")) 
      {
        println("WARNING: Invalid GeoJSON file.");
        return null;
      } 
      else if (!"FeatureCollection".equals(geojson.getString("type", "undefined"))) 
      {
        println("WARNING: GeoJSON file doesn't contain feature collection.");
        return null;
      }
    
      JSONArray features = geojson.getJSONArray("features");
      
      if (features == null) 
      {
        println("WARNING: GeoJSON file doesn't contain any feature.");
      }
      
      if(features != null)
      {
         JSONArray coord;
         JSONObject feature, geometry;
         Map3D.GeoPoint gp;
         Map3D.ObjectPoint op;
         
         for(int foo=0; foo < features.size(); foo++)
         {
           feature = features.getJSONObject(foo);
           geometry = feature.getJSONObject("geometry");
           coord = geometry.getJSONArray("coordinates");
           
           gp = this.map.new GeoPoint(coord.getFloat(0),coord.getFloat(1));
           
           if(gp.inside())
           {
              op = this.map.new ObjectPoint(gp);
              points.add(op.toVector());
           }
           
         }
         
        
      }
        
      return points;
  }
  
}
