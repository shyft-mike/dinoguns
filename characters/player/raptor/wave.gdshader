shader_type canvas_item;

uniform float strength;
uniform float amplitude : hint_range(0, 1) = 0.1;
uniform float frequency : hint_range(0, 10) = 2.0;
uniform float speed : hint_range(0, 10) = 2.0;

vec2 jiggle(vec2 v) {
	vec2 new_vertex = v;
	
	new_vertex.x = sin(TIME * strength) / (strength / 2.0) + v.x;
	new_vertex.y = sin(TIME * strength) / (strength / 2.0) + v.y;
	
	return new_vertex;
}

void vertex() {
    float ripple = amplitude * sin(frequency * (UV.x + UV.y + TIME * speed));
    VERTEX.x += ripple;
}

void fragment() {
	// Place fragment code here.
}
