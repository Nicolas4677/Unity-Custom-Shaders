using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

namespace PostProcessing.Gaussian_Blur._5X5
{
    [PostProcess(typeof(Gauss5X5Renderer), PostProcessEvent.AfterStack, "Custom/Gaussian Blur 5X5")]
    public class GaussianBlur5X5 : PostProcessEffectSettings
    {
        [Tooltip("The intensity of the blur")] [SerializeField] [Range(0, 1)] 
        public FloatParameter intensity = new FloatParameter(){ value = 1f };
    }
}