//Render fragment shader, computes colors for each particle
//based on the particles' xy position vector
//actually the "yx" vector.
//Wait, are "xy" and "yx" the same?
//Am I going insane?
//All of the above?
//Swizzle?
//KM, 6/9/23 

uniform float uTime;
varying vec3 vPos;
void main()
{
	vec3 col1 = vec3(0.161,0.635,1.);//vec3(1.,0.02,0.231);
	vec3 col2 = vec3(1.,0.773,0.357);//vec3(1.0,1.0,1.0);//vec3(0.,0.416,1.);
	vec3 posV = normalize(vPos);
	vec3 plotCol = mix(col1, col2, length(posV.yx));
	gl_FragColor = vec4(plotCol, 1.0);
}