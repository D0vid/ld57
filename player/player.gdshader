shader_type canvas_item;

uniform vec4 tint_color : source_color = vec4(1.0, 0.71, 0.76, 1.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
COLOR = texture(TEXTURE, UV) * tint_color;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
