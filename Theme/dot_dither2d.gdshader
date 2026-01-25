shader_type canvas_item;
render_mode blend_add;

uniform vec4 color_a : source_color = vec4(0.0, 0.0, 0.0, 1.0); // darkest
uniform vec4 color_b : source_color = vec4(1.0, 1.0, 1.0, 1.0); // brightest
uniform int bayer_mode = 4;

void fragment() {
    vec3 color_in = texture(TEXTURE, UV).rgb;
    float brightness = dot(color_in, vec3(0.299, 0.587, 0.114));

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

    vec3 dithered_color = (brightness > threshold) ? color_b.rgb : color_a.rgb;
    COLOR = vec4(dithered_color, 1.0);
	COLOR = COLOR; // Label text will additively blend with background
}