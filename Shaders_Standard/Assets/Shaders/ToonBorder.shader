Shader "Custom/ToonBorder"
{
    Properties
    {
        _BorderColor ("_BorderColor", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_EmissionValue("_EmissionValue", Range(0, 1)) = 0
		_BorderMinValue("_BorderMinValue", Range(0, 1)) = 0.75
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

        sampler2D _MainTex;
		float4 _BorderColor;
		float _EmissionValue;
		float _BorderMinValue;

        struct Input
        {
            float2 uv_MainTex;
			float3 worldNormal;
			float3 viewDir;
        };
        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			float _Border = abs(dot(IN.worldNormal, IN.viewDir));
			float _BorderValue = 1 - _Border;

			float4 _Texture = tex2D(_MainTex, IN.uv_MainTex);
			if (_BorderValue >= _BorderMinValue)
			{
				o.Albedo = _BorderColor;
				o.Emission = _BorderColor.rgb * _EmissionValue;
			}
			else
			{
				o.Albedo = _Texture.rgb;
			}
        }
        ENDCG
    }
    FallBack "Diffuse"
}