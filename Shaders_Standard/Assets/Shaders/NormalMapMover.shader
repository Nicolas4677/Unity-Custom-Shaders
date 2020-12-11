Shader "Custom/NormalMapMover"
{
    Properties
	{
		_HairColor("_HairColor", Color) = (0, 0, 0, 0)
		_TextureMask("_TextureMask (RGB)", 2D) = "white"{}
		_NormalMagnitude("_NormalMagnitude", Range(0,1)) = 1
		_TextureSpeed("_TextureSpeed", Range(0, 5)) = 5

		_MainTexture("_MainTexture (RGB)", 2D) = "white"{}
		_NormalMainTexture("_MainNormalTexture (RGB)", 2D) = "white"{}

		_JacketTexture("_JacketTexture (RGB)", 2D) = "white"{}
		_NormalJacketTexture("_NormalJacketTexture (RGB)", 2D) = "white"{}

		_EyesTexture("_EyesTexture (RGB)", 2D) = "white"{}
		_NormalEyesTexture("_NormalEyesTexture (RGB)", 2D) = "white"{}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

        sampler2D _MainTexture;
        sampler2D _JacketTexture;
        sampler2D _EyesTexture;
		sampler2D _TextureMask;
		sampler2D _NormalTexture;

		float4 _HairColor;

		float _NormalMagnitude;
		float _TextureSpeed;

        struct Input
        {
            float2 uv_MainTexture;
            float2 uv_NormalMainTexture;
            float2 uv_NormalJacketTexture;
            float2 uv_NormalEyesTexture;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			//Almacena valores rgba
			float4 _MainText = tex2D(_MainTexture, IN.uv_MainTexture);
			float4 _Mask = tex2D(_TextureMask, IN.uv_MainTexture);
			float4 _JacketText = tex2D(_JacketTexture, IN.uv_MainTexture);
			float4 _EyesText = tex2D(_EyesTexture, IN.uv_MainTexture);

			//Mueve Normales
			float XDistance = 0 * _Time.y;
			float YDistance = 0.25 * _Time.y;

			float2 _JacketNormal = IN.uv_NormalJacketTexture;
			float2 _EyesNormal = IN.uv_NormalEyesTexture;

			_JacketNormal += float2(XDistance, YDistance);
			_EyesNormal += float2(XDistance, YDistance);
			//Asigna colores al Albedo
			float _Masks = _Mask.r + _Mask.g + _Mask.b;
			float3 _TextMask = _MainText * (1 - _Masks) + (_JacketText * _Mask.r) + (_HairColor * _Mask.g) + (_EyesText * _Mask.b);
			o.Albedo = _TextMask;

			//Asigna normal
			float4 _NormalText = tex2D(_MainTexture, IN.uv_NormalMainTexture);
			float3 _Normal = UnpackNormal(_NormalText).rgb;
			_Normal.rg *= _NormalMagnitude;
			o.Normal = normalize(_Normal);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
