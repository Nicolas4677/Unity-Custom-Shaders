using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

namespace PostProcessing.CornerDetection
{
    [PostProcess(typeof(CornerDetectionRenderer), PostProcessEvent.AfterStack, "Custom/Corner Detection")]
    public class CornerDetection : PostProcessEffectSettings
    {
        [Tooltip("The intensity of the effect")] [Range(0f, 1f)]
        public FloatParameter intensity = new FloatParameter() { value = 1f };
    }
}