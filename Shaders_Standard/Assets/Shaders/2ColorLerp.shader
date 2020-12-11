Shader "Custom/2ColorLerp"
{
    Properties
    {
		_ColorAmbiente("Color Ambiente", Color) = (1,1,1,1)
		_CustomColor("CustomColor", Color) = (0,0,0,0)
		_ColorSelector("ColorSelector", Range(0,1)) = 1
		_EmissionColor("EmissionColor", Color) = (0,0,0,0)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0
				
		float4 _ColorAmbiente;
		float4 _CustomColor;
		float4 _EmissionColor;
		float _ColorSelector;

        struct Input
        {
            float2 uv_MainTex;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			float ambienteValue = 1 - _ColorSelector;
			float customValue = 1 - ambienteValue;
			o.Albedo = _ColorAmbiente * ambienteValue + _CustomColor * customValue;
			o.Emission = _EmissionColor;
        }
        ENDCG
    }
    FallBack "Diffuse"
}