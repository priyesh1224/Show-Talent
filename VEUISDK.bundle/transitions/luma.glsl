precision highp float;

varying vec2 textureCoordinate;
uniform sampler2D from;
uniform sampler2D to;
uniform float progress;

vec4 getFromColor(vec2 uv) {
	return texture2D(from,uv);
}

vec4 getToColor(vec2 uv){
	return texture2D(to,uv);
}
// Author: gre
// License: MIT

uniform sampler2D luma;

vec4 transition(vec2 uv) {
  return mix(
    getToColor(uv),
    getFromColor(uv),
    step(progress, texture2D(luma, uv).r)
  );
}
void main(){
	gl_FragColor = transition(textureCoordinate);
}
