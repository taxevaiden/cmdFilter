// extern vec2 screen_size;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    const int N = 4;
    const int levels = 4;

    // 4x4 Bayer Matrix (normalized to 0-1)
    const float bayerMatrix[16] = float[16](
        0.0 / 16.0,  8.0 / 16.0,  2.0 / 16.0, 10.0 / 16.0,
        12.0 / 16.0, 4.0 / 16.0, 14.0 / 16.0, 6.0 / 16.0,
        3.0 / 16.0, 11.0 / 16.0, 1.0 / 16.0, 9.0 / 16.0,
        15.0 / 16.0, 7.0 / 16.0, 13.0 / 16.0, 5.0 / 16.0
    );

    vec4 pixel = Texel(texture, texture_coords);

    int x = int(mod(screen_coords.x, float(N)));
    int y = int(mod(screen_coords.y, float(N)));
    int index = y * N + x;
    float threshold = bayerMatrix[index];
    
    vec3 quantized = floor(pixel.rgb * float(levels) + threshold);

    vec3 ditheredColor = quantized / float(levels);

    return vec4(ditheredColor, pixel.a);
}
