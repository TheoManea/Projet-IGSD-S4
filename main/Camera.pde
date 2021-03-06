class Camera 
{
  
   float radius; //Le rayon de la sphère virtuelle
   float longitude, colatitude, latitude; // angles définissant la postion des la caméra en coordonnées sphériques
   float x,y,z; // coordonnées cartésiennes déterminées à partir des angles et du radius  
   boolean lighting; //Booleen indiquand si on ajoute la luminosité ou non
  
  
  /**
  * Constructeur de Camera 
  **/
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
   
   /**
   * Méthode pour afficher la caméra
   **/
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
   
   /**
   * Gestion du rayon de la sphère
   * @param offset : la variation à modifier sur le rayon
   **/
   public void adjustRadius(float offset)
   {
     if(this.radius + offset < width * 3.0 && this.radius + offset > width*0.5)
     {
           this.radius = this.radius + offset;
           this.x = this.radius * sin(this.longitude) * cos(this.colatitude);
           this.y = this.radius * sin(this.longitude) * sin(this.colatitude);
           this.z = this.radius * cos(this.longitude);
     }
     
     
   }
   
   
   /**
   * Gestion de la longitude
   * @param delta : la variation à modifier sur la longitude
   **/
   public void adjustLongitude(float delta)
   {
     if(this.longitude+delta > 0 && this.longitude+delta < PI/2)
     {
       this.longitude = (this.longitude + delta) ; 
       this.x = this.radius * sin(this.longitude) * cos(this.colatitude);
       this.y = this.radius * sin(this.longitude) * sin(this.colatitude);
       this.z = this.radius * cos(this.longitude);
     }
     
     
   }
   
   /**
   * Gestion de la colatitude
   * @param delta : la variation à modifier sur la colitude
   **/
   public void adjustColatitude(float delta)
   {
     if(this.colatitude + delta > -2*PI && this.colatitude + delta < 2*PI)
     {
       this.colatitude = (this.colatitude + delta) ;
       this.x = this.radius * sin(this.longitude) * cos(this.colatitude);
       this.y = this.radius * sin(this.longitude) * sin(this.colatitude);
       this.z = this.radius * cos(this.longitude);
     }
     
   }
  
  /**
  * Méthode pour rendre la lumière visible
  */
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
