//rotation parameters
float pivotX=30, pivotY=20;
float beta = 0;
//rendering mode
boolean shaderMode = true;
//unal shader stuff
PShader unalShader;
PMatrix3D modelview, projection;
PMatrix3D projectionTimesModelview;

void setup() {
  size(700, 700, P2D);
  modelview = new PMatrix3D();
  projection = new PMatrix3D();
  projection.m00 = 2.0f / width;
  projection.m11 = -2.0f / height;
  projection.m22 = -1;
  projectionTimesModelview = new PMatrix3D();
  unalShader = loadShader("frag.glsl", "vert.glsl");
  println("Unal shader loaded");
}

void draw() {
  background(0);
  if (shaderMode) {
    //discard Processing matrices is only necessary in P3D
    //resetMatrix();
    //load identity
    modelview.reset();
    // we do the rotation as: T(xr,yr)Rz(β)T(−xr,−yr)
    // http://visualcomputing.github.io/Transformations/#/5/17
    // 1. T(xr,yr)
    modelview.translate(pivotX, pivotY);
    // 2. Rz(β)
    modelview.rotate(radians(beta));
    // 3. T(−xr,−yr)
    modelview.translate(-pivotX, -pivotY);
    //set initial model-view and projection proscene matrices
    emitUniforms();
  } else {
    // move origin to the center of the screen:
    translate(width/2, height/2);
    // we do the rotation as: T(xr,yr)Rz(β)T(−xr,−yr)
    // http://visualcomputing.github.io/Transformations/#/5/17
    // 1. T(xr,yr)
    translate(pivotX, pivotY);
    // 2. Rz(β)
    rotate(radians(beta));
    // 3. T(−xr,−yr)
    translate(-pivotX, -pivotY);
  }
  pivot();
  lShape();
}

void keyPressed() {
  if (key != '+' && key != '-' && key != ' ')
    return;
  if (key == '+')
    beta += 1;
  if (key == '-')
    beta -= 1;
  if (key == ' ') {
    shaderMode = !shaderMode;
    if (shaderMode) {
      unalShader = loadShader("frag.glsl", "vert.glsl");
      println("Unal shader loaded");
    } else {
      resetShader();
      println("Processing default shader loaded");
    }
  }
}

void pivot() {
  pushStyle();
  stroke(0, 255, 255);
  strokeWeight(6);
  point(pivotX, pivotY);
  popStyle();
}

void lShape() {
  pushStyle();
  fill(204, 102, 0, 150);
  rect(50, 50, 200, 100);
  rect(50, 50, 100, 200);
  popStyle();
}

//Whenever the model-view or projection matrices changes we need to emit the uniforms
void emitUniforms() {
  shader(unalShader);
  projectionTimesModelview.set(projection);
  projectionTimesModelview.apply(modelview);
  projectionTimesModelview.transpose();
  unalShader.set("unalMatrix", projectionTimesModelview);
}