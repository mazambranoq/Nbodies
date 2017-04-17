//Simulation of N-Bobies adapted from: 
// Processing Example  
// Gravitational Attraction (3D) 
// Daniel Shiffman <http://www.shiffman.net>

// A class for an orbiting Planet

class Planet {

  // Basic physics model (position, velocity, acceleration, mass)
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  color PColor;
  final float G = 0.66;
  
  Planet(){
  }
  
  Planet(float m, float x, float y, float z, color c) {
    PColor = c;
    mass = m;
    position = new PVector(x, y, z);
    velocity = new PVector(1, 0);   // Arbitrary starting velocity
    acceleration = new PVector(0, 0);
  }

  PVector attract(Planet m) {
    PVector force = PVector.sub(position, m.position);    // Calculate direction of force
    float d = force.mag();                               // Distance between objects
    d = constrain(d, 5.0, 25.0);                         // Limiting the distance to eliminate "extreme" results for very close or very far objects
    float strength = (G * mass * m.mass) / (d * d);      // Calculate gravitional force magnitude
    force.setMag(strength);                              // Get force vector --> magnitude * direction
    return force;
  }
  
  // Newton's 2nd Law (F = M*A) applied
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  // Our motion algorithm (aka Euler Integration)
  void update() {
    velocity.add(acceleration); // Velocity changes according to acceleration
    position.add(velocity);     // position changes according to velocity
    acceleration.mult(0);
  }

  // Draw the Planet
  void display() {
    noStroke();
    fill(PColor);
    pushMatrix();
    translate(position.x, position.y, position.z);
    sphere(mass*8);
    popMatrix();
  }
}