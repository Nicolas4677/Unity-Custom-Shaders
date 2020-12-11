Shader "Custom/GrayScale"
{
    Properties
    {
		_Texture("Textura (RGB)", 2D) = "white"{}
		_Color("Color", Color) = (1,1,1,1)
		_TextureSelector("Texture Selector", Range(0, 1)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

		sampler2D _Texture;
		float4 _Color;
		float _TextureSelector;

        struct Input
        {
            float2 uv_Texture;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			float4 T = tex2D(_Texture, IN.uv_Texture); 
			float _GrayValue = 1 - _TextureSelector;
			float _NormalValue = 1 - _GrayValue;
			float _Gray = (T.r + T.g + T.b) / 3;
			o.Albedo = float3(_Gray, _Gray, _Gray) * _GrayValue + _NormalValue * T.rgb;
			/*if (T.r >= 2 * T.g && T.r >= 2 * T.b)
			{
				//Determines if it is a red color
				float3 red = float3(1, 0, 0);
				o.Albedo = red;
			}
			else
			{
				//SetGrayScale
				float _GrayValue = 1 - _TextureSelector;
				float _NormalValue = 1 - _GrayValue;
				float _Gray = (T.r + T.g + T.b) / 3;
				o.Albedo = float3(_Gray, _Gray, _Gray) * _GrayValue + _NormalValue * T.rgb;
			}*/
        }
        ENDCG
    }
    FallBack "Diffuse"
}
