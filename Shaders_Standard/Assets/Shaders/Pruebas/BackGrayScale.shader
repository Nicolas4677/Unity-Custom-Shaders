Shader "Custom/BackGrayScale"
{
    Properties
    {
		_MainTexture("Main Texture", 2D) = "white"{}
	}
		SubShader
	{
		Tags
		{
			"Queue" = "Transparent"
			"RenderType" = "Transparent"
			"IgnoreProjector" = "True"
		}
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		sampler2D _MainTexture;

        struct Input
        {
            float2 uv_MainTexture;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			o.Albedo = tex2D(_MainTexture, IN.uv_MainTexture);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
