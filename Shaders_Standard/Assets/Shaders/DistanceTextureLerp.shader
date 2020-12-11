Shader "Custom/DistanceTextureLerp"
{
    Properties
    {
		_TextureOne("Texrue 1", 2D) = "white"{}
		_TextureTwo("Texture 2", 2D) = "white"{}
		_OriginPoint("Origin Vector", Vector) = (0, 0, 0, 0)
		_MinDistance("Min Distance", Float) = 0
		_MaxDistance("Max Distance", Float) = 1
	}
		SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		sampler2D _TextureOne;
		sampler2D _TextureTwo;
		float4 _OriginPoint;
		float _MinDistance;
		float _MaxDistance;

        struct Input
        {
            float2 uv_TextureOne;
			float2 uv_TextureTwo;
			float3 worldPos;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			float4 _Texture1 = tex2D(_TextureOne, IN.uv_TextureOne);
			float4 _Texture2 = tex2D(_TextureTwo, IN.uv_TextureTwo);
			float4 _Texture;

			float _XDistance = IN.worldPos.x - _OriginPoint.x;
			if (_XDistance > _MaxDistance)
			{
				o.Albedo = _Texture1;
			}
			else if(_XDistance < _MinDistance)
			{
				o.Albedo = _Texture2;
			}
			else
			{
				float _Value = (_XDistance - _MinDistance) / (_MaxDistance - _MinDistance);
				if (abs(IN.worldPos.x) > _OriginPoint.x)
				{
					//o.Albedo = ;
				}
				else
				{

				}
			}
        }
        ENDCG
    }
    FallBack "Diffuse"
}
