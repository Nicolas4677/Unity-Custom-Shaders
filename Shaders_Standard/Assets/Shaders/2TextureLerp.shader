Shader "Custom/2TextureLerp"
{
    Properties
    {
		_Texture1("Textura1 (RGB)", 2D) = "white"{}
		_Texture2("Textura2 (RGB)", 2D) = "white"{}
		_TextureSelector("Texture Selector", Range(0, 1)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

		sampler2D _Texture1;
		sampler2D _Texture2;
		float _TextureSelector;

        struct Input
        {
			float2 uv_Texture1;
			float2 uv_Texture2;
        };
		
        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			float _Texture1Value = 1 - _TextureSelector;
			float _Texture2Value = 1 - _Texture1Value;
			float4 T1 = tex2D(_Texture1, IN.uv_Texture1);
			float4 T2 = tex2D(_Texture2, IN.uv_Texture2);

			o.Albedo = T1.rgb * _Texture1Value + T2.rgb * _Texture2Value;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
