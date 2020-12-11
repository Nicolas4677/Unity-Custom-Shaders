using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

namespace PostProcessing.Border_Detection.Simple
{
    [PostProcess(typeof(SimpleBorderDetectionRenderer), PostProcessEvent.AfterStack, "Custom/Simple Border Detection")]
    public sealed class SimpleBorderDetection : PostProcessEffectSettings
    {
        [Tooltip("The intensity of the effect")] [Range(0f, 1f)]
        public FloatParameter intensity = new FloatParameter() { value = 1f};
    }
}
