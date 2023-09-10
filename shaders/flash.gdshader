shader_type canvas_item;

uniform bool active = false;
uniform vec4 flash_color: source_color;
varying flat vec4 modulate;

void vertex() {
	modulate = COLOR;
}

void fragment() {
	vec4 previous_color = texture(TEXTURE, UV);
	vec4 new_color = previous_color * modulate;
	if (active == true)
	{
		new_color = vec4(flash_color.r, flash_color.g, flash_color.b, previous_color.a);
	}	
	COLOR = new_color;
}
