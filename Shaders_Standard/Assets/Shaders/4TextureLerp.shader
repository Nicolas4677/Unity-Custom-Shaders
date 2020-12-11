Shader "Custom/4TextureLerp"
{
    Properties
    {
		_Texture1("Texture1 (RGB)", 2D) = "white"{}
		_Texture2("Texture2 (RGB)", 2D) = "white"{}
		_Texture3("Texture3 (RGB)", 2D) = "white"{}
		_Texture4("Texture4 (RGB)", 2D) = "white"{}
		_TextureSelector("Texture Selector", Range(0, 4)) = 1
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
		sampler2D _Texture3;
		sampler2D _Texture4;
		float _TextureSelector;

        struct Input
        {
			float2 uv_Texture1;
			float2 uv_Texture2;
			float2 uv_Texture3;
			float2 uv_Texture4;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			float4 T;

			if (_TextureSelector <= 1)
			{
				float4 T1 = tex2D(_Texture1, IN.uv_Texture1);
				float4 T2 = tex2D(_Texture2, IN.uv_Texture2);

				float _T1Value = 1 - _TextureSelector;
				T.rgb = T1.rgb * _T1Value + T2.rgb * _TextureSelector;
			}
			else if (_TextureSelector <= 2 && _TextureSelector > 1)
			{
				float4 T2 = tex2D(_Texture2, IN.uv_Texture2);
				float4 T3 = tex2D(_Texture3, IN.uv_Texture3);

				float _T2Value = 2 - _TextureSelector;
				T.rgb = T2.rgb * _T2Value + T3.rgb * (_TextureSelector - 1);
			}
			else
			{
				float4 T3 = tex2D(_Texture3, IN.uv_Texture3);
				float4 T4 = tex2D(_Texture4, IN.uv_Texture4);

				float _T3Value = 3 - _TextureSelector;
				T.rgb = T3.rgb * _T3Value + T4.rgb * (_TextureSelector - 2);
			}
			o.Albedo = T.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
