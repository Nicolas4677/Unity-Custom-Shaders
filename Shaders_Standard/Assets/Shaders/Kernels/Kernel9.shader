Shader "PostProcess/Kernel9"
{    HLSLINCLUDE
            #include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"
            TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
            float _Blend;
            float4 _MainTex_TexelSize;

            float4 Frag(VaryingsDefault i) : SV_Target
            {
                float4 output = float4(0, 0, 0, 1);
                float4 _Texel = _MainTex_TexelSize * 5;
                
                float3 _Texture = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x, i.texcoord.y)).rgb;
                float3 X0_Y2x = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x - 1 * _Texel.x, i.texcoord.y + 1 * _Texel.y)).rgb * 1;
                float3 X1_Y2x = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 0, i.texcoord.y + 1 * _Texel.y)).rgb * 2;
                float3 X2_Y2x = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 1 * _Texel.x, i.texcoord.y + 1 * _Texel.y)).rgb * 1;
                float3 X0_Y1x = 0;
                float3 X1_Y1x = 0;
                float3 X2_Y1x = 0;
                float3 X0_Y0x = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x - 1 * _Texel.x, i.texcoord.y - 1 * _Texel.y)).rgb * (-1);
                float3 X1_Y0x = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 0 * _Texel.x, i.texcoord.y - 1 * _Texel.y)).rgb * (-2);
                float3 X2_Y0x = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 1 * _Texel.x, i.texcoord.y -1 * _Texel.y)).rgb * (-1);
                
                float3 XYx = X0_Y2x + X0_Y1x +X0_Y0x + X1_Y2x + X1_Y1x + X1_Y0x + X2_Y2x + X2_Y1x + X2_Y0x; 
                
                float3 X0_Y2y = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x - 1 * _Texel.x, i.texcoord.y + 1 * _Texel.y)).rgb * 1;
                float3 X1_Y2y = 0;
                float3 X2_Y2y = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 1 * _Texel.x, i.texcoord.y + 1 * _Texel.y)).rgb * (-1);
                float3 X0_Y1y = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x - 1 * _Texel.x, i.texcoord.y + 0)).rgb * 2;
                float3 X1_Y1y = 0;
                float3 X2_Y1y = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 1 * _Texel.x, i.texcoord.y + 0)).rgb * (-2);
                float3 X0_Y0y = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x - 1 * _Texel.x, i.texcoord.y - 1 * _Texel.y)).rgb * 1;
                float3 X1_Y0y = 0;
                float3 X2_Y0y = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 1 * _Texel.x, i.texcoord.y -1 * _Texel.y)).rgb * (-1);
                
                float3 XYy = X0_Y2y + X0_Y1y +X0_Y0y + X1_Y2y + X1_Y1y + X1_Y0y + X2_Y2y + X2_Y1y + X2_Y0y; 
                
                output.rgb = (_Texture * (1 - _Blend)) +  (sqrt(pow(XYx, 2) + pow(XYy, 2)) * _Blend);
                return output;
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
