using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

namespace PostProcessing.Border_Detection.Complex
{
    [PostProcess(typeof(ComplexBorderDetectionRenderer), PostProcessEvent.AfterStack,"Custom/Complex Border Detection")]
    public sealed class ComplexBorderDetection : PostProcessEffectSettings
    {
        [Tooltip("The intensity of the effect")] [Range(0f, 1f)]
        public FloatParameter intensity = new FloatParameter() { value = 1f};
    }
}