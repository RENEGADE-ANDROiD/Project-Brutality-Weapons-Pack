//BASED ON D4D SHADER, sorry guys
//Replaced Dots to lines

uniform float timer;
vec4 Process(vec4 color)
{
	vec2 texCoord = gl_TexCoord[0].st;
	
	vec4 orgColor = getTexel(texCoord) * color;
	
	float cp = (sin(-pixelpos.y/8.0-timer*8.0)+1.0)/2.0;
	
	//float cp = (sin(-pixelpos.y/8-timer*8)+1)/2.0;

	//vec2 fragCoord = gl_FragCoord.xy/2;
	
	//polkadot alpha
	//float cpd = float(int(fragCoord.x)%1.0 == 0.0   &&  int(fragCoord.y)%1.0 == 0.0); //Changed This line
	cp = clamp(cp-0.35, 0.0, 1.0); //This
	
	vec3 glowColor = vec3(0.0);
	
	if( orgColor.r > 0.51 ) glowColor = vec3(2.0, 0.75, 0.15);
	else glowColor = vec3(2.0, 0.22, 0.22);
	// RGB color of glow, components from 0.0 to 1.0.
	//vec3 glowColor = vec3(2.0, 0.22, 0.22); //This 
	//vec3 dkColor = orgColor.rgb;//((orgColor.rgb-0.5)*1.8)+0.5;

	return vec4(mix(orgColor.rgb, glowColor, cp), orgColor.a); // Aaaand This :)
}/*
uniform float timer;
vec4 Process(vec4 color)
{
	vec2 texCoord = gl_TexCoord[0].st;
	vec4 orgColor = getTexel(texCoord) * color;
	
	float cp = (sin(pixelpos.y/4.0-timer*4.0)+1.0)/2.0;
	vec2 fragCoord = gl_FragCoord.xy/2.0;
	
	float cpd = float(int(fragCoord.x)%2.0==0.0 && int(fragCoord.y)%2.0==0.0);
	cp = (cp*cpd)/2.0+0.5;
	
	vec3 glowColor = vec3(0.8, 0.8, 1.0);
	vec3 dkColor = ((orgColor.rgb-0.7)*1.5)+0.5;
	
	return vec4(mix(dkColor, glowColor, cp*cpd), orgColor.a);
}*/