precision mediump float;
uniform sampler2D uTexture;
uniform vec3 uResolution;
varying vec2 vUv;

void main() {
    vec4 inputTexture = texture2D(uTexture, vUv);
    vec3 colTex = inputTexture.rgb;
    gl_FragColor = vec4( colTex,1.0 );
}