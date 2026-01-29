shader_type spatial;
render_mode unshaded;

uniform sampler2D screen_texture : source_color, hint_screen_texture, filter_nearest;
uniform sampler2D depth_texture : source_color, hint_depth_texture, filter_nearest;
//uniform sampler2D normal_texture : source_color, hint_normal_roughness_texture, filter_nearest;

 uniform int num_levels = 8; // how many brightness bands you want
uniform float depth_threshold : hint_range(0, 1) = 0.05;
uniform float reverse_depth_threshold : hint_range(0, 1) = 0.25;
uniform float normal_threshold : hint_range(0, 1) = 0.6;
uniform float darken_amount : hint_range(0, 1, 0.01) = 0.3;
uniform float lighten_amount : hint_range(0, 10, 0.01) = 1.5;
uniform vec3 luminance_weights = vec3(0.299, 0.587, 0.114);
uniform vec3 normal_edge_bias = vec3(1, 1, 1);
uniform vec3 light_direction = vec3(-0.96, -0.18, 0.2);

// Additional uniforms for dithering adjustments
uniform float dither_repeat = 1.0; // Adjust repeat scale of dither pattern.
uniform float dither_strength : hint_range(0,1) = 0.1; // Blend factor between original and dither effect.
uniform float min_dither_brightness = 0.1; // Below this, force dark output.

// Custom colors for the dithering effect:
// Here, we use color_a for low brightness areas and color_b for higher brightness areas.
uniform vec4 color_a : source_color = vec4(0.2, 0.0, 0.0, 1.0);
uniform vec4 color_b : source_color = vec4(0.8, 0.4, 0.2, 1.0);

// Toggle the Bayer matrix size: set to 4, 8, or 16.
uniform int bayer_mode = 4;
// How much of the original screen color to keep
uniform float background_blend : hint_range(0,1) = 0.2;

void vertex() {
    //POSITION = vec4(VERTEX, 1.0); // Godot 4.2
    // Godot 4.3
     POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

void fragment() {
    vec3 color_in = texture(screen_texture, SCREEN_UV).rgb;
    float brightness = dot(color_in, luminance_weights);

    // --- Bayer threshold lookup ---
    ivec2 pixel_coord = ivec2(FRAGCOORD.xy);
    int x = pixel_coord.x % bayer_mode;
    int y = pixel_coord.y % bayer_mode;
    int index = y * bayer_mode + x;

    float threshold = 0.0;
    if (bayer_mode == 4) {
        float bayer4[16] = float[](
            0.0/16.0,  8.0/16.0,  2.0/16.0, 10.0/16.0,
            12.0/16.0, 4.0/16.0, 14.0/16.0, 6.0/16.0,
            3.0/16.0, 11.0/16.0, 1.0/16.0,  9.0/16.0,
            15.0/16.0, 7.0/16.0, 13.0/16.0, 5.0/16.0
        );
        threshold = bayer4[index];
    }

    // --- Quantization step ---
    float dither_value = brightness + threshold * dither_strength;
    float quantized = floor(dither_value * float(num_levels)) / float(num_levels);
    vec3 dither_color = mix(color_a.rgb, color_b.rgb, quantized);

    // --- Blend with original ---
    vec3 final_color = mix(dither_color, color_in, background_blend);

    ALBEDO = final_color;
}
