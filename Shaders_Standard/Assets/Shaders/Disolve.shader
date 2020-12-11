Shader "Custom/Disolve"
{
    Properties
    {
		_MainTexture("Main Texture", 2D) = "white"{}
		_NoiseTexture("Noise Texture", 2D) = "white"{}
		_ClipTreshold("Clip Treshold", Range(0, 1)) = 1
		_EdgeThickness("Edge Thickness", Range(0.01, 0.05)) = 0.03
		[HDR]_EmissionColor("EmissionColor", Color) = (0, 0, 0, 0)
		_EmissionValue("Emission Value", Float) = 1
    }
    SubShader
    {
        Tags 
		{ 
			"RenderType"="Opaque" 
		}
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        #pragma target 3.0
		#include "UnityCG.cginc"

        sampler2D _MainTexture;
		sampler2D _NoiseTexture;
		float4 _EmissionColor;
		float _EmissionValue;
		float _ClipTreshold;
		float _EdgeThickness;

        struct Input
        {
            float2 uv_MainTexture;
			float2 uv_NoiseTexture;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			float4 _Texture = tex2D(_MainTexture, IN.uv_MainTexture);
			float4 _Noise = tex2D(_NoiseTexture, IN.uv_NoiseTexture);
			float _AlphaValue = (_Noise.r + _Noise.g + _Noise.b) / 3;
			if (_AlphaValue <= _ClipTreshold)
			{
				discard;
			}
			else
			{
				float4 _Value = (_ClipTreshold + _EdgeThickness, _ClipTreshold + _EdgeThickness, _ClipTreshold + _EdgeThickness, _ClipTreshold + _EdgeThickness);
				o.Emission = _EmissionColor * step(_Noise, _Value) * _EmissionValue;
			}
			o.Alpha = _Noise;
			o.Albedo = _Texture.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
