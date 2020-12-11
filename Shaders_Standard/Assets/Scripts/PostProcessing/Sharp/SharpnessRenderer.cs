using  UnityEngine;
using UnityEngine.Rendering.PostProcessing;

namespace PostProcessing.Sharp
{
    public sealed class SharpnessRenderer : PostProcessEffectRenderer<Sharpness>
    {
        private readonly int _blend = Shader.PropertyToID("_Blend");
        public override void Render(PostProcessRenderContext context)
        {
            PropertySheet sheet = context.propertySheets.Get(Shader.Find("PostProcess/Kernel7"));
            sheet.properties.SetFloat(_blend, settings.intensity);
            context.command.BlitFullscreenTriangle(context.source, context.destination, sheet, 0);
        }
    }
}