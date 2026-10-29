#version 150

uniform sampler2D DiffuseSampler;
uniform float BlurSigma;
uniform float ColorGain;
uniform float AlphaGain;

in vec2 texCoord;
in vec2 sampleStep;

out vec4 fragColor;

const int RADIUS = 16;

float gaussian(float x, float sigma) {
    return exp(-(x * x) / (2.0 * sigma * sigma));
}

void main() {
    float w0 = gaussian(0.0, BlurSigma);
    vec4 color = texture(DiffuseSampler, texCoord) * w0;

    float weightSum = w0;

    for (int i = 1; i <= RADIUS; i++) {
        float w = gaussian(float(i), BlurSigma);

        vec2 offset = sampleStep * float(i);

        color += texture(DiffuseSampler, texCoord + offset) * w;
        color += texture(DiffuseSampler, texCoord - offset) * w;

        weightSum += 2.0 * w;
    }

    vec4 blurredColor = color / weightSum;

    fragColor = vec4(blurredColor.rgb * ColorGain, blurredColor.a * AlphaGain);
}
