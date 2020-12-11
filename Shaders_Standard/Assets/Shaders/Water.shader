Shader "Custom/Water"
{
    Properties
    {
		_MainColor ("MainColor", Color) = (0, 0, 0, 0)
		_MainTexture("MainTexture", 2D) = "white"{}
		_NormalTexture("NormalTexture", 2D) = "white"{}
		_NormalMagnitude("NormalMagnitude", Float) = 1
		_YVelocity("YVelocity", Float) = 1
		_XVelocity("XVelocity", Float) = 1
		_AlphaValue("AlphaValue", Range(0, 1)) = 1
    }
    SubShader
    {
        Tags 
		{ 
			"Queue" = "Transparent" 
			"RenderType"="Transparent" 
			"IgnoreProjector" = "True"
		}
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows alpha:fade
        #pragma target 3.0

        sampler2D _MainTexture;
		sampler2D _NormalTexture;
		float4 _MainColor;
		float _NormalMagnitude;
		float _XVelocity;
		float _YVelocity;
		float _AlphaValue;

        struct Input
        {
            float2 uv_MainTexture;
			float2 uv_NormalTexture;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			float2 _MovedTextureUVs = IN.uv_NormalTexture;
			float2 _MovedTexture = IN.uv_MainTexture;

			float _YDistance = _YVelocity * _Time.y;
			float _XDistance = _XVelocity * _Time.y;

			_MovedTextureUVs += float2(_XDistance, _YDistance);
			_MovedTexture += float2(_XDistance, _YDistance);

			float4 _Texture = tex2D(_MainTexture, _MovedTexture);
			float4 _NormalTex = tex2D(_NormalTexture, _MovedTextureUVs);

			float3 _Normal = UnpackNormal(_NormalTex).rgb;
			_Normal.rg *= _NormalMagnitude;

			o.Normal = normalize(_Normal);
			o.Alpha = _AlphaValue;
			o.Albedo = _Texture.rgb *_MainColor.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
