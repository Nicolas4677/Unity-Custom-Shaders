using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

namespace PostProcessing.Average
{
    [Serializable] 
    [PostProcess(typeof(AverageRenderer), PostProcessEvent.AfterStack, "Custom/AverageEffect")]
    public sealed class AverageEffect : PostProcessEffectSettings
    {
        [Tooltip("The average effect intensity")] [SerializeField] [Range(0f, 1f)]
        public FloatParameter intensity = new FloatParameter() { value = 0f };
    }
}