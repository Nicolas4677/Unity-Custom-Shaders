Shader "Custom/TranspatentColorMovement"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
		_MaskTexture("_MaskTexture", 2D) = "white" {}
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

		sampler2D _MaskTexture;
		float4 _Color;

        struct Input
        {
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

			float _Masks = _Mask.r + _Mask.g + _Mask.b;
			float3 _ColorMask = _Color * (1 - _Masks) + (_Color * _Mask.r) + (_Color * _Mask.g) + (_Color * _Mask.b);
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
