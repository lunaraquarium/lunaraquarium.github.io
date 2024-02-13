// With this pomegranate, I endeavor to quench my thirst.
// This sketch is protected by the ultimate defense against plagiarism:
// "quality so crap, it ain't worth stealing"
// But feel free to copy any part of the sketch if you find it useful/interesting
// Bonus points for crediting the Lunar Aquarium!
// -KM, 2/12/24

let params = {};
let testShader;
function preload() {
  // shaders loaded here
  testShader = loadShader('s1.vert', 's1.frag');
}
function setup() {
  pixelDensity(1);
  // canvas, buffers
  createCanvas(windowWidth, windowHeight, WEBGL);  
  buffer1 = createGraphics(width, height, WEBGL);
  // gui ctls
  let gui = new GUI();
  gui.title("Pomegranate - KM, 2/12/24")
  params.b = 0.0;
  params.c = 0.04;
  gui.add(params, "c", 0.001, 0.1, 0.0001).name("Blink Freq.");
  // geometry ctls
  noStroke();
  buffer1.noStroke();
}

function draw() {
  let resol = width/height;
  let mx = map(mouseX, 0, width, ((0 - 0.5)*resol)+0.5, (0.5*resol + 0.5));
  let my = map(mouseY, 0, height, 1, 0);

  buffer1.shader(testShader);
  testShader.setUniform('c', params.c);
  testShader.setUniform('t', frameCount);
  testShader.setUniform('m', [mx, my]);
  testShader.setUniform('resol', resol);
  buffer1.rect(0,0,width,height);

  image(buffer1, -width/2,-height/2,width,height);
}
// event handling fxns
function windowResized() {
  resizeCanvas(windowWidth, windowHeight);
}