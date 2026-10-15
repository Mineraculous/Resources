#version 150

#moj_import <fog.glsl>

in vec3 Position;
in vec2 UV0;
in vec4 Color;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform int FogShape;

out float vertexDistance;
out vec4 vertexColor;
out vec2 haloCoord;

void main() {
    // Every corner sits at the halo center; UV0 is the corner's camera-facing offset, so the quad always faces the viewer
    gl_Position = ProjMat * (ModelViewMat * vec4(Position, 1.0) + vec4(UV0, 0.0, 0.0));

    vertexDistance = fog_distance(Position, FogShape);
    vertexColor = Color;
    haloCoord = sign(UV0);
}
