#version 300 es
//In a universe of motion,
//the "motionless" can be interesting,
//if approached with an open mind.
//Each "particle" is defined as a small square,
//2 triangles from 6 vertices each,
//making 60000 vertices.
//Mix some sines and cosines, and the result
//is reminiscent of bioluminescent algae
//trailing beyond the wake of a redoubtable vessel.
//KM, 1/27/25
precision mediump float;

in vec3 aPosition;
in vec2 aTexCoord;

out vec2 v_uv;
out float v_amp;
out float v_deriv;

uniform float u_time;
uniform float u_zoom;
uniform float u_count;
float random(vec2 st)
{
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

float wave(float x){
    //float a = 0.2*sin(0.01*u_time);
    float b = 2.0*sin(0.002*u_time);
    return (sin(x) + cos(x) + cos(0.1*x + b) + sin(5.0*x))/4.0;
}

void main() {
    float squ_id = floor(float(gl_VertexID)/6.0);
    float pct = squ_id / (u_count - 1.0);
    vec4 pos = vec4(aPosition, 1.0);
    pos.x += (2.0 - 2.0*u_zoom) * (pct - 0.5);
    float amp = 1.2*wave(0.003*u_time + pct*1.0)*2.0*(random(vec2(pct)) - 0.5);
    pos.y += amp;
    gl_Position = pos;
    v_uv    = aPosition.xy;
    v_amp = 0.5*(amp/0.5)+0.5;
    v_deriv = abs(cos(0.03*u_time + pct*5.0));
}