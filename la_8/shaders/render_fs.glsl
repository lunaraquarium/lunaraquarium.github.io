//Similar color rendering setup as was used in Aquarium #6
//Additive vector colors give a "firefly-esque" aesthetic
//KM, 6/18/23

uniform float uTime;
varying vec3 vPos;
void main()
{
	vec3 col1 = vec3(0.,0.706,0.298);
	float sf = 0.03/distance(gl_PointCoord, vec2(0.5));
	sf *= smoothstep(0.06,0.07, sf);
	vec3 endCol = mix(vec3(0.0), col1, pow(sf, 1.25));
	gl_FragColor = vec4(endCol, 1.0);
}