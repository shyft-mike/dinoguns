shader_type canvas_item;

varying flat vec4 modulate;

void vertex() {
	modulate = COLOR;
}

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	if(texture_color[3] != 0.0)
	{
		texture_color = mix(texture_color, vec4(1, 1, 1, 1), sin(TIME * 3.0) * 0.6);
	}
	COLOR = texture_color * modulate;
}
