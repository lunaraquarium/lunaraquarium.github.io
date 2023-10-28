//This is the display fragment shader.
//Pixel states are computed in the simulation fragment shader (an ersatz "compute shader"),
//and rendered to a frame buffer.
//This shader takes the RGB values of each pixel (skipping the alpha channel, which contains information about live/dead pixels and not color info)
//and renders them to the screen.
//Ping-pong complete.
//-KM, 10/27/23

precision mediump float;
uniform sampler2D uTexture;
uniform vec3 uResolution;
varying vec2 vUv;

void main() {
    vec4 initTexture = texture2D(uTexture, vUv);
    vec3 col = initTexture.rgb;
    gl_FragColor = vec4( col,1.0 );
}