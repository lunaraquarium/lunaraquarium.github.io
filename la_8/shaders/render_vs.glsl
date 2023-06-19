uniform float uTime;
uniform sampler2D positions;
varying vec3 vPos;
void main()
{
 vec3 pos = texture2D(positions, position.xy).xyz;
 vPos = pos;
 vec4 modelPosition = modelMatrix * vec4(pos, 1.0);
 vec4 viewPosition = viewMatrix * modelPosition;
 vec4 projectedPosition = projectionMatrix *viewPosition;
 gl_Position = projectedPosition;

 gl_PointSize = 20.0;
 gl_PointSize *= (1.0 /-viewPosition.z); // size attenuation
}