Shader "Midterm/BumpRim"
{
    Properties{
        _myDiffuse("Diffuse Texture", 2D) = "white" {}//These will open the door to using diffuse lighting with the normal mapped
        _myBump("Bump Texture", 2D) = "bump" {}       //texture being changeable with a slider between 0 and 10
        _mySlider("Bump Amount", Range(0,10)) = 1
             _RimColor("Rim Color", Color) = (0,0.5,0.5,0.0)
     _RimPower("Rim Power", Range(0.5,8.0)) = 3.0
    }

        SubShader{
         CGPROGRAM
         #pragma surface surf Lambert//compiling as a lambert type of shader, essentially utilizing diffuse lighting as a fundamental force
         sampler2D _myDiffuse;//Our variables needed for outputting
         sampler2D _myBump;
         half _mySlider;
         struct Input {//outputting our uv coords of the diffuse lighting and the normal mapped texture
         float2 uv_myDiffuse;
         float2 uv_myBump;
         float3 viewDir;

         };

         float4 _RimColor;
         float _RimPower;
         void surf(Input IN, inout SurfaceOutput o) {//Our albedo has the diffuse texture and its uv coords colors
             o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;
             o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump));//the surface normal has the unpacked normal mapped texture and uv coords
             o.Normal *= float3(_mySlider, _mySlider, 1);//the surface is multipled by the current value of the slider
             half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));//satirate makes range 0-1, makes color focused on the edges
           //o.Emission = _RimColor.rbg * rim;
             o.Emission = _RimColor.rgb * pow(rim, _RimPower);//pow rim color to make colro darker while edges brigther as more light is shown on it 
         }
         ENDCG
        }
            FallBack "Diffuse"
}
