// A "back-to-the-roots" sketch in more ways than one
// Colors are controlled by sines, giving a "multimodal" periodicity
// Feel free to copy any part of this sketch in your projects
// Bonus points if you credit the Lunar Aquarium
// -KM, 2/12/24


precision mediump float;
varying vec2 vUv;
uniform float t;
uniform float c;
uniform vec2 m;
uniform float resol;
void main() {
    vec2 center = vec2(0.5);
    vec2 st = vUv;
    st -= center;
    st.x *= resol;
    st += center;

    vec3 sinusoid = vec3(0.5*sin(t*c*0.3 +0.2) + 0.5,0.5*sin(t*c*0.5) + 0.5,0.5*sin(t*c) + 0.5);
    vec3 base = vec3(vUv, 1.0);
    float str = distance(st, m);
    str = 0.1/str;
    vec3 pattern = mix(vec3(0.0), sinusoid, str);
    gl_FragColor = vec4(pattern, 1.0);
}