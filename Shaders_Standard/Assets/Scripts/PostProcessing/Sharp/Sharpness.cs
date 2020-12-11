using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

namespace PostProcessing.Sharp
{
    [PostProcess(typeof(SharpnessRenderer), PostProcessEvent.AfterStack, "Custom/Sharpness")]
    public sealed class Sharpness : PostProcessEffectSettings
    {
        [Tooltip("The intensity of the effect")] [Range(0f, 1f)]
        public FloatParameter intensity = new FloatParameter() { value = 1f};
    }
}