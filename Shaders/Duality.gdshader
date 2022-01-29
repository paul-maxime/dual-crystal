shader_type canvas_item;

uniform vec4 red_world : hint_color;
uniform vec4 blue_world : hint_color;
uniform vec4 both_worlds : hint_color;
uniform vec4 background : hint_color;

void fragment() {
	vec3 c = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0).rgb;
	if (c.r > 0f && c.b > 0f) {
		c = both_worlds.rgb * (c.r + c.b) * 0.5f;
	} else if (c.r > 0f) {
		c = red_world.rgb * c.r;
	} else if (c.b > 0f) {
		c = blue_world.rgb * c.b;
	} else {
		c = background.rgb;
	}
	COLOR.rgb = c;
}
