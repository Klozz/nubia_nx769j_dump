//
// Created by 10226574 on 2022/7/12.
//

#version 310 es

precision mediump float;
in vec2 vTexCoor;
uniform sampler2D sTexture;
uniform sampler2D uNoiseTexture;
uniform float scale;
uniform float strength;
out vec4 uFragColor;

 //float strength=0.58
 //float scale=1.0 original  set;  float scale=0.6  level1


void main() {
    vec3 W = vec3(0.2125, 0.7154, 0.0721);


    //simulate film grain
    vec4 srcColor= texture(sTexture, vTexCoor);
    float lum = dot(srcColor.rgb, W);


	//kinds of film grain from true grain  data
    //fuji_400:
    //expFun(x):-0.01534*np.exp((x-0.5594**2)/(2*0.2825**2)+0.062973)
    //kmax_3200
    //expFun(x):-0.02655*np.exp((x-0.5768**2)/(2*0.2211**2)+0.161233)
    //pseudo noise
    //float k1=0.1575*(4.01-exp(ixd)/2.0);
    //vec3  sdnoise=(knoise-vec3(0.61))*k1;
    //g4
    //float k1=0.2285*(4.01-exp(ixd)/2.0);
    //vec3  sdnoise=(knoise-vec3(0.26))*k1;
    //g6
    //float k1=0.2275*(4.01-exp(ixd)/2.0);
    //vec3  sdnoise=(knoise-vec3(0.37))*k1;
    //float ixd=pow((lum-0.56)/0.565,2.0);
	//fuji_6
	//0.09903 x + 0.00667
    //float k1=0.38;      original set
    //float b=0.0112;     original set
    //vec3 ob=vec3(0.47); original  set
    //chn	//-0.0275110468123*np.exp((x-0.807862155485)**2)/(2*0.49592173298**2)+0.0957381453752)
    //float ixd=pow((lum-0.8079)/0.496,2.0);
    //float k1=0.1278*(3.48-exp(ixd)/2.0);
    //vec3  sdnoise=(knoise-vec3(0.529))*k1;
    //sdnoise=sdnoise*(1.0-smoothstep(0.90,0.96,lum));


	//fuji_ktk
	vec2 cord = vTexCoor.st*(1.0/scale);
	highp vec3 knoise = texture(uNoiseTexture, cord).rgb;
    vec3  ob=vec3(0.53);
    vec3  sdnoise=(knoise-ob)*0.58*strength+0.02123;
    sdnoise=sdnoise*(1.0-smoothstep(0.90,0.96,lum));

    sdnoise=clamp((sdnoise+srcColor.rgb),0.0,1.0);
    uFragColor = vec4(sdnoise.rgb, srcColor.a);
}