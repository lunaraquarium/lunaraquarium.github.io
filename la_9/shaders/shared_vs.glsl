// Vertex shader (used in the simulation and display phases of the render cycle)
// Retrieves UVs and passes them to the respective fragment shaders
// -KM, 10/27/23

varying vec2 vUv;
void main() {
    vUv = vec2(uv.x, uv.y);
    gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );
}