//The Classic Lorenz Attractor:
//discovered by the meterologist-mathematician Edward Lorenz and the computer scientists Ellen Fetter and Margaret Hamilton,
//and which marked the beginning of a new era:
//chaos
//A simulation with 40000 particles!
//KM, 6/9/23

uniform sampler2D positions;
uniform float uTime;
uniform float uSim_rate;
varying vec2 vUv;
void main() {
 
    
    vec3 pos = texture2D( positions, vUv ).rgb;
    //The classic Lorenz system
    float sigma = 10.0;
    float beta = 8.0/3.0;
    float rho = 28.0;

    vec3 del = vec3(sigma*(pos.y - pos.x), pos.x*(rho - pos.z) - pos.y, pos.x*pos.y - beta*pos.z);
    pos += del*uSim_rate;
    
    gl_FragColor = vec4( pos,1.0 );
}