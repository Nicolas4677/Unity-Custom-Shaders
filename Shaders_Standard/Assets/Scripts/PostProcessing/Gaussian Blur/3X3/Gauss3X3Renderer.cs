using  UnityEngine;
using UnityEngine.Rendering.PostProcessing;

namespace PostProcessing.Gaussian_Blur._3X3
{
    public sealed class Gauss3X3Renderer : PostProcessEffectRenderer<GaussianBlur3X3>
    {
        private readonly int _blend = Shader.PropertyToID("_Blend");

        public override void Render(PostProcessRenderContext context)
        {
            PropertySheet sheet = context.propertySheets.Get(Shader.Find("PostProcess/Kernel2"));
            sheet.properties.SetFloat(_blend, settings.intensity);
            context.command.BlitFullscreenTriangle(context.source, context.destination, sheet, 0);
        }
    }
}
