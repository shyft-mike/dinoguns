shader_type canvas_item;

uniform vec4 field_color : source_color;

void fragment() {
    vec4 color = texture(TEXTURE, UV);

    if (color == field_color) {
        color = texture(TEXTURE, UV + vec2(sin(TIME * 4.0) / 400.0, 0.0));
    }

    COLOR = color;
}