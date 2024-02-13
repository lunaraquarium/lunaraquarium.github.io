// Ooh fancy new attributes from p5js!
// (if "fancy" is defined as "sparsely documented")
// -KM, 2/12/24

attribute vec3 aPosition;
attribute vec2 aTexCoord;
varying vec2 vUv;

void main() {
    vUv = aTexCoord;
    vec4 positionVec4 = vec4(aPosition, 1.0);
    positionVec4.xy = positionVec4.xy*2.0 -1.0;
    gl_Position = positionVec4;
}