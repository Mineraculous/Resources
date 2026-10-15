#version 150

#moj_import <fog.glsl>

#define EDGE_WIDTH_PIXELS 1.5

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
in vec3 flashOffset;
flat in float flashRadius;

out vec4 fragColor;

void main() {
    float flashDistance = length(flashOffset);
    float edgeWidth = max(fwidth(flashDistance) * EDGE_WIDTH_PIXELS, 1.0e-4);
    float coverage = 1.0 - smoothstep(flashRadius, flashRadius + edgeWidth, flashDistance);
    if (coverage <= 0.0 || texture(Sampler0, texCoord0).a < 0.1)
        discard;
    vec4 color = vec4(vertexColor.rgb, coverage) * ColorModulator;
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
