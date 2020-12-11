Shader "Custom/TransparentMaskMovement"
{
    Properties
    {
        _MainTex ("_MainTexture", 2D) = "white" {}
        _MaskTexture ("_MaskTexture", 2D) = "white" {}
    }
    SubShader
    {
        Tags 
		{
			"Queue" = "Transparent"//o 3000
			"IgnoreProjector" = "True"
			"RenderType" = "TransparentCutout"
		}
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows alpha:fade
        #pragma target 3.0

		sampler2D _MainTex;
		sampler2D _MaskTexture;

        struct Input
        {
            float2 uv_MainTex;
			float2 uv_MaskTexture;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			float2 _MovedTexture = IN.uv_MaskTexture;
			float _YDistance = 0.25 * _Time.y;
			float _XDistance = 0 * _Time.y;
			_MovedTexture += float2(_XDistance, _YDistance);
			float4 _Mask = tex2D(_MaskTexture, _MovedTexture);
			float4 _Texture = tex2D(_MainTex, IN.uv_MainTex);

			float _Masks = _Mask.r + _Mask.g + _Mask.b;
			float3 _ColorMask = _Texture * (1 - _Masks) + (_Texture * _Mask.r) + (_Texture * _Mask.g) + (_Texture * _Mask.b);
			if (_Masks > 0)
			{
				o.Alpha = 1;
			}
			else
			{
				o.Alpha = 0;
			}
			o.Albedo = _ColorMask;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
