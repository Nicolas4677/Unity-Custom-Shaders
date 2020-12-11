Shader "Custom/BorderAlpha"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
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

		float4 _Color;
		float _BorderMinValue;

        struct Input
        {
			float3 worldNormal;
			float3 viewDir;
        };
        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			float _Border = abs(dot(IN.worldNormal, IN.viewDir));
			float _BorderValue = 1 - _Border;
			if (_BorderValue >= _BorderMinValue)
			{
				o.Alpha = _BorderValue;
			}
			else
			{
				o.Alpha = 0;
			}
			o.Emission = _Color.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
