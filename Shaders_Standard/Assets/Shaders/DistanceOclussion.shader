Shader "Custom/DistanceOclussion"
{
    Properties
    {
		_MainTexture("MainTexture", 2D) = "white"{}
		_MinDistance("Min Distance", Float) = 0
		_MaxDistance("Max Distance", Float) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

		sampler2D _MainTexture;
        float3 _TargetGlobalPosition;
		float _MaxDistance;
		float _MinDistance;

        struct Input
        {
            float2 uv_MainTexture;
			float3 worldPos;
			float3 worldNormal;
        };

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			float _VertToPos = dot(IN.worldNormal, _TargetGlobalPosition - IN.worldPos);
			float _Distance = distance(IN.worldPos, _TargetGlobalPosition);
			float4 _Texture = tex2D(_MainTexture, IN.uv_MainTexture);
			float4 _Output = float4(0, 0, 0, 0);
			float _Value = (_Distance - _MinDistance) / (_MaxDistance - _MinDistance);
			if (_Distance < _MinDistance)
			{
				o.Albedo = _Texture.rgb;

			}
			else if (_Distance > _MaxDistance)
			{
				float4 _Output = (_Texture.r + _Texture.g + _Texture.b) / 3;
				o.Albedo = _Output;
			}
			else
			{
				float4 _Output = (_Texture.r + _Texture.g + _Texture.b) / 3;
				o.Albedo = _Texture.rgb * (1 - _Value) + _Output.rgb * _Value;
			}
        }
        ENDCG
    }
    FallBack "Diffuse"
}