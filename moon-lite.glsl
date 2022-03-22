#define MAX_STEPS 100
#define MAX_HIT 100.
#define MIN_HIT .001

float distsphere(vec3 p, vec3 c, float r)
{
    return length(p - c) - r;
}

float map(vec3 p)
{
    return distsphere(p, vec3(0., 0., 0.), 2.);
}

vec3 normal(vec3 p)
{
    const vec3 ss = vec3(.001, 0., 0.);
    float gx  = map(p + ss.xyy) - map(p - ss.xyy);
    float gy  = map(p + ss.yxy) - map(p - ss.yxy);
    float gz  = map(p + ss.yyx) - map(p - ss.yyx);
    
    return normalize(vec3(gx, gy, gz));
}

vec3 march(vec3 ro, vec3 rd)
{
    vec3 currpos;
    vec3 lightpos = vec3(-10. * sin(iTime), 5., cos(iTime) * 3.);
    vec3 dir;
    float closest;
    float t = 0.;
    
    for (int i = 0; i < MAX_STEPS ; i++)
    {
       currpos = ro + rd * t;
       closest = map(currpos);
       
       if (closest < MIN_HIT)
       {
           dir = normalize(currpos - lightpos);
           return vec3(1., 1., 1.) * max(0.1, dot(currpos, dir)) * .5;
       }
       if (t > MAX_HIT)
           break;
       t += closest;
    }
    return vec3(0);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (2.*fragCoord - iResolution.xy)/iResolution.y;

    vec3 col = vec3(0);
    vec3 ro = vec3(0., 0., -6.);
    vec3 rd = vec3(uv, 1.);

    col = march(ro, rd);
    fragColor = vec4(col,1.0);
}
