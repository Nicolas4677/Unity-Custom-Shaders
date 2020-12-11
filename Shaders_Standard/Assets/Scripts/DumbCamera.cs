using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DumbCamera : MonoBehaviour
{
    [SerializeField] private Shader shader;
    [Range(0,1)]
    [SerializeField] private float effectValue;
    
    private Material currentMaterial;
    private Material CurrentMaterial
    {
        get
        {
            if (currentMaterial != null) return currentMaterial;
            currentMaterial = new Material(shader) {hideFlags = HideFlags.HideAndDontSave};
            return currentMaterial;
        }
    }
    private void Start()
    {
        if (!SystemInfo.supportsImageEffects)
        {
            enabled = false;
            return;
        }
        if(!shader || !shader.isSupported)
        {
            enabled = false;
        }
    }
    private void OnRenderImage(RenderTexture input, RenderTexture output)
    {
        CurrentMaterial.SetFloat($"_EffectValue", effectValue);
        Graphics.Blit(input, output, CurrentMaterial);
    }
    private void OnDisable()
    {
        if (currentMaterial)
        {
            DestroyImmediate(currentMaterial);
        }
    }
}
