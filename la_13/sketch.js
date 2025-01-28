// An experiment with vertex shaders in p5.js, and
//also an experiment with WEBGL2.
//Sketch protected by the ultimate defense against plagiarism:
//"Quality so crap, it isn't worth plagiarizing"
//But if you find something interesting here,
//copy it and credit the Lunar Aquarium before a large language model finds out!
//KM, always free of AI - 1/27/25
let t;
let params = {};
let count = 5000.0;
let zoom = 0.003;
function preload() {
  t = loadShader('vert.glsl', 'frag.glsl');
}

function setup() {
  pixelDensity(1);
  createCanvas(800, 800, WEBGL);
  let gui = new GUI();
  gui.title("Nodal - KM, 1/27/25");
}

function draw() {
  background(0);
  t.setUniform('u_res', [width, height]);
  t.setUniform('u_time', frameCount);
  t.setUniform('u_zoom', zoom);
  t.setUniform('u_count', count);

  shader(t);
  noStroke();
  
  beginShape(TRIANGLES);
  for (let i = 0; i < count; i++) {
    vertex(-zoom, -zoom);
    vertex(-zoom, zoom);
    vertex(zoom, zoom);

    vertex(-zoom, -zoom);
    vertex(zoom, zoom);
    vertex(zoom, -zoom);
  }
  endShape(); 


}

// Operate in WEBGL2, credits: https://github.com/processing/p5.js/issues/2536#issuecomment-1332668754
p5.RendererGL.prototype._initContext = function() {
  this.drawingContext = false ||
    this.canvas.getContext('webgl2', this.attributes) ||
    this.canvas.getContext('webgl', this.attributes) ||
    this.canvas.getContext('experimental-webgl', this.attributes);
  let gl = this.drawingContext;
  gl.enable(gl.BLEND);
  gl.blendFunc(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA);
};
