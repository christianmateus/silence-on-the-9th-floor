shader_type canvas_item;

uniform float pixel_size : hint_range(1.0, 10.0);

void fragment() {
    vec2 uv = FRAGCOORD.xy / pixel_size;
    uv = floor(uv) * pixel_size;
    COLOR = texture(TEXTURE, uv / SCREEN_PIXEL_SIZE);
}