Shader "Custom/ShaderMask"
{
    Properties
    {
		_MainTexture("_MainTexture (RGB)", 2D) = "white"{}
		_TextureMask("_TextureMask (RGB)", 2D) = "white"{}
		_EyeColor("_EyeColor", Color) = (0,0,0,0)
		_JacketColor("_JacketColor", Color) = (0,0,0,0)
		_HairColor("_HairColor", Color) = (0,0,0,0)
	}
		SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		sampler2D _MainTexture;
		sampler2D _TextureMask;
		float4 _EyeColor;
		float4 _JacketColor;
		float4 _HairColor;

        struct Input
        {
            float2 uv_MainTexture;
        };
        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			float4 _Mask = tex2D(_TextureMask, IN.uv_MainTexture);
			float4 T = tex2D(_MainTexture, IN.uv_MainTexture);

			float _Masks = _Mask.r + _Mask.g + _Mask.b;
			float3 _ColorMask = T * (1 - _Masks) + (_JacketColor * _Mask.r) + (_HairColor * _Mask.g) + (_EyeColor * _Mask.b);

			o.Albedo = _ColorMask;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
