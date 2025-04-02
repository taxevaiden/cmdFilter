extern vec2 shift;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec4 pixel = Texel(texture, texture_coords);

    vec4 r = Texel(texture, texture_coords - (shift / love_ScreenSize.xy));
    vec4 g = pixel;
    vec4 b = Texel(texture, texture_coords + (shift / love_ScreenSize.xy));

    return vec4(r.r, g.g, b.b, pixel.a);
}
