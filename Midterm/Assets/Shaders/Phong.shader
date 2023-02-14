Shader "Midterm/Phong"
{
	Properties{
  _Color("Color", Color) = (1.0,1.0,1.0)
  _SpecColor("Color", Color) = (1.0,1.0,1.0)
  _Shininess("Shininess", Float) = 10
	}
		SubShader{
		Pass
		{
		Tags {"LightMode" = "ForwardBase"}
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		// user defined variables
		uniform float4 _Color;
		uniform float4 _SpecColor;
		uniform float _Shininess;
		// unity defined variables
		uniform float4 _LightColor0;
		// structs
		struct vertexInput {
		float4 vertex : POSITION;
		float3 normal : NORMAL;
		};
		struct vertexOutput {
			float4 pos : SV_POSITION;
			float4 posWorld : TEXCOORD0; //where obj tex coord are relative to game world 
			float4 normalDir : TEXCOORD1; //where normal tex coord are relative to game world 
		};
		//vertex function
		vertexOutput vert(vertexInput v) {
			vertexOutput o;
			o.posWorld = mul(unity_ObjectToWorld, v.vertex);//where obj is in world 
			o.normalDir = normalize(mul(float4(v.normal, 0.0), unity_WorldToObject));//gives normal of the surface 
			o.pos = UnityObjectToClipPos(v.vertex);//pos of the obj 
			return o;
		}

		// fragment function
		float4 frag(vertexOutput i) : COLOR
		{
			// vectors
			float3 normalDirection = i.normalDir;//set normal so we can use it in frag
			float atten = 1.0;
			// lighting
			float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);//set up light dir in worl d
			float3 diffuseReflection = atten * _LightColor0.xyz * max(0.0, dot(normalDirection,lightDirection)); //set up diffuse reflection in world
			// specular direction
			float3 lightReflectDirection = reflect(-lightDirection, normalDirection);//reflection vector
			float3 viewDirection = normalize(float3(float4(_WorldSpaceCameraPos.xyz, 1.0) - i.posWorld.xyz));//current view direction in worl d
			float3 lightSeeDirection = max(0.0,dot(lightReflectDirection, viewDirection));//what the light can see and reflect off of 
			float3 shininessPower = pow(lightSeeDirection, _Shininess);//need high intense reflection so we use light see and pow it with shiniess 
			float3 specularReflection = atten * _SpecColor.rgb * shininessPower;//spec highlights with shininess
			float3 lightFinal = diffuseReflection + specularReflection + UNITY_LIGHTMODEL_AMBIENT;
			//adding final light with diffuse spec and ambient 
			return float4(lightFinal * _Color.rgb, 1.0);//set how bright it is, final light x color 
		}
			ENDCG
	}
	}

}
