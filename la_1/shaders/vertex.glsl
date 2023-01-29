// -KM, 1/28/23

varying vec2 vUv;
void main()
{
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}