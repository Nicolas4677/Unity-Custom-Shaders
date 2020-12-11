Shader "Custom/Snow"
{
    Properties
    {
        _MainTexture ("Albedo (RGB)", 2D) = "white" {}
		_NoiseTexture("Noise Texture", 2D) = "white"{}
		_SnowDirection ("Snow Direction", Vector) = (0, 1, 0, 0)
		_SnowAmount ("Snow Amount", Range(0, 1)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

        sampler2D _MainTexture;
		sampler2D _NoiseTexture;
		float4 _SnowDirection;
		float _SnowAmount;

        struct Input
        {
            float2 uv_MainTexture;
			float2 uv_NoiseTexture;
			float3 worldNormal;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			float4 _Texture = tex2D(_MainTexture, IN.uv_MainTexture);
			float4 _Noise = tex2D(_NoiseTexture, IN.uv_NoiseTexture);

			_Noise = 0.5 + (_Noise - 0.5.x) * (1 - 0.5) / (1 - 0.5);

			float _Value = dot(IN.worldNormal, _SnowDirection);
			_Value = clamp(_Value, 0, 1);

			_Noise *= _Value;

			o.Albedo = _Texture.rgb + (_Noise * _SnowAmount);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
