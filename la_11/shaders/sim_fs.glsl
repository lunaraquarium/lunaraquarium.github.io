// This sketch uses curl noise and a process of ridge-lining to get sinuous, flowing lines
// It's reminiscent of a now-old HTML5 game that I used to love to play, in which
// the player controls a waving line amidst a field of evil red dots (sinuousgame.com, hope it still works)
// KM, 5/14/24


precision mediump float;
uniform sampler2D uTexture; 
uniform vec3 uResolution;
uniform vec2 uMouse;
uniform bool uClick;
uniform float uTime;
uniform float uVel;
varying vec2 vUv;
#include "noise_functions.glsl" //can find these function on "lygia.xyz"



void main() {
    vec2 st = vec2(vUv.x * (uResolution.x/uResolution.y), vUv.y);
    vec2 stMouse = vec2(uMouse.x * (uResolution.x/uResolution.y), uMouse.y);
    /* vec4 C = texture2D(uTexture, vUv);
    vec4 L = texture2D(uTexture, vUv + vec2(-1.0/uResolution.x, 0.0));
    vec3 col = C.rgb; */
    /* vec2 d2 = curl(vec2(st*2.0)) * 0.5 + 0.5; */
    vec3 d3 = curl(vec3(st*2.0, uTime*uVel));
    vec3 d3New = smoothstep(0.95,0.98,1.0-abs(d3));
    vec3 colR = mix(vec3(0.0), vec3(1.,0.776,0.039), d3New.r);
    vec3 colG = mix(vec3(0.0), vec3(0.18,0.839,0.), d3New.g);
    gl_FragColor = vec4(colR + colG, 1.0);
}
