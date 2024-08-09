shader_type spatial;
render_mode unshaded;

uniform vec3 smoke_color : source_color = vec3(0.5, 0.5, 0.5);
uniform float time_scale : hint_range(0.1, 5.0) = 1.0;
uniform float noise_scale : hint_range(0.1, 5.0) = 1.0;
uniform float noise_strength : hint_range(0.0, 1.0) = 0.2;
uniform float alpha_start : hint_range(0.0, 1.0) = 1.0;
uniform float alpha_end : hint_range(0.0, 1.0) = 0.0;
uniform float particle_lifetime : hint_range(0.1, 10.0) = 1.0;

float basic_noise(vec3 p) {
    return fract(sin(dot(p, vec3(12.9898, 78.233, 37.719))) * 43758.5453);
}

void vertex() {
    float t = TIME * time_scale;
    vec3 noise = vec3(
        basic_noise(vec3(VERTEX.x * noise_scale, VERTEX.y, t)),
        basic_noise(vec3(VERTEX.y * noise_scale, VERTEX.z, t)),
        basic_noise(vec3(VERTEX.z * noise_scale, VERTEX.x, t))
    );
    VERTEX += noise * noise_strength;
    VERTEX = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
    float lifetime_ratio = clamp(TIME / particle_lifetime, 0.0, 1.0);
    float alpha = mix(alpha_start, alpha_end, lifetime_ratio);

    ALBEDO = smoke_color;
    ALPHA = alpha;
}
