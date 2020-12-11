Shader "Custom/Toon"
{
    Properties
    {
		_MainTexture("Main Texture", 2D) = "white"{}
		_ShadowTexture("Shadow Texture", 2D) = "white"{}
		_BorderColor("Border Color", Color) = (0, 0, 0, 0)
		_MinBorderValue("Min Border Value", Range(0, 1)) = 0.75
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Simulation
        #pragma target 3.0

        sampler2D _MainTexture;
		sampler2D _ShadowTexture;
		float4 _BorderColor;
		float _MinBorderValue;

        struct Input
        {
            float2 uv_MainTexture;
			float3 viewDir;
			float3 worldNormal;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
			float NdotV = abs(dot(IN.worldNormal, IN.viewDir));
			float _BorderValue = 1 - NdotV;
			if (_BorderValue >= _MinBorderValue)
			{
				o.Albedo = _BorderColor;
			}
			else
			{
				float4 _Texture = tex2D(_MainTexture, IN.uv_MainTexture);
				o.Albedo = _Texture.rgb;
			}
        }

		half4 LightingSimulation(SurfaceOutput s, float3 lightDir, float atten)
		{
			half NdotL = dot(s.Normal, lightDir);
			half4 light;
			float _SoftLight = tex2D(_ShadowTexture, float2(NdotL, 0));
			if (NdotL > 0)
			{
				light.rgb = s.Albedo * atten * _LightColor0 * _SoftLight;
			}
			else
			{
				light.rgb = float3(0, 0, 0);
			}
			light.a = s.Alpha;
			return light;
		}
        ENDCG
    }
    FallBack "Diffuse"
}
//float Luz = dot(s.Normal, direccionLuz);
//float LuzDiscreta = tex2D(_Rampa, float2(Luz, 0));
