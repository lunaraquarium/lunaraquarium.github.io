//Simulation Vertex Shader
//Nothing too complex here - retrieves the uvs from the simulation material and
//passes it onward to the fragment shader,
//where the magic (hopefully) happens
//KM, 6/9/23

varying vec2 vUv;
void main() {
    vUv = vec2(uv.x, uv.y);
    gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );
}