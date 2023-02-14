Shader "Midterm/Ambient"
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
	};

	struct vertexOutput {
		float4 pos: SV_POSITION;
		float4 col: COLOR;
	};

	// vertex functions
	vertexOutput vert(vertexInput v) {
		vertexOutput o;
		float3 normalDirection = normalize(mul(float4(v.normal, 0.0), unity_WorldToObject).xyz); //getting normal direction pointint towards us relative to world 
		float3 lightDirection;
		float atten = 1.0;

		lightDirection = normalize(_WorldSpaceLightPos0.xyz);// getting light direciton and pushing it to vertices 

		float3 diffuseReflection = atten * _LightColor0.xyz * _Color.rgb * max(0.0, dot(normalDirection, lightDirection));//lightcolor x obj color, max if light goes below 0 it goes back to zero
		//cnat have negative light, dot production of normal dir and light dir 
		float3 lightFinal = diffuseReflection + UNITY_LIGHTMODEL_AMBIENT.xyz; //diffuse lighting plus unity given ambient light model 

		o.col = float4(lightFinal * _Color.rgb, 1.0); // x light and set how bright 


		o.pos = UnityObjectToClipPos(v.vertex);
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