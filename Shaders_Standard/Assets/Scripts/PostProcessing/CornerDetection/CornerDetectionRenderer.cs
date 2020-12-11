using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

namespace PostProcessing.CornerDetection
{
    public class CornerDetectionRenderer : PostProcessEffectRenderer<CornerDetection>
    {
        private readonly int _blend = Shader.PropertyToID("_Blend");
        public override void Render(PostProcessRenderContext context)
        {
            PropertySheet sheet = context.propertySheets.Get(Shader.Find("PostProcess/Kernel4"));
            sheet.properties.SetFloat(_blend, settings.intensity);
            context.command.BlitFullscreenTriangle(context.source, context.destination, sheet, 0);
        }
    }
}
