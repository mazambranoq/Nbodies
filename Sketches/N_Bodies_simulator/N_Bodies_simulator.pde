/**
 * Simulation of N-Bobies adapted from: 
 * Processing Example  
 * Gravitational Attraction (3D) 
 * Daniel Shiffman <http://www.shiffman.net>
 * 
 * Simulating gravitational attraction 
 * G ---> universal gravitational constant
 * m1 --> mass of object #1
 * m2 --> mass of object #2
 * d ---> distance between objects
 * F = (G*m1*m2)/(d*d)
 */

// A bunch of planets
Planet[] planets = new Planet[10];
Sun s;
Boolean sun = true;
Boolean fixed = true;
 
// An angle to rotate around the scene
float angleY = 0;
float angleZ = 0;

void setup() {
  size(640, 360, P3D);
  // Some random planets
  for (int i = 0; i < planets.length; i++) {
    color c = color(random(0,255), random(0,255), random(0,255),random(0,255));
    planets[i] = new Planet(random(0.1, 2), random(-width/2, width/2), random(-height/2, height/2), random(-100, 100), c);
  }
  // A single sun
  s = new Sun();
  camera(640,360, 0, 0, 0, 0, 1, 0, 0);
}

void draw() {
  background(0);
  // Setup the scene
  sphereDetail(50);
  lights();
  translate(width/2, height/2);
  rotateY(angleY);
  rotateZ(angleZ);
  stroke(125);
  noFill();
  sphere(400);

  // Display the Sun
  if(sun){
    for (Planet planet : planets){
        PVector force = s.attract(planet);
        planet.applyForce(force);
        s.applyForce(planet.attract(s));
      }
      if (!fixed){
        s.update();
      }
      s.display();
  }
  // Every Planet attracts each other
  for (Planet planet1 : planets) {
    for (Planet planet : planets){
      PVector force = planet1.attract(planet);
      planet.applyForce(force);
      
    }
  }
  for (Planet planet : planets){
  // Update and draw Planets
    planet.update();
    planet.display();
  }
  camera(640+mouseY,360,0,0,0,0,1,1,0);
}
void keyPressed() {
  if (key == 's' || key == 'S')
    sun = !sun;
  if (key == 'f' || key == 'F')
    fixed = !fixed;
  if (key == CODED) {
    if (keyCode == LEFT)
      angleY -= 0.1;
    if (keyCode == RIGHT)
      angleY += 0.1;
    if (keyCode == UP)
      angleZ += 0.1;
    if (keyCode == DOWN)
      angleZ -= 0.1;
  }
}