#version 150

#moj_import <fog.glsl>

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;

in float vertexDistance;
in vec4 vertexColor;
in vec2 haloCoord;

out vec4 fragColor;

void main() {
    float falloff = max(1.0 - dot(haloCoord, haloCoord), 0.0);
    if (falloff <= 0.0)
        discard;
    vec4 color = vec4(vertexColor.rgb, vertexColor.a * falloff * falloff) * ColorModulator;
    fragColor = color * linear_fog_fade(vertexDistance, FogStart, FogEnd);
}
