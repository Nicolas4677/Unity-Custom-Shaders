Shader "PostProcess/Kernel5"
{
            HLSLINCLUDE
            #include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"
            TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
            float _Blend;
            float4 _MainTex_TexelSize;

            float4 Frag(VaryingsDefault i) : SV_Target
            {
                float4 output = float4(0, 0, 0, 1);
                float4 _Texel = _MainTex_TexelSize * 5;
                
                float4 _Texture = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x, i.texcoord.y));
                float3 X0_Y2 = 0;
                float3 X1_Y2 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 0, i.texcoord.y + 1 * _Texel.y)).rgb * float(0.13);
                float3 X2_Y2 = 0;
                float3 X0_Y1 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x - 1 * _Texel.x, i.texcoord.y + 0)).rgb * 1;
                float3 X1_Y1 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 0, i.texcoord.y + 0)).rgb * (-4);
                float3 X2_Y1 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 1 * _Texel.x, i.texcoord.y + 0)).rgb * 1;
                float3 X0_Y0 = 0;
                float3 X1_Y0 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 0 * _Texel.x, i.texcoord.y - 1 * _Texel.y)).rgb * 1;
                float3 X2_Y0 = 0;
                output.rgb = X0_Y2 + X0_Y1 +X0_Y0 + X1_Y2 + X1_Y1 + X1_Y0 + X2_Y2 + X2_Y1 + X2_Y0;
                return _Texture * (1 - _Blend) + output * _Blend;
            }
            ENDHLSL
    SubShader
    {
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            HLSLPROGRAM

                #pragma vertex VertDefault
                #pragma fragment Frag

            ENDHLSL
        }
    }
}
