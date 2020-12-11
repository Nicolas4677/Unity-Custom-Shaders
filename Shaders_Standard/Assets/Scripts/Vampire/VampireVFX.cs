using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VampireVFX : MonoBehaviour
{
    [SerializeField] private ParticleSystem particleSystem;
    [SerializeField] private Animator animator;
    [SerializeField] private float percentToChange, duration;
    [SerializeField] private string animationName;

    private float timer = 0f;

    private void Awake()
    {
        if (particleSystem == null) particleSystem = GetComponentInChildren<ParticleSystem>();
        if (animator == null) animator = GetComponent<Animator>();
    }

    private void Update()
    {
        if (animator != null && animator.GetCurrentAnimatorStateInfo(0).IsName(animationName))
        {
            if(!particleSystem.isPlaying) particleSystem.Play();
            timer += Time.deltaTime;

            var value = timer/duration;
            if (timer > duration)
            {
                particleSystem.Stop();
                timer = 0f;
            }

            if (value >= percentToChange)
            {
                
            }
            else
            {
                
            }
            return;
        }
        particleSystem.Stop();
        timer = 0f;
    }
}