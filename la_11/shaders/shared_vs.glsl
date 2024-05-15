// A standard vertex shader, nothing much else
//But since you're here, here's a haiku:
// Yo, why are you here?
// The great depths of outer space
// are calling your name!
// KM, 5/14/24

varying vec2 vUv;
void main() {
    vUv = vec2(uv.x, uv.y);
    gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );
}
