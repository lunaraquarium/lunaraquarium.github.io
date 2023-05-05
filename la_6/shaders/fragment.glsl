//Here, color is controlled in two ways:
//1. using the distance from the world origin (0,0,0).
//2. using the uv of each point within each vertex (gl_PointCoord)
//Add some sines and the result is something simultaneously mechanical and dreamy.
// - KM, 5/4/23

uniform float uTime;
uniform float uMt;
varying float vDistNorm;


void main()
{
	vec3 centerCol = vec3(1.,0.02,0.231);
	vec3 edgeCol = vec3(0.,0.416,1.);
	float creepFactor = 0.15 + 0.1*sin(uTime *0.6);
	float strC = clamp(creepFactor/vDistNorm, 0.0, 1.0);
	vec3 colC = mix(edgeCol, centerCol, strC);
	float strPt = 0.03/distance(gl_PointCoord, vec2(0.5));
	strPt *= smoothstep(0.06,0.07, strPt); //any value less than 0.06 is quickly faded to 0, eliminating most of the square shadow
	vec3 colPt = mix(vec3(0.0),colC, pow(strPt, 1.25));
	gl_FragColor = vec4(colPt, 1.0);
}
