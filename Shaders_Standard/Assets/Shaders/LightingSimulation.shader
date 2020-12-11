Shader "Custom/LightingSimulation"
{
    Properties
    {
		_MainTexture("Main Texture", 2D) = "white"{}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Simulation
        #pragma target 3.0

        sampler2D _MainTexture;

        struct Input
        {
            float2 uv_MainTexture;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
			half4 _Texture = tex2D(_MainTexture, IN.uv_MainTexture);
			o.Albedo = _Texture;
        }

		half4 LightingSimulation(SurfaceOutput s, float3 lightDir, float atten)
		{
			half NdotL = dot(s.Normal, lightDir);
			half4 light;
			light.rgb = (NdotL * atten) * s.Albedo * _LightColor0;
			light.a = s.Alpha;
			return light;
		}
        ENDCG
    }
    FallBack "Diffuse"
}
