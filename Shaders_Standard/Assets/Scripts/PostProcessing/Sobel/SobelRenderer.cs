using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

public class SobelRenderer : PostProcessEffectRenderer<SobelEffect>
{
    private readonly int _blend = Shader.PropertyToID("_Blend");

    public override void Render(PostProcessRenderContext context)
    {
        PropertySheet sheet = context.propertySheets.Get(Shader.Find("PostProcess/Kernel9"));
        sheet.properties.SetFloat(_blend, settings.intensity);
        context.command.BlitFullscreenTriangle(context.source, context.destination, sheet, 0);
    }
}
