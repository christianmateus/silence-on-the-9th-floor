shader_type canvas_item;

uniform float distortion : hint_range(0.0, 10.0) = 1.0;
uniform float scanline_intensity : hint_range(0.0, 1.0) = 0.5;
uniform sampler2D noise_texture : hint_default_white;  // Textura de ruído para simular grãos.

void fragment() {
    vec2 uv = FRAGCOORD.xy / TEXTURE_PIXEL_SIZE.xy;

    // Distorção horizontal para o efeito de VHS
    float offset = sin(uv.y * 100.0 + TIME) * distortion;
    uv.x += offset;

    vec4 color = texture(TEXTURE, uv);

    // Efeito de scanlines
    float scanline = sin(uv.y * 600.0) * scanline_intensity;
    color.rgb *= 1.0 - scanline;

    // Adiciona ruído para simular o grão do VHS
    vec4 noise = texture(noise_texture, uv);
    color.rgb += noise.rgb * 0.05;  // Ajuste a intensidade do ruído conforme necessário

    COLOR = color;
}