class Camera 
{
  
   float radius; //Le rayon de la sphère virtuelle
   float longitude, colatitude, latitude; // angles définissant la postion des la caméra en coordonnées sphériques
   float x,y,z; // coordonnées cartésiennes déterminées à partir des angles et du radius  
  
   public  Camera()
   {
     this.radius = 2000.0;
     this.latitude = PI/2;
     this.colatitude = PI/2 - this.latitude ; // phi
     this.longitude = 3*PI/4; //theta
     this.x = this.radius * sin(this.longitude) * cos(this.colatitude);
     this.y = this.radius * sin(this.longitude) * sin(this.colatitude);
     this.z = this.radius * cos(this.longitude);
     
     
   }
   
   public void update(){
    camera(
      this.x, -this.y, this.z,
      0, 0, 0,
      0, 0, -1
      );
    
  }
   
   public void adjustRadius(float offset)
   {
     this.radius = this.radius + offset;
     this.x = this.radius * sin(this.longitude) * cos(this.colatitude);
     this.y = this.radius * sin(this.longitude) * sin(this.colatitude);
     this.z = this.radius * cos(this.longitude);
   }
   
   public void adjustLongitude(float delta)
   {
     this.longitude = this.longitude + delta; 
     this.x = this.radius * sin(this.longitude) * cos(this.colatitude);
     this.y = this.radius * sin(this.longitude) * sin(this.colatitude);
     this.z = this.radius * cos(this.longitude);
   }
   
   public void adjustColatitude(float delta)
   {
     this.colatitude = this.colatitude + delta;
     this.x = this.radius * sin(this.longitude) * cos(this.colatitude);
     this.y = this.radius * sin(this.longitude) * sin(this.colatitude);
     this.z = this.radius * cos(this.longitude);
   }
  
  void keyPressed() 
  {
    
    if (key == CODED) 
      {
       switch (keyCode) 
        {
         case UP:
         adjustRadius(100);
         break;
         case DOWN:
         adjustRadius(-100);
         break;
         case LEFT:
         adjustLongitude(-100);
         break;
         case RIGHT:
         adjustLongitude(100);
         break;
        }
     } 
     else 
     {
      switch (key) 
      {
        
        case '+':
        
        break;
        case '-':
       
        break;
       }
      }
  }

}
