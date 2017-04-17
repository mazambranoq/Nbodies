//Simulation of N-Bobies adapted from: 
// Processing Example  
// Gravitational Attraction (3D) 
// Daniel Shiffman <http://www.shiffman.net>


class Sun extends Planet{

  Sun() {
    super(20, 0, 0, 0, color(255, 255, 0));
  }

  // Draw Sun
  void display() {
    stroke(PColor);
    noFill();
    pushMatrix();
    translate(position.x, position.y, position.z);
    sphere(mass*2);
    popMatrix();
  }
}