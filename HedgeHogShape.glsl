#define PI 3.14
#define TWOPI 6.28
#define RED vec3(1. * sin(iTime) * 10., 0.2 , 1. * cos(iTime))

float random(vec2 st, float b)
{
    return fract(sin(dot(st.yx, vec2(23., 45.))) * 1234.) / b;
}

vec3 hedgehog(vec3 col, vec2 st, float scale, vec2 pos)
{
    st.x *= iResolution.x / iResolution.y;
    vec3 color = vec3(1.0);
    float d = 0.;

    st.x = st.x + pos.x - 0.1;
    st.y = st.y + pos.y + 0.3;
    int n = 5;
    
    float a = atan(st.x, st.y) * sin(iTime) * 3.;
    float r = 6. / float(n);
    
    d = cos(floor(.5 + a / r) * r - a) * length(st);
    color = vec3(1. - smoothstep(scale, scale, d)) * col;

    return color;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 st = fragCoord/iResolution.xy;
    vec3 col;
    vec2 pos[2] = vec2[2](vec2(-0.9, -0.8), vec2(-0.7, -0.8)); 
    vec3 h1 = hedgehog(RED, st, .34, pos[0]);
    vec3 h2 = hedgehog(RED, st, .34, pos[1]);
 
    col = h1 + h2;
    col.x *= random(st, 3.);
    
    // Output to screen
    fragColor = vec4(col,1.0);
}
