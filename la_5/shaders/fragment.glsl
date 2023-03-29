varying vec2 vUv;
uniform float uTime;
uniform float uMt;
uniform float uResol;
#define PI  3.141592653589793238462643383279502884197169399375105820974944592307816406286208998628034825342117067982148086513282306647093844
/*
The following is a recipe using a few ingredients:
1. 3 octaves of psrdnoise (copyright notice below), adjusted for lacunarity and amplitude in a fractalized Brownian Motion fashion
2. Inversion and ridgelining using absolute values (more fBm shenanigans)
3. Color (always nice to have)
Mix the following with some irrationality and raise to the fourth power, and the result is something that's both anchored and fluid

-KM 3/28/23
*/


// psrdnoise. Like Simplex noise, with a few extra features.
// Copyright (c) 2021 Stefan Gustavson and Ian McEwan.
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//

float psrdnoise(vec2 x, vec2 period, float alpha, out vec2 gradient) {
	vec2 uv = vec2(x.x + x.y*0.5, x.y);
	vec2 i0 = floor(uv);
	vec2 f0 = fract(uv);
	float cmp = step(f0.y, f0.x);
	vec2 o1 = vec2(cmp, 1.0-cmp);
	vec2 i1 = i0 + o1;
	vec2 i2 = i0 + vec2(1.0, 1.0);
	vec2 v0 = vec2(i0.x - i0.y * 0.5, i0.y);
	vec2 v1 = vec2(v0.x + o1.x - o1.y * 0.5, v0.y + o1.y);
	vec2 v2 = vec2(v0.x + 0.5, v0.y + 1.0);
	vec2 x0 = x - v0;
	vec2 x1 = x - v1;
	vec2 x2 = x - v2;
	vec3 iu, iv;
	vec3 xw, yw;
	if(any(greaterThan(period, vec2(0.0)))) {
		xw = vec3(v0.x, v1.x, v2.x);
		yw = vec3(v0.y, v1.y, v2.y);
		if(period.x > 0.0)
			xw = mod(vec3(v0.x, v1.x, v2.x), period.x);
		if(period.y > 0.0)
			yw = mod(vec3(v0.y, v1.y, v2.y), period.y);
		iu = floor(xw + 0.5*yw + 0.5);
		iv = floor(yw + 0.5);
	} else { 
		iu = vec3(i0.x, i1.x, i2.x);
		iv = vec3(i0.y, i1.y, i2.y);
	}
	vec3 hash = mod(iu, 289.0);
	hash = mod((hash*51.0 + 2.0)*hash + iv, 289.0);
	hash = mod((hash*34.0 + 10.0)*hash, 289.0);
	vec3 psi = hash * 0.07482 + alpha;
	vec3 gx = cos(psi);
	vec3 gy = sin(psi);
	vec2 g0 = vec2(gx.x,gy.x);
	vec2 g1 = vec2(gx.y,gy.y);
	vec2 g2 = vec2(gx.z,gy.z);
	vec3 w = 0.8 - vec3(dot(x0, x0), dot(x1, x1), dot(x2, x2));
	w = max(w, 0.0);
	vec3 w2 = w * w;
	vec3 w4 = w2 * w2;
	vec3 gdotx = vec3(dot(g0, x0), dot(g1, x1), dot(g2, x2));
	float n = dot(w4, gdotx);
	vec3 w3 = w2 * w;
	vec3 dw = -8.0 * w3 * gdotx;
	vec2 dn0 = w4.x * g0 + dw.x * x0;
	vec2 dn1 = w4.y * g1 + dw.y * x1;
	vec2 dn2 = w4.z * g2 + dw.z * x2;
	gradient = 10.9 * (dn0 + dn1 + dn2);
	return 10.9 * n;
}


void main()
{
	vec2 st = vec2(vUv.x * uResol, vUv.y);
    float scale = uMt;
    vec2 v = scale *(st - 0.5);
    vec2 p = vec2(0.0,0.0);
    float alpha = uTime/4.0;
    vec2 g;
	float n = 0.0;
    n += 0.5* abs(psrdnoise(v,p,alpha,g));
	n += 0.25 *abs(psrdnoise((PI)*v + 0.3 + 0.1*alpha,p,2.0*alpha,g));
	n += 0.125 *abs(psrdnoise((PI*2.0)*v + 0.3 + 0.2*alpha,p,4.0*alpha,g));
	float m = 1.0 - n;
	float q = m*m*m*m;
	vec3 colB = vec3(1.,0.616,0.); 
	vec3 colC = vec3(0.,0.753,0.922);
	vec3 colBC = mix(colB, colC, 0.5*sin(uTime/8.0) + 0.5);
	vec3 col = mix(vec3(0.0), colBC, q);
    gl_FragColor = vec4(col, 1.0);
}