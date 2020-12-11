Shader "PostProcess/Kernel8"
{
            HLSLINCLUDE
            #include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"
            TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
            float _Blend;
            float _BorderValue;
            float4 _MainTex_TexelSize;

            float4 Frag(VaryingsDefault i) : SV_Target
            {
                float4 output = float4(0, 0, 0, 1);
                float4 _Texel = _MainTex_TexelSize * 5;
                
                float4 _Texture = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x, i.texcoord.y));
                float3 X0_Y2G3 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x - 1 * _Texel.x, i.texcoord.y + 1 * _Texel.y)).rgb * float(0.06);
                float3 X1_Y2G3 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 0, i.texcoord.y + 1 * _Texel.y)).rgb * float(0.13);
                float3 X2_Y2G3 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 1 * _Texel.x, i.texcoord.y + 1 * _Texel.y)).rgb * float(0.06);
                float3 X0_Y1G3 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x - 1 * _Texel.x, i.texcoord.y + 0)).rgb * float(0.13);
                float3 X1_Y1G3 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 0, i.texcoord.y + 0)).rgb * float(0.25);
                float3 X2_Y1G3 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 1 * _Texel.x, i.texcoord.y + 0)).rgb * float(0.13);
                float3 X0_Y0G3 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x - 1 * _Texel.x, i.texcoord.y - 1 * _Texel.y)).rgb * float(0.06);
                float3 X1_Y0G3 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 0 * _Texel.x, i.texcoord.y - 1 * _Texel.y)).rgb * float(0.13);
                float3 X2_Y0G3 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 1 * _Texel.x, i.texcoord.y -1 * _Texel.y)).rgb * float(0.06);
                
                float Gauss3X3 = X0_Y2G3 + X0_Y1G3 +X0_Y0G3 + X1_Y2G3 + X1_Y1G3 + X1_Y0G3 + X2_Y2G3 + X2_Y1G3 + X2_Y0G3;
                
                float3 X2N_Y2 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x - 2 * _Texel.x, i.texcoord.y + 2 * _Texel.y)).rgb * 0.003;
                float3 X1N_Y2 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x - 1 * _Texel.x, i.texcoord.y + 2 * _Texel.y)).rgb * 0.02;
                float3 X0_Y2 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x - 0, i.texcoord.y + 2 * _Texel.y)).rgb * 0.02;
                float3 X1_Y2 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 1 * _Texel.x, i.texcoord.y + 2 * _Texel.y)).rgb * 0.02;
                float3 X2_Y2 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 2 * _Texel.x, i.texcoord.y + 2 * _Texel.y)).rgb * 0.003;
                
                float3 XY2 = X2N_Y2 + X1N_Y2 + X0_Y2 + X1_Y2 + X2_Y2;
                
                float3 X2N_Y1 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x - 2 * _Texel.x, i.texcoord.y + 1 * _Texel.y)).rgb * 0.02;
                float3 X1N_Y1 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x - 1 * _Texel.x, i.texcoord.y + 1 * _Texel.y)).rgb * 0.06;
                float3 X0_Y1 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x - 0, i.texcoord.y + 1 * _Texel.y)).rgb * 0.09;
                float3 X1_Y1 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 1 * _Texel.x, i.texcoord.y + 1 * _Texel.y)).rgb * 0.06;
                float3 X2_Y1 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 2 * _Texel.x, i.texcoord.y + 1 * _Texel.y)).rgb * 0.02;
                
                float3 XY1 = X2N_Y1 + X1N_Y1 + X0_Y1 + X1_Y1 + X2_Y1;
                
                float3 X2N_Y0 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x - 2 * _Texel.x, i.texcoord.y + 0)).rgb * 0.02;
                float3 X1N_Y0 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x - 1 * _Texel.x, i.texcoord.y + 0)).rgb * 0.09;
                float3 X0_Y0 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x - 0, i.texcoord.y + 0)).rgb * 0.14;
                float3 X1_Y0 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 1 * _Texel.x, i.texcoord.y + 0)).rgb * 0.09;
                float3 X2_Y0 = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 2 * _Texel.x, i.texcoord.y + 0)).rgb * 0.02;
                
                float3 XY0 = X2N_Y0 + X1N_Y0 + X0_Y0 + X1_Y0 + X2_Y0;
                
                float3 X2N_Y1N = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x - 2 * _Texel.x, i.texcoord.y + (-1) * _Texel.y)).rgb * 0.02;
                float3 X1N_Y1N = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x - 1 * _Texel.x, i.texcoord.y + (-1) * _Texel.y)).rgb * 0.06;
                float3 X0_Y1N = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x - 0, i.texcoord.y + (-1) * _Texel.y)).rgb * 0.09;
                float3 X1_Y1N = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 1 * _Texel.x, i.texcoord.y + (-1) * _Texel.y)).rgb * 0.06;
                float3 X2_Y1N = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 2 * _Texel.x, i.texcoord.y + (-1) * _Texel.y)).rgb * 0.02;
                
                float3 XY1N = X2N_Y1N + X1N_Y1N + X0_Y1N + X1_Y1N + X2_Y1N;
                
                float3 X2N_Y2N = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x - 2 * _Texel.x, i.texcoord.y + (-2) * _Texel.y)).rgb * 0.003;
                float3 X1N_Y2N = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x - 1 * _Texel.x, i.texcoord.y + (-2) * _Texel.y)).rgb * 0.02;
                float3 X0_Y2N = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x - 0, i.texcoord.y + (-2) * _Texel.y)).rgb * 0.02;
                float3 X1_Y2N = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 1 * _Texel.x, i.texcoord.y + (-2) * _Texel.y)).rgb * 0.02;
                float3 X2_Y2N = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, float2(i.texcoord.x + 2 * _Texel.x, i.texcoord.y + (-2) * _Texel.y)).rgb * 0.003;
                
                float3 XY2N = X2N_Y2N + X1N_Y2N + X0_Y2N + X1_Y2N + X2_Y2N;
                
                float Gauss5X5 = XY2 + XY1 + XY0 + XY1N + XY2N;
                output.rgb = _Texture * (1 - _Blend) + ((Gauss5X5 - Gauss3X3) * _BorderValue) * _Blend;
                
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
