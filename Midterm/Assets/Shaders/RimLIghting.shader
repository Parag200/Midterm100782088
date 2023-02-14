Shader "Midterm/RimLight"
{
    Properties
    {
     _RimColor("Rim Color", Color) = (0,0.5,0.5,0.0)
     _RimPower("Rim Power", Range(0.5,8.0)) = 3.0
          
    }
        SubShader
    {

        CGPROGRAM
        #pragma surface surf Lambert
       
        struct Input
        {
        float3 viewDir;
       
        };

        float4 _RimColor;
        float _RimPower;
        void surf(Input IN, inout SurfaceOutput o)
        {
            //half rim = dot(normalize(IN.viewDir), o.Normal);
            //dot prodict of view dir and normal
            half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));//satirate makes range 0-1, makes color focused on the edges
            //o.Emission = _RimColor.rbg * rim;
            o.Emission = _RimColor.rgb * pow(rim, _RimPower);//pow rim color to make colro darker while edges brigther as more light is shown on it 
            
        }
    ENDCG
    }
        Fallback "Diffuse"
}
