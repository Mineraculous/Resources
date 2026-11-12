#version 150

uniform sampler2D DiffuseSampler;

in vec2 texCoord;

out vec4 fragColor;

const float COLOR_GAIN = 2.5;
const float ALPHA_GAIN = 1.8;
const float CORE_START = 0.6;
const float CORE_END = 0.95;
const vec3 CORE_COLOR = vec3(1.5);
// Part of the alpha is cut back between these so the blurred edges round off instead of trailing away.
const float ROUND_START = 0.05;
const float ROUND_END = 0.6;
const float ROUND_OFF = 0.5;
// The glow never becomes fully opaque, so it stays a line of light rather than a solid shape.
const float MAX_ALPHA = 0.85;

void main() {
    vec4 blurredColor = texture(DiffuseSampler, texCoord);

    float coreMask = smoothstep(CORE_START, CORE_END, blurredColor.a);
    vec3 vibrantColor = blurredColor.rgb * COLOR_GAIN;
    vec3 finalRGB = mix(vibrantColor, CORE_COLOR, coreMask);

    float rounded = smoothstep(ROUND_START, ROUND_END, blurredColor.a);
    float alpha = mix(blurredColor.a * ALPHA_GAIN, rounded, ROUND_OFF);
    fragColor = vec4(finalRGB, min(alpha, MAX_ALPHA));
}
