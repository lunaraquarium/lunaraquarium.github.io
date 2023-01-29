// A pattern was found ...
// ... this pattern was tiled ...
//.. then, each tile was phase-shifted with another pattern
// Feel free to reuse any part of the following code
// Bonus points for crediting "Lunar Aquarium" or "KM"
// -KM, 1/28/23


varying vec2 vUv;
uniform float uFreq;
uniform float uTime;
float random(vec2 st)
{
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}



void main()
{
    vec2 multUv = fract(vUv * 20.0);
    vec2 c = floor(vUv * 20.0);
    vec2 phase = c/40.0;
    float phaseLen = length(c);
    float theta = distance(multUv, vec2(0.5));
    //float strength = sin(8.0* theta + 7.0* (-phase.x - phase.y) + 1.5*uTime);
    float strength = sin(8.0* theta - 0.25*phaseLen + 1.5*uTime*uFreq);
    vec3 bkg1 = vec3(0.0/255.0, 12.0/255.0, 102.0/255.0);  
    vec3 tgt1 = vec3(0.0/255.0, 255.0/255.0, 255.0/255.0); 
    vec3 colorMix = mix(bkg1, tgt1, strength);
    gl_FragColor = vec4(colorMix, 1.0);
}