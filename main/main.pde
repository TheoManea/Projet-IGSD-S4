void setup() {
   size(1000,500,P3D); 
   
   camera(
     0, 2500, 1000, 
     0, 0, 0, 
     0, 0, -1
     );
   
}

void draw() {
  
  //première étape on crée 3 lignes, bases du repère cartésien 
  stroke(255,0,0);
  line(0, 0, 0, 300, 0, 0); // axe x
  stroke(0,255,0);
  line(0, 0, 0, 0, 300, 0); // axe y
  stroke(0,0,255);
  line(0, 0, 0, 0, 0, 300); // axe z
  
  
}
