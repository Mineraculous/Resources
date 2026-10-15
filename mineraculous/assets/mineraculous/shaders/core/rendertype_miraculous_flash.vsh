#version 150

#moj_import <fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV1;
in ivec2 UV2;
in vec3 Normal;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform int FogShape;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;
out vec3 flashOffset;
flat out float flashRadius;

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    vertexDistance = fog_distance(Position, FogShape);
    vertexColor = Color;
    texCoord0 = UV0;
    // Offset from the flash center and radius, both normalized to the flash's full radius and packed into the overlay and light shorts
    flashOffset = vec3(UV1, UV2.x) / 32767.0;
    flashRadius = float(UV2.y) / 32767.0;
}
