Shader "Midterm/BasicToonShader"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _RampTex("Ramp Texture", 2D) = "white" {}
       
    }
        SubShader
    {

        CGPROGRAM

        #pragma surface surf ToonRamp// type of lighting toonramp 

        fixed4 _Color;
        sampler2D _RampTex;//tex with the shades of black to white 
        

        struct Input
        {
            float2 uv_MainTex;
        };



        float4 LightingToonRamp(SurfaceOutput s, fixed3 lightDir, fixed atten)//spearting each shade based off how dark they are 
        {
            float diff = dot(s.Normal, lightDir);//dot product to get 1
            float h = diff * 0.5 + 0.5;//get equal to 1
            float2  rh = h;//sets dark to uv00 and light to uv11
            float3 ramp = tex2D(_RampTex, rh).rgb;

            float4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * (ramp);//sets color of light
            c.a = s.Albedo;
            return c;
        }

        void surf(Input IN, inout SurfaceOutput o)
        {

            o.Albedo = _Color.rgb;
            //o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;

        }
        ENDCG
    }
        FallBack "Diffuse"
}
