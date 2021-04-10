class Poi
{
  
  Land land;
  
  public Poi(Land givenLand)
  {
    
  }
  
  JSONArray getPoints(String nomFichier)
  {
    
    JSONArray toReturn = new JSONArray();
    
    
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
             return toReturn;
    } 
    else if (!"FeatureCollection".equals(geojson.getString("type", "undefined"))) 
    {
             println("WARNING: GeoJSON file doesn't contain features collection.");
             return toReturn;
    }
    
    // Parse features
    JSONArray features =  geojson.getJSONArray("features");
    if (features == null) 
    {
        println("WARNING: GeoJSON file doesn't contain any feature.");
        return toReturn;
      }
    
    
    for(int foo = 0; foo < features.size(); foo++)
    {
      JSONObject feature = features.getJSONObject(foo);
      
      if(!feature.hasKey("geometry"))
        break;
        
      JSONArray coordinates = feature.getJSONObject("geometry").getJSONArray("coordinates");
      toReturn.append(coordinates);
      //println(coordinates);
      
    }
    
    return toReturn;
  }
  
}
