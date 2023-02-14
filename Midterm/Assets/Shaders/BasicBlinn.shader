Shader "Midterm/BasicBlinn"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _MainTex("MainTex", 2D) = "white" {}

    }
        SubShader
    {
        Tags { "Queue" = "Geometry" }
        LOD 200

        CGPROGRAM

        #pragma surface surf BasicBlinn
        sampler2D _MainTex;//texture input 

        half4 LightingBasicBlinn(SurfaceOutput s, half3 lightDir, half3 viewDir ,half atten)
        {
            half3 h = normalize(lightDir + viewDir);

            half diff = max(0, dot(s.Normal, lightDir));

            float nh = max(0, dot(s.Normal, h));
            float spec = pow(nh, 48.0);

            half4 c;
            c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * atten;
            c.a = s.Alpha;
            return c;
        }


        struct Input
        {
            float2 uv_MainTex;
        };


        fixed4 _Color;

        void surf(Input IN, inout SurfaceOutput o)
        {

            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;//setting albedo to texutre 

        }
        ENDCG
    }
        FallBack "Diffuse"
}
