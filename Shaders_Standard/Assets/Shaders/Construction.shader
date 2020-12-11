Shader "Custom/Construction"
{
    Properties
    {
        _MainTex("Main Texture", 2D) = "white"{}
        _YVelocity("Y Velocity", Float) = 0.25
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

        sampler2D _MainTex;
        half _YVelocity;

        struct Input
        {
            float2 uv_MainTex;
            float _YPos;
        };
        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            half _MinValue = 0;
            _MinValue += _YVelocity * _Time.y;
            if(IN._YPos <= _MinValue)
            {
                discard;
            }
            else
            {
                half4 _Texture = tex2D(_MainTex, IN.uv_MainTex);
                o.Albedo = _Texture.rgb;
            }
        }
        
		void vert(inout appdata_full v, out Input IN)
		{
			UNITY_INITIALIZE_OUTPUT(Input, IN);
			IN._YPos = v.vertex.x;
		}
        ENDCG
    }
    FallBack "Diffuse"
}
