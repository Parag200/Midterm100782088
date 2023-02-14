Shader "Midterm/LutShader"
{
    Properties
    {

        _MainTex("Texture", 2D) = "white" {}
        _LUT("LUT", 2D) = "white" {}
        _Contribution("Contribution", Range(0,1)) = 0.5

    }
        SubShader
        {
            //No culling or depth
             Cull Off ZWrite Off ZTest Always //Ensures the effect is shown on screen
             Pass
             {
                 CGPROGRAM
                 #pragma vertex vert
                 #pragma fragment frag

                 #include  "UnityCG.cginc"//unity bulit in shader
                 #define COLORS 32.0//defines how much colors in LUT

                 struct appdata
                 {
                 float4 vertex : POSITION;
                 float2 uv : TEXCOORD0;
                 };

                 struct v2f
                 {
                     float2 uv : TEXCOORD0;
                     float4 vertex : SV_POSITION;
                 };

                 v2f vert(appdata v)
                 {
                     v2f o;
                     o.vertex = UnityObjectToClipPos(v.vertex);
                     o.uv = v.uv;
                     return o;
                 }

                 sampler2D _MainTex;
                 sampler2D _LUT;
                 float4 _LUT_TexelSize;//Dimensions of texture size - texels
                 float _Contribution;

                 fixed4 frag(v2f i) : SV_Target
                 {
                 float maxColor = COLORS - 1.0;//Values of the number of colors-1

                 fixed4 col = saturate(tex2D(_MainTex, i.uv));//Get secene color saturated so that value is <1and >0

                 float halfColX = 0.5 / _LUT_TexelSize.z;//Add prescision to the sampling to avoid going beyond the LUT limit
                 float halfColY = 0.5 / _LUT_TexelSize.w;
                 float threshold = maxColor / COLORS;


                 float xOffset = halfColX + col.r * threshold / COLORS; //Calculates the offset to the map the image LUT
                 float yOffset = halfColY + col.g * threshold;
                 float cell = floor(col.b * maxColor);
                 float2 lutPos = float2(cell / COLORS + xOffset,
                yOffset);
                 float4 gradedCol = tex2D(_LUT, lutPos);

                 return lerp(col, gradedCol, _Contribution);
                 }

                 ENDCG


             }
        }
            FallBack "Diffuse"
}
