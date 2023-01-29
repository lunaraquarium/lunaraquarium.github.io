// And so it begins again ... this time several light-years closer to home
// The following code is under the Ultimate Plagiarism Defense
// "quality so crap, it is not worth plagiarizing"
// Feel free to use any part of the code, bonus points for crediting "Lunar Aquarium" or "KM"
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
    float freq = uFreq;
    float csq = -((8.0 - 1.0)/2.0) * sin(freq*uTime) + ((8.0 - 1.0)/2.0) + 1.0;
    float diamf = -((0.2 - 0.15)/2.0) * sin(freq*uTime) + ((0.2 - 0.015)/2.0) + 0.015;
    vec2 ySquash = vec2(vUv.x, (vUv.y - 0.5)*csq + 0.5);
    vec2 xSquash = vec2((vUv.x - 0.5)*csq + 0.5, vUv.y);    
    float strength1 = diamf/distance(ySquash, vec2(0.5));
    float strength2 = diamf/distance(xSquash, vec2(0.5));
    float strength = strength1 * strength2;
    vec3 targetCol = vec3(255.0/256.0, 200.0/256.0, 50.0/256.0);
    vec3 backgroundCol = vec3(0.0/256.0, 88.0/256.0, 183.0/256.0);
    vec3 tgt = mix(vec3(1.0), targetCol, sin(freq*uTime));
    vec3 bkg = mix(vec3(0.0, 0.0, 63.0/256.0), backgroundCol, sin(freq*uTime)); //vec3(0.0, 0.0, 63.0/256.0)
    vec3 colorMix = mix(bkg, tgt, strength);
    gl_FragColor = vec4(vec3(colorMix), 1.0); 
    


}