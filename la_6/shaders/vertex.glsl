//A quick vertex shader that controls particle movement and
//calculates a parameter related to the distance of each particle to the origin,
//accomplishing in less than 20 lines a task that I could only dream of in p5js.
//May the 4th be with you!
//-KM, 5/4/23



varying float vZ;
varying float vDistNorm;
uniform float uMt;
uniform float uTime;
attribute float ampOffset;
attribute float freqOffset;
void main()
{
 vec4 modelPosition = modelMatrix * vec4(position, 1.0);
 float amp = 0.4;
 modelPosition.xyz += modelPosition.xyz*sin(0.5*uTime*freqOffset)*amp*ampOffset;
 vDistNorm = pow(length(modelPosition.xyz), 3.0);
 vec4 viewPosition = viewMatrix * modelPosition;
 vec4 projectedPosition = projectionMatrix *viewPosition;
 gl_Position = projectedPosition;

 gl_PointSize = 30.0;
 gl_PointSize *= (1.0 /-viewPosition.z); // size attenuation
}
