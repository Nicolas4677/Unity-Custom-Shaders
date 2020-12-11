// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/Hologram"
{
	Properties
	{
	    [HDR]
		_Color("Color", Color) = (1,1,1,1)
		_Vy("Velocity Y", float) = 1
		_EmissionValue("EmissionValue", float) = 1
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
		float _Vy;
		float _EmissionValue;

		struct Input
		{
			float2 uv_HologramTexture;
			float3 worldNormal;
			float3 viewDir;
			float3 worldPos;
			float3 objectPos;
		};
		UNITY_INSTANCING_BUFFER_START(Props)
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			float _Border = abs(dot(IN.worldNormal, IN.viewDir));
			float _BorderValue = 1 - _Border;

			float2 _MovedTexture = IN.objectPos - IN.worldPos;
			float _YDistance = _Vy * _Time.y;
			float _XDistance = 0;
			_MovedTexture += float2(_XDistance, _YDistance);
			float4 _HologramTex = tex2D(_HologramTexture, _MovedTexture);

			o.Alpha = _BorderValue;
			o.Emission = (_Color.rgb + _HologramTex) * _EmissionValue;
		}
		ENDCG
	}
		FallBack "Diffuse"
}