class Gpx
{
  
   PShape track, posts, thumbtacks;
   Map3D map;
  
   public Gpx(Map3D myMap)
   {
             this.map = myMap;
             
             //On initialise les trois PShape
             this.track = createShape();
             this.track.beginShape();
             
             this.posts = createShape();
             this.posts.beginShape(LINES);
             this.thumbtacks = createShape();
             this.thumbtacks.beginShape(POINTS);
             
             this.track.strokeWeight(2);
             this.track.stroke(144,238,144);
             this.posts.strokeWeight(1.5);
             this.thumbtacks.stroke(255,0,0);
             this.thumbtacks.strokeWeight(8);
            
             int heightPost = 100;
     
     
            String fileName = "trail.geojson";
            
            // Check ressources
            File ressource = dataFile(fileName);
            
            if (!ressource.exists() || ressource.isDirectory()) 
            {
             println("ERROR: GeoJSON file " + fileName + " not found.");
             return;
            }
            
            // Load geojson and check features collection
            JSONObject geojson = loadJSONObject(fileName);
            
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
            JSONArray features = geojson.getJSONArray("features");
            if (features == null) 
            {
             println("WARNING: GeoJSON file doesn't contain any feature.");
             return;
            }
            
           
            
            
            
            
            
            for (int f=0; f<features.size(); f++) 
            {
              
             JSONObject feature = features.getJSONObject(f);
             if (!feature.hasKey("geometry"))
               break;
             JSONObject geometry = feature.getJSONObject("geometry");
             
             switch (geometry.getString("type", "undefined")) {
               
             case "LineString":
             // GPX Track
               JSONArray coordinates = geometry.getJSONArray("coordinates");
               if (coordinates != null)
                 for (int p=0; p < coordinates.size(); p++) 
                 {
                   JSONArray point = coordinates.getJSONArray(p);
                   Map3D.GeoPoint geopoint = this.map.new GeoPoint(point.getFloat(0),point.getFloat(1));
                   Map3D.ObjectPoint objPoint = this.map.new ObjectPoint(geopoint);
                   this.track.vertex(objPoint.x,objPoint.y,objPoint.z);
                   
                   
                   //println("Track ", p, point.getDouble(0), point.getDouble(1));
                 }
             break;
             
             
             case "Point":
             
               // GPX WayPoint
               if (geometry.hasKey("coordinates")) 
               {
                 JSONArray point = geometry.getJSONArray("coordinates");
                 String description = "Pas d'information.";
                 if (feature.hasKey("properties")) 
                 {
                   description = feature.getJSONObject("properties").getString("desc", description);
                 }
                 Map3D.GeoPoint geopoint = this.map.new GeoPoint(point.getFloat(0),point.getFloat(1));
                 Map3D.ObjectPoint objPoint = this.map.new ObjectPoint(geopoint);
                 this.posts.vertex(objPoint.x,objPoint.y,objPoint.z);
                 this.posts.vertex(objPoint.x,objPoint.y,objPoint.z+heightPost);
                 this.thumbtacks.vertex(objPoint.x,objPoint.y,objPoint.z+heightPost);
                 
                 
                 //println("WayPoint", point.getDouble(0), point.getDouble(1), description);
               }
             break;
             
            default:
             println("WARNING: GeoJSON '" + geometry.getString("type", "undefined") + "' geometry type not handled.");
             break;
             }
             
         }
       
       this.track.endShape();
       this.thumbtacks.endShape();
       this.posts.endShape();
 
 
     }
     
     
     
     void update()
     {
        shape(this.track);
        shape(this.thumbtacks);
        shape(this.posts);
        
     }
     
     
     void toggle()
     {
        this.track.setVisible(!this.track.isVisible());
        this.thumbtacks.setVisible(!this.thumbtacks.isVisible());
        this.posts.setVisible(!this.posts.isVisible());
       
     }
     
     
     
  
}
