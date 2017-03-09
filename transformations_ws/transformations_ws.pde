PShader unalShader;
PMatrix3D matrix;
void setup() {
  size(700, 700, P2D);
  matrix = new PMatrix3D();
  unalShader = loadShader("frag.glsl", "vert.glsl");
}

void draw() {
  background(0);
  //discard Processing matrices
  //resetMatrix();
  //set initial model-view and projection proscene matrices
  //setUniforms();
  fill(204, 102, 0, 150);
  rect(50,50,200,200);
  /*
  scene.drawTorusSolenoid();
  scene.pushModelView();
  scene.applyModelView(iFrame.matrix());
  //iFrame.applyTransformation();//also possible here
  //model-view changed:
  setUniforms();
  if (scene.motionAgent().defaultGrabber() == iFrame) {
    fill(0, 255, 255);
    scene.drawTorusSolenoid();
  }
  else if (iFrame.grabsInput(scene.motionAgent())) {
    fill(255, 0, 0);
    scene.drawTorusSolenoid();
  }
  else {
    fill(0, 0, 255, 150);
    scene.drawTorusSolenoid();
  } 
  scene.popModelView();
  */
}

//Whenever the model-view (or projection) matrices changes
// we need to update the shader:
void setUniforms() {
  shader(unalShader);
  matrix.reset();
  unalShader.set("unalModelMatrix", matrix);
}