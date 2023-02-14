using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LutGrading : MonoBehaviour
{
    private int x = 0;
    //public Shader awesomeShader = null;
    public Material[] m_renderMaterial;

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.Q))
        {
            //when key is down the mat that is in the array 1 will show 
            x = 1;
        }

        if (Input.GetKeyUp(KeyCode.Q))
        {
            x = 0;
        }
    }
    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {

        Graphics.Blit(source, destination, m_renderMaterial[x]);//0 or 1 mat shows changing the lut and overrall color of the sence 


    }
}
