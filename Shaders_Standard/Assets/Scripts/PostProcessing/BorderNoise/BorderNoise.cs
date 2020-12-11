using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

namespace PostProcessing.BorderNoise
{
    [PostProcess(typeof(BorderNoiseRenderer), PostProcessEvent.AfterStack, "Custom/Border Noise")]
    public class BorderNoise : PostProcessEffectSettings
    {
        [Tooltip("The intensity of the effect")] [Range(0f, 1f)]
        public FloatParameter intensity = new FloatParameter() { value = 1f};
        [Tooltip("The intensity of the borders")] [Range(0f, 50f)]
        public FloatParameter borderNoise = new FloatParameter() { value = 50f};
    }
}