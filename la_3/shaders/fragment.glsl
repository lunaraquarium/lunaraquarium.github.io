/* A vexing truth: randomness is a lie.
   The trick is to convince the brain
   that what the eyes are seeing is 
   random, when it actually isn't. 
   One way is to use a whole bunch of sines.
   Sines, sines, give me a sign.
   (actually don't, GLSL colors run between 0.0 and 1.0 lol)
   No copyright, bonus points for crediting "Lunar Aquarium" or "KM"
   -KM, 1/29/23 
 */

varying vec2 vUv;
uniform float uTime;
uniform float uMt;

void main()
{
    vec2 c = vUv;
    c.y += 0.05*sin((0.2*c.x + c.y) * 8.0 + uTime)*sin(5.0*c.x);
    float i = floor(c.y * 5.0);
    float j = floor(c.x * 2.0);
    float f = fract(c.y*5.0);
    float g = fract(vUv.x*2.0 -uTime);
    float x = (1.0 - abs(2.0*f - 1.0));
    vec3 c1 = vec3(255.0/255.0, 83.0/255.0, 10.0/255.0);
    vec3 c2 = vec3(0.0/255.0, 164.0/255.0, 247.0/255.0);
    vec3 tgt = mix(c1, c2, (((vUv.x + sin(uMt*0.3*uTime)) + (vUv.y + sin(uMt*0.3*uTime)))/2.0));
    vec3 col = mix(vec3(0.0), tgt, x);
    gl_FragColor = vec4(col, 1.0);
}