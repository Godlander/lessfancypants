#version 150

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec4 vertexColor;
in vec4 tintColor;
in vec4 lightColor;
in vec4 overlayColor;
in vec2 uv;
in vec4 normal;

out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, uv);
    if (color.a < 0.1) discard;
    color *= tintColor * ColorModulator;
    color.rgb = mix(overlayColor.rgb, color.rgb, overlayColor.a);
    color *= vertexColor * lightColor; //shading
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}