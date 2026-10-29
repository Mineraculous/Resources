#version 150

uniform sampler2D DiffuseSampler;

in vec2 texCoord;

out vec4 fragColor;

const float COLOR_GAIN = 2.5;
const float ALPHA_GAIN = 1.8;
const float CORE_START = 0.6;
const float CORE_END = 0.95;
const vec3 CORE_COLOR = vec3(1.5);

void main() {
    vec4 blurredColor = texture(DiffuseSampler, texCoord);

    float coreMask = smoothstep(CORE_START, CORE_END, blurredColor.a);
    vec3 vibrantColor = blurredColor.rgb * COLOR_GAIN;
    vec3 finalRGB = mix(vibrantColor, CORE_COLOR, coreMask);

    fragColor = vec4(finalRGB, blurredColor.a * ALPHA_GAIN);
}
