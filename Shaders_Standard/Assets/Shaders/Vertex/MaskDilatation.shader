Shader "Custom/MaskDilatation"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_MaskTexture("Mask texture", 2D) = "white" {}
		_EffectMagnitude("Effect Magnitude", Range(-0.01, 0.03)) = 0.01
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows vertex:vert
        #pragma target 3.0

        sampler2D _MainTex;
		sampler2D _MaskTexture;
		half _EffectMagnitude;

        struct Input
        {
            float2 uv_MainTex;
			float3 _ColorMask;
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
			half4 _Masks= tex2Dlod(_MaskTexture, float4(v.texcoord.xy, 0, 0));

			half _Mask = _Masks.r + _Masks.g + _Masks.b;
			if (_Mask > 0 )
			{
				v.vertex.xyz += v.normal * _EffectMagnitude;
			}
		}
        ENDCG
    }
    FallBack "Diffuse"
}
