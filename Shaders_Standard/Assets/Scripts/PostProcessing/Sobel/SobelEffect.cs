using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[System.Serializable]
[PostProcess(typeof(SobelRenderer), PostProcessEvent.AfterStack, "Custom/SobelEffect")]
public class SobelEffect : PostProcessEffectSettings
{
    [Tooltip("The intensity of the effect")] [Range(0f, 1f)]
    public FloatParameter intensity = new FloatParameter() { value = 1f };
}
