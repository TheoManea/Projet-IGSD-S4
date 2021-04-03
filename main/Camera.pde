class Camera 
{
  
   float radius; //Le rayon de la sphère virtuelle
   float longitude, colatitude, latitude; // angles définissant la postion des la caméra en coordonnées sphériques
   float x,y,z; // coordonnées cartésiennes déterminées à partir des angles et du radius  
   boolean lighting;
  
   public  Camera()
   {
     this.radius = 3000.0;
     this.latitude = PI/2;
     this.colatitude = PI/2 - this.latitude ; // phi
     this.longitude = PI/3; //theta
     this.x = this.radius * sin(this.longitude) * cos(this.colatitude);
     this.y = this.radius * sin(this.longitude) * sin(this.colatitude);
     this.z = this.radius * cos(this.longitude);
     this.lighting = false;
     
   }
   
   public void update(){
    camera(
      this.x, -this.y, this.z,
      0, 0, 0,
      0, 0, -1
      );
    ambientLight(0x7F, 0x7F, 0x7F);
    if (lighting)
     directionalLight(0xA0, 0xA0, 0x60, 0, 0, -1);
    lightFalloff(0.0f, 0.0f, 1.0f);
    lightSpecular(0.0f, 0.0f, 0.0f);
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
  
   public void toggle()
   {
     this.lighting = (!this.lighting);
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
