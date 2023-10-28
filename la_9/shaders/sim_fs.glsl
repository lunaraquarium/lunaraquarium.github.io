// An implementation of "Geology" (S24678/B3578),
// a Game Of Life-like rule in which pixels check the value of their neighbors and
// depending on the number of "live" pixel neighbors (i.e. not dark), they survive to the next frame.
// Dead pixels can also come to life if they are surrounded by the right number of live pixels,
// which is 3,5,7 or 8 in this rule's case.
// A simple algorithm, yet sufficient to evoke complex patterns from random "soups" of pixels.
// Taking it a bit further by smooth-stepping the pixel colors based on its # of neighbors brings
// an effect of continents rising from the sea ...
// ... and returning back.
// -KM, 10/27/23

precision mediump float;
uniform sampler2D uTexture; // ping-pong rendering: pixel state from the previous frame is accessed through this uniform
uniform vec3 uC1;
uniform vec3 uC2;
uniform vec2 uMouse; //yep that's right, this is my first mouse-interactive sketch! 
uniform bool uClick; // mouse click/drag events are used to plot some "live" pixels
uniform float uRadius;
uniform float uTime;
uniform vec3 uResolution;
varying vec2 vUv;
float nears(vec2 pt) {
    float count = 0.0;
    for (float y = -1.0; y <=1.0; y++) {
        for (float x = -1.0; x <= 1.0; x++) {
            if (x == 0.0 && y == 0.0) 
                continue;
            vec2 inc = vec2(x,y)/uResolution.xy;
            vec4 lookup = texture2D(uTexture, pt + inc);
            count += lookup.a != 0.0 ? 1.0: 0.0; //live or dead pixel status is stored in the alpha channel (not used for display)
        }
    }
    return count;
}

vec4 geo(vec3 live, vec3 dead, float neighbors) {
    bool currentlyAlive = texture2D(uTexture, vUv).a == 1.0;
    vec4 state = vec4(dead, 0.0);
    if (currentlyAlive && (neighbors == 2.0 || neighbors == 4.0 || neighbors == 6.0 || neighbors == 7.0 || neighbors == 8.0)) {
        state = vec4(live, 1.0);
    } else if (!currentlyAlive && (neighbors == 3.0 || neighbors == 5.0 || neighbors == 7.0 || neighbors == 8.0)) {
        state = vec4(live, 1.0);
    }
    return state;
}

void main() {
    vec3 deadState = vec3(0.0);
    float nCount = nears(vUv);
    float inc = (1.0/0.8)*(0.1*nCount);
    vec3 c3 = mix(uC1, uC2, smoothstep(6.0, 8.0, nCount)); //pixels with fewer than 6 neighbors are assigned the lower-bound (oceanic) color
    vec4 nextState = geo(c3, deadState, nCount);
    vec2 uvScaled = vec2(vUv.x * (uResolution.x/uResolution.y), vUv.y);
    vec2 mouseScaled = vec2(uMouse.x * (uResolution.x/uResolution.y), uMouse.y);
    if (uClick && (distance(uvScaled, mouseScaled) < uRadius)) { //mouse events are given precedence and override the simulation
        nextState = vec4(uC2, 1.0);
    }
    gl_FragColor = nextState;
}