using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DistanceOclussion : MonoBehaviour
{
    void Update()
    {
		Shader.SetGlobalVector("_TargetGlobalPosition", transform.position);
    }
}