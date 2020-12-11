using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

namespace PostProcessing.Border_Detection.Complex
{
    public sealed class ComplexBorderDetectionRenderer : PostProcessEffectRenderer<ComplexBorderDetection>
    {
        private readonly int _blend = Shader.PropertyToID("_Blend");
        public override void Render(PostProcessRenderContext context)
        {
            PropertySheet sheet = context.propertySheets.Get(Shader.Find("PostProcess/Kernel6"));
            sheet.properties.SetFloat(_blend, settings.intensity);
            context.command.BlitFullscreenTriangle(context.source, context.destination, sheet, 0);
        }
    }
}