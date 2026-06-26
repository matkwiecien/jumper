shader_type canvas_item;

uniform vec4 fill_color: source_color = vec4(1.0);
uniform float min_val;
uniform float current_val;
uniform float max_val;


uniform float corner_scale: hint_range(0., 1.) = 0.;

bool isOut(float x, float y) {
    return pow(x, 2.) + pow(y, 2.) > pow(corner_scale * .5, 2.);
}

/*
	linear normalization from one range to another
*/
float linear(float old_min, float old_max, float new_min, float new_max, float current) {
	float old_range = (old_max - old_min);
	float new_range = (new_max - new_min);
	float new_val = (((current - old_min) * new_range) / old_range ) + new_min;
	return new_val;
}

void fragment() {
	vec4 color = COLOR;
	
	float normalized = 1.0 - linear(min_val, max_val, 0.0, 1.0, current_val);
	
	/*
	If the fragcoord.x is less than or equal to the calculated point
	between min and max that current_value falls on, mix with our
	fill color
	*/
	if (UV.y >= normalized) {
		color.rgb = mix(color.rgb, fill_color.rgb, 0.5);
	}
	
	COLOR = color;
	
	float s = corner_scale * .5;

    if (
        (UV.x < s      && UV.y < s      && isOut(UV.x - s,      UV.y - s)) ||
        (UV.x < s      && UV.y > 1. - s && isOut(UV.x - s,      UV.y - 1. + s)) ||
        (UV.x > 1. - s && UV.y < s      && isOut(UV.x - 1. + s, UV.y - s)) ||
        (UV.x > 1. - s && UV.y > 1. - s && isOut(UV.x - 1. + s, UV.y - 1. + s))
    ) {
        COLOR.a = 0.;
    }
}
