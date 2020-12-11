Shader "Custom/HalfColor"
{
	Properties
	{
		_RightColor("Right Color", Color) = (0, 0, 0, 0)
		_LeftColor("LeftColor", Color) = (0, 0, 0, 0)
	}
		SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows vertex:vert
		#pragma target 3.0

		half4 _RightColor;
		half4 _LeftColor;

        struct Input
        {
			float2 uv_MainTex;
			half _XPos;
        };
        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			if (IN._XPos >= 0)
			{
				o.Albedo = _RightColor;
			}
			else
			{
				o.Albedo = _LeftColor;
			}
        }

		void vert(inout appdata_full v, out Input IN)
		{
			UNITY_INITIALIZE_OUTPUT(Input, IN);
			IN._XPos = v.vertex.y;
		}
        ENDCG
    }
    FallBack "Diffuse"
}
