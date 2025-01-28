#version 300 es
//Some obligatory sines for color control and variance.
//There's a trade-off in complexity between
//the vertex and fragment shaders.
//But even simple things give rise
//to mesmerizing dynamics.
//For a sketch named after Nodal, there sure is
// a lack of right/left handedness.
// KM, 1/27/25,
// Celebrating the 2-year anniversary of the Lunar Aquarium
#define PI 3.1415926535897932384626433832795
precision mediump float;

in vec2 v_uv;
in float v_amp;
in float v_deriv;

out vec4 fragColor;

uniform vec2 u_res;
uniform float u_time;


float random(vec2 st)
{
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

float sin01(float x) {
  return 0.5*sin(x) + 0.5;
}

void main() {
  vec2 uv = (v_uv + 1.0)/2.0;
  uv.y /= u_res.x/u_res.y;
  vec3 col1 = vec3(0.,0.678 * sin01(0.002*u_time),0.71);
  vec3 col2 = vec3(1. * sin01(0.003*u_time),0.341,0.133);
  vec3 col3 = mix(col1, col2, v_amp);
  fragColor = vec4(col3, 1.0);
}