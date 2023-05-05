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