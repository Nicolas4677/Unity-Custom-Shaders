using  UnityEngine;
using UnityEngine.Rendering.PostProcessing;

namespace PostProcessing.Gaussian_Blur._5X5
{
    public sealed class Gauss5X5Renderer : PostProcessEffectRenderer<GaussianBlur5X5>
    {
        private readonly int _blend = Shader.PropertyToID("_Blend");
        public override void Render(PostProcessRenderContext context)
        {
            PropertySheet sheet = context.propertySheets.Get(Shader.Find("PostProcess/Kernel3"));
            sheet.properties.SetFloat(_blend, settings.intensity);
            context.command.BlitFullscreenTriangle(context.source, context.destination, sheet, 0);
        }
    }
}
