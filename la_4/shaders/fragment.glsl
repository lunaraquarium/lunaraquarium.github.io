/* 
    Several aspects of this shader are controlled by dedicated periodic functions,
    which allows for quite a bit of fluid-like features to be implemented,
    my favorite being the interesting alternation between a set of orderly flow fields
    and an array of "random-esque" fireflies.
    No copyright, bonus points for crediting "Lunar Aquarium" or "KM"!
    -KM, 2/2/23
 */

varying vec2 vUv;
uniform float uTime;
uniform float uMt;
float random(vec2 st) //Credit: Patricio Gonzalez Vivo, "The Book of Shaders".
// Generates pseudorandom numbers, emphasis on the pseudo. 
{
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}
void main()
{
    float numLines = 20.0;
    vec2 c = vUv;
    c.y += 0.05*sin((0.2*c.x + c.y) * 8.0 - 1.1*uTime)*sin(5.0*c.x)*sin(7.0*c.x + c.y + uTime);
    float sf = vUv.x + uTime*0.1;
    c.y += (sin(sf)*sin(2.0*sf)*cos(2.0*sf)) / 2.8 + 0.5;;
    float i = floor(c.y * numLines);
    float f = fract(c.y*numLines);
    float g = fract(c.x*(7.0*sin(uTime*0.2) + 9.0) -uTime*2.0*random(vec2(i)) - uTime);
    float x = (1.0 - abs(2.0*f - 1.0));
    float y = (1.0 - abs(2.0*g - 1.0));
    float val = smoothstep(0.75, 0.9, x) * smoothstep(0.75, 0.9, y);
    vec3 tgt1 = vec3(0.761,0.082,0.);
    vec3 tgt2 = vec3(1.,0.773,0.);
    vec3 tgt3 = vec3(0.263,0.808,0.635);
    vec3 tgt4 = vec3(0.094,0.353,0.616);
    vec3 tgta = mix(tgt1, tgt2, vUv.y);
    vec3 tgtb = mix(tgt4, tgt3, vUv.y);
    vec3 tgtc = mix(tgtb, tgta, 0.5*sin(0.4*(uTime + vUv.x + vUv.y)) + 0.5);
    vec3 col = mix(vec3(0.0), tgtc, val);
    gl_FragColor = vec4(col, 1.0);
}