Shader "Custom/MaskTransparentBorders"
{
    Properties
    {
        _MainTexture ("_MainTexture", 2D) = "white" {}
        _MaskTexture ("_MaskTexture", 2D) = "white" {}
		_BorderMinValue("_BorderMinValue", Range(0, 1)) = 0.75
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
		Pass
		{
			ZWrite On
			ColorMask 0
		}
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows alpha:fade
        #pragma target 3.0

        sampler2D _MainTexture;
		sampler2D _MaskTexture;
		float _BorderMinValue;

        struct Input
        {
            float2 uv_MainTexture;
			float3 worldNormal;
			float3 viewDir;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			float4 _Texture = tex2D(_MainTexture, IN.uv_MainTexture);
			float4 _Mask = tex2D(_MaskTexture, IN.uv_MainTexture);

			float _Border = abs(dot(IN.worldNormal, IN.viewDir));
			float _BorderValue = 1 - _Border;

			float _Masks = _Mask.r + _Mask.g + _Mask.b;
			float3 _ColorMask = _Texture * (1 - _Masks) + (_Texture * _Mask.r);
			if (_BorderValue >= _BorderMinValue)
			{
				o.Alpha = _BorderValue;
			}
			else if (_Masks > 0)
			{
				o.Alpha = 1;
			}
			else
			{
				o.Alpha = 0;
			}

			o.Albedo = _ColorMask.rgb;
			o.Emission = _Texture.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
