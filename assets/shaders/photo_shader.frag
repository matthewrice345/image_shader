#version 460 core

#include <flutter/runtime_effect.glsl>

precision mediump float;

uniform sampler2D u_image;              // Input image
uniform vec2 uSize;
uniform float u_brightness;             // Brightness adjustment
uniform float u_saturation;             // Saturation adjustment
uniform float u_hue;                    // Hue adjustment
uniform float u_gamma;                  // Gamma adjustment
uniform float u_temperature;            // Temperature adjustment
uniform float u_contrast;               // Contrast adjustment
uniform float u_highlights;             // Highlights adjustment
uniform float u_blacks;                 // Black reduction adjustment
uniform float u_whites;                 // White boosts adjustment
uniform float u_shadows;                // Shadows adjustment
uniform float u_exposure;               // Exposure adjustment
uniform float u_vibrance;               // Vibrance adjustment
uniform float u_clarity;                // Clarity adjustment
uniform float u_dehaze;                 // Dehaze adjustment
uniform float u_tint;                   // Tint adjustment
uniform float u_sharpen;                // Sharpening adjustment
uniform float u_noiseReduction;         // Noise reduction adjustment
uniform float u_vignette;               // Vignette adjustment
uniform float u_sepia;                  // Sepia adjustment
uniform float u_grayscale;              // Grayscale adjustment
uniform vec3  u_colorBalance;           // Color Balance adjustment

out vec4 fragColor;                     // Output color

vec3 rgb2hsv(vec3 c) {
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main() {
    vec2 iResolution = uSize;
    vec2 fragCoord = FlutterFragCoord();
    vec2 uv = fragCoord/iResolution.xy;

    // Sample the pixel color
    vec4 color = texture(u_image, uv);

    // 1. Apply Brightness
    if (u_brightness != 0.0) {
        color.rgb = clamp(color.rgb + u_brightness, 0.0, 1.0);
    }

    // 2. Apply Saturation
    if (u_saturation != 1.0) {
        float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
        color.rgb = mix(vec3(gray), color.rgb, u_saturation);
    }

    // 3. Apply Hue
    if (u_hue != 1) {
        vec3 hsv = rgb2hsv(color.rgb);
        hsv.x = mod(hsv.x + u_hue, 1.0);
        color.rgb = hsv2rgb(hsv);
    }

    // 4. Apply Gamma Correction
    if (u_gamma != 1.0) {
        color.rgb = pow(color.rgb, vec3(1.0 / u_gamma));
    }

    // 5. Apply Temperature
    if (u_temperature != 0.0) {
        color.r = clamp(color.r + u_temperature * 0.1, 0.0, 1.0);
        color.b = clamp(color.b - u_temperature * 0.1, 0.0, 1.0);
    }

    // 6. Apply Contrast
    if (u_contrast != 1.0) {
        color.rgb = clamp((color.rgb - 0.5) * u_contrast + 0.5, 0.0, 1.0);
    }

    // 7. Apply Highlights
    if (u_highlights != 0.0) {
        color.rgb = mix(color.rgb, vec3(1.0), u_highlights);
    }

    // 8. Apply Black Reduction
    if (u_blacks != 0.0) {
        color.rgb = mix(color.rgb, vec3(0.0), u_blacks);
    }

    // 9. Apply White Boosts
    if (u_whites != 0.0) {
        color.rgb = mix(color.rgb, vec3(1.0), u_whites);
    }

    // 10. Apply Shadows
    if (u_shadows != 0.0) {
        color.rgb = mix(color.rgb, color.rgb * 0.5, u_shadows);
    }

    // 11. Apply Exposure
    if (u_exposure != 0.0) {
        color.rgb = color.rgb * exp2(u_exposure);
    }

    // 12. Apply Vibrance
    if (u_vibrance != 0.0) {
        float maxColor = max(max(color.r, color.g), color.b);
        float avgColor = (color.r + color.g + color.b) / 3.0;
        float vibranceFactor = (maxColor - avgColor) * u_vibrance;
        color.rgb += vibranceFactor;
    }

    // 13. Apply Clarity
    if (u_clarity != 0.0) {
        color.rgb = mix(color.rgb, color.rgb * 1.5, u_clarity);
    }

    // 14. Apply Dehaze
    if (u_dehaze != 0.0) {
        color.rgb = mix(color.rgb, vec3(1.0) - color.rgb, u_dehaze);
    }

    // 15. Apply Tint
    if (u_tint != 0.0) {
        color.rgb += vec3(u_tint, -u_tint, 0.0);
    }

    // 16. Apply Sharpening
    if (u_sharpen != 0.0) {
        vec4 sharpenedColor = texture(u_image, uv + vec2(0.001, 0.0)) +
        texture(u_image, uv + vec2(-0.001, 0.0)) +
        texture(u_image, uv + vec2(0.0, 0.001)) +
        texture(u_image, uv + vec2(0.0, -0.001)) -
        4.0 * color;
        color.rgb += sharpenedColor.rgb * u_sharpen;
    }

    // 17. Apply Noise Reduction
    if (u_noiseReduction != 0.0) {
        color.rgb = mix(color.rgb, vec3(0.5), u_noiseReduction);
    }

    // 18. Apply Vignette
    if (u_vignette != 0.0) {
        float dist = distance(uv, vec2(0.5, 0.5));
        color.rgb *= smoothstep(0.8, 0.5, dist * u_vignette);
    }

    // 19. Apply Sepia
    if (u_sepia != 0.0) {
        vec3 sepiaColor = vec3(0.393, 0.769, 0.189) * color.r +
        vec3(0.349, 0.686, 0.168) * color.g +
        vec3(0.272, 0.534, 0.131) * color.b;
        color.rgb = mix(color.rgb, sepiaColor, u_sepia);
    }

    // 20. Apply Grayscale
    if (u_grayscale != 0.0) {
        float grayscale = dot(color.rgb, vec3(0.299, 0.587, 0.114));
        color.rgb = mix(color.rgb, vec3(grayscale), u_grayscale);
    }

    // 21. Apply Color Balance
    if (u_colorBalance != vec3(1.0, 1.0, 1.0)) {
        color.rgb *= u_colorBalance;
    }

    // Final output
    fragColor = color;
}