vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    const float pixel_size = 4.0;
    vec2 block_size = pixel_size / love_ScreenSize.xy;

    const int N = 4;

    const float bayerMatrix[16] = float[16](
        0.0,  8.0,  2.0, 10.0,
        12.0, 4.0, 14.0, 6.0,
        3.0, 11.0, 1.0, 9.0,
        15.0, 7.0, 13.0, 5.0
    );

    vec2 pixelated_coords = floor(texture_coords / block_size) * block_size;

    vec4 pixel = Texel(texture, pixelated_coords);
    float largest = max(pixel.r, max(pixel.g, pixel.b));

    // ensure largest isn't zero, so we don't divide by zero (that would be bad!!)
    if (largest == 0.0) {
        return vec4(0.0);
    }

    int x = int(mod(screen_coords.x, float(N)));
    int y = int(mod(screen_coords.y, float(N)));
    int index = y * N + x;

    float threshold = (bayerMatrix[index] + 0.5) / 16.0;

    float ditheredValue = largest < threshold ? 0.0 : 1.0;

    return vec4((pixel.rgb / largest) * ditheredValue, pixel.a);
}