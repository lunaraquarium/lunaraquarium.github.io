// This sketch doesn't use FBO, but this is included anyways for the lolz
// KM, 5/15/24

precision mediump float;
uniform sampler2D uTexture;
uniform vec3 uResolution;
varying vec2 vUv;

void main() {
    vec4 inputTexture = texture2D(uTexture, vUv);
    vec3 colTex = inputTexture.rgb;
    gl_FragColor = vec4( colTex,1.0 );
}
