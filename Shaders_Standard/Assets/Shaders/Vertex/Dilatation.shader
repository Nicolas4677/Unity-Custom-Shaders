Shader "Custom/Dilatation"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_EffectMagnitude("Effect Magnitude", Range(-0.03, 0.03)) = 0.03
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows vertex:vert
        #pragma target 3.0

        sampler2D _MainTex;
		half _EffectMagnitude;

        struct Input
        {
            float2 uv_MainTex;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
        }

		void vert(inout appdata_full v, out Input IN)
		{
			UNITY_INITIALIZE_OUTPUT(Input, IN);
			v.vertex.xyz += v.normal * _EffectMagnitude;
		}
        ENDCG
    }
    FallBack "Diffuse"
}
