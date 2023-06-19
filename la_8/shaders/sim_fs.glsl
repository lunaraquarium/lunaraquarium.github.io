//The Aizawa (Langford) Chaotic Attractor
//As of the creation of this shader, the top 5 Google results pertaining to this system omit the e-containing term
//Whether this results in a stable attractor is up for debate, but doesn't produce the same shape as this one. 
//This system is particularly sensitive to "dt" - large time offsets lead to divergence.
//Shape reminiscent of the circulation of amniotic fluid in an embryo,
//a nostalgic throwback to Arcturus #4 !
//KM, 6/18/23



uniform sampler2D positions;
uniform float uTime;
uniform float uSim_rate;
uniform bool uBpause;
uniform float uA;
uniform float uB;
uniform float uC;
uniform float uD;
uniform float uE;
uniform float uF;
varying vec2 vUv;
void main() {
 
    float pause = (uBpause) ? 0.0 : 1.0;
    vec3 pos = texture2D( positions, vUv ).rgb;
    float a = uA;
    float b = uB;
    float c = uC;
    float d = uD;
    float e = uE;
    float f = uF;
    float dx = ((pos.z - b)*pos.x) - d*pos.y;
    float dy = d*pos.x + pos.y*(pos.z - b);
    float dz = c + a*pos.z - ((pos.z * pos.z * pos.z)/3.0) - ((pos.x * pos.x) + (pos.y*pos.y))*(1.0 + e*pos.z) + f*pos.z*(pos.x*pos.x*pos.x);
    vec3 del = vec3(dx,dy,dz);
    pos += uSim_rate*del*pause;   
    
    gl_FragColor = vec4( pos,1.0 );
}