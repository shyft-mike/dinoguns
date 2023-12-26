shader_type canvas_item;

uniform bool active = false;
varying flat vec4 modulate;

void vertex() {
	modulate = COLOR;
}

void fragment() {
	vec4 original_color = texture(TEXTURE, UV);
	vec4 new_color = original_color;
	bool is_edge = false;

	if (active) {
		if (original_color.a > 0.0) {
			vec4 left_neighbor = texture(TEXTURE, UV + vec2(-1.0, 0.0) * TEXTURE_PIXEL_SIZE);
			vec4 top_neighbor = texture(TEXTURE, UV + vec2(0.0, 1.0) * TEXTURE_PIXEL_SIZE);
			vec4 right_neighbor = texture(TEXTURE, UV + vec2(1.0, 0.0) * TEXTURE_PIXEL_SIZE);
			vec4 bottom_neighbor = texture(TEXTURE, UV + vec2(0.0, -1.0) * TEXTURE_PIXEL_SIZE);

			if (left_neighbor.a <= 0.0) {
				is_edge = true;
			} else if (top_neighbor.a <= 0.0) {
				is_edge = true;
			} else if (right_neighbor.a <= 0.0) {
				is_edge = true;
			} else if (bottom_neighbor.a <= 0.0) {
				is_edge = true;
			}
		}
	}

	if (is_edge) {
		// goose the edges
		new_color.r += 1.0;
//		new_color.g += cos(TIME * 8.0) / 8.0;
//		new_color.b += tan(TIME * 8.0) / 8.0;
	}

	COLOR = new_color;
}

