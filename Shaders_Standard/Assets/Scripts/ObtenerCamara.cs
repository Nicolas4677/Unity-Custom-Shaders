using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class ObtenerCamara : MonoBehaviour {

    public Shader shader;

    [Range (0,1)]
    public float factor;
    private Material materialActual;

    Material material {
        get {
            if (materialActual == null) {
                Debug.Log("Creando material");
                materialActual = new Material(shader);
                materialActual.hideFlags = HideFlags.HideAndDontSave;
            }
            return materialActual;
        }
    }

    void Start () {
        if (!SystemInfo.supportsImageEffects) {
            enabled = false;
            return;
        }

        if (!shader || !shader.isSupported) {
            enabled = false;
        }

    }

    void OnRenderImage(RenderTexture entrada, RenderTexture salida) {
        material.SetFloat("_Factor", factor);
        Graphics.Blit(entrada, salida, material);
    }

    void Update () {}

    void OnDisable() {
        if (materialActual) {
            DestroyImmediate(materialActual);
        }
    }
}

