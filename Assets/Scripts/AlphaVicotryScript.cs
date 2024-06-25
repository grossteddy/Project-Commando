using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class AlphaVicotryScript : MonoBehaviour
{
    private PauseMenuScript menuScript;
    
    // Start is called before the first frame update
    void Start()
    {
        try
        {
            menuScript = GameObject.Find("Canvas").GetComponent<PauseMenuScript>();
        }
        catch (System.Exception)
        {
            throw;
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if(other.tag == "Player")
        {
            menuScript.MissionWon();
        }
    }
}
