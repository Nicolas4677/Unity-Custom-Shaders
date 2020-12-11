using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

namespace PostProcessing.Gaussian_Blur._3X3
{
    [System.Serializable]
    [PostProcess(typeof(Gauss3X3Renderer), PostProcessEvent.AfterStack, "Custom/Gaussian Blur 3X3")]
    public class GaussianBlur3X3 : PostProcessEffectSettings
    {
        [Tooltip("The intensity of the blur")] [Range(0f, 1f)]
        public FloatParameter intensity = new FloatParameter() { value = 1f };
    }
}
