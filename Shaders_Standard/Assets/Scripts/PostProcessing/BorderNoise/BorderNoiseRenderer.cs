using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

namespace PostProcessing.BorderNoise
{
    public class BorderNoiseRenderer : PostProcessEffectRenderer<BorderNoise>
    {
        private readonly int _blend = Shader.PropertyToID("_Blend");
        private readonly int _borderNoise = Shader.PropertyToID("_BorderValue");
        public override void Render(PostProcessRenderContext context)
        {
            PropertySheet sheet = context.propertySheets.Get(Shader.Find("PostProcess/Kernel8"));
            sheet.properties.SetFloat(_blend, settings.intensity);
            sheet.properties.SetFloat(_borderNoise, settings.borderNoise);
            context.command.BlitFullscreenTriangle(context.source, context.destination, sheet, 0);
        }
    }
}