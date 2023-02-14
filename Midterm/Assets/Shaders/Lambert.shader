Shader "Midterm/Lambert"
{
	Properties
	{
	_Color("Color", Color) = (1.0,1.0,1.0)
	}
		SubShader
	{
	Tags {"LightMode" = "ForwardBase"}

		Pass{

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// user defined variables
			uniform float4 _Color;

	// unity defined variables
	uniform float4 _LightColor0;

	// base input structs
	struct vertexInput {
		float4 vertex: POSITION;
		float3 normal: NORMAL;
		//pos and normal of obj
	};

	struct vertexOutput {
		float4 pos: SV_POSITION;
		float4 col: COLOR;
		//output pos and color 
	};

	// vertex functions
	vertexOutput vert(vertexInput v) {
		vertexOutput o;
		float3 normalDirection = normalize(mul(float4(v.normal, 0.0), unity_WorldToObject).xyz); //getting normal direction pointint towards us relative to world 
		float3 lightDirection;
		float atten = 1.0;

		lightDirection = normalize(_WorldSpaceLightPos0.xyz);// getting light direciton and pushing it to vertices 
		float3 diffuseReflection = atten * _LightColor0.xyz * _Color.rgb * max(0.0, dot(normalDirection, lightDirection)); //lightcolor x obj color, max if light goes below 0 it goes back to zero
		//cnat have negative light, dot production of normal dir and light dir 
		o.col = float4(diffuseReflection, 1.0);// lighting calculated above,how bright 
		o.pos = UnityObjectToClipPos(v.vertex);//reaction on to vertex 
		return o;
	}
	// fragment function
	float4 frag(vertexOutput i) : COLOR
	{
		//return what we did to output
	return i.col;
	}
		ENDCG
}
	}
}