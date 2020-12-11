Shader "Custom/ForceField"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_EmissionValue("EmissionValue", Float) = 1
		_BorderMinValue("BorderMinValue", Range(0, 1)) = 0.3
		_HologramTexture("_HologramTexture", 2D) = "white"{}
	}
		SubShader
	{
		Tags
		{
		"Queue" = "Transparent"
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

		sampler2D _HologramTexture;
		float4 _Color;
		float _EmissionValue;
		float _BorderMinValue;

		struct Input
		{
			float2 uv_HologramTexture;
			float3 worldNormal;
			float3 viewDir;
		};
		UNITY_INSTANCING_BUFFER_START(Props)
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			float _Border = abs(dot(IN.worldNormal, IN.viewDir));
			float _BorderValue = 1 - _Border;

			float4 _HologramTex = tex2D(_HologramTexture, IN.uv_HologramTexture);

			o.Alpha = _BorderValue * _BorderMinValue;
			o.Emission = (_Color.rgb + _HologramTex * _BorderValue) * _EmissionValue;
		}
		ENDCG
	}
		FallBack "Diffuse"
}
