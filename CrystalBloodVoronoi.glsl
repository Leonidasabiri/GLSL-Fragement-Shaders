// As you can see voronoi is easy to implement, you just iterate on the cells and check the closest point from the neighboor and add
// a color based on this information.
// I named it Crystal Blood voronoi just because it's red and the voronoi pattern makes it look like a crystal, it's not something special.

vec2 random2( vec2 p ) {
    return fract(sin(vec2(dot(p,vec2(127.1,311.7)),dot(p,vec2(269.5,183.3))))*234.);
}

void mainImage(out vec4 FragColor ,in vec2 FragCoord) {
    vec2 uv = FragCoord/iResolution.x;
    vec2 minpoint;
    vec3 color;

    uv *= 14.;    // Change the diagram scale here to see more or less voronoi points

    float mindist = 0.8;
    float dist;
    for (float x = 0.; x <= 1.; x++) {
        for (float y = 0.; y <= 1.; y++) {
            vec2 neighbor = vec2(x, y);
            vec2 point = random2(floor(uv) + neighbor);
            point = 0.2 * sin(iTime * random2(point) * 2.);
            vec2 diff = neighbor + point - fract(uv);
            dist = length(diff);
            if (dist < mindist)
            {
                mindist = dist;
                minpoint = point;
            }
        }
    }
    color.r += dot(minpoint, vec2(1.3, 0.9)) + .5;

    FragColor = vec4(color,1.0);
}
