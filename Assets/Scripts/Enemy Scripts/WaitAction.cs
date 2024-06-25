using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WaitAction : MonoBehaviour, IEnemyAction
{
    [SerializeField] float time = 3;
    private float waitTime = 0;

    private PatrolScript patrolScript;

    void Update()
    {
        waitTime -= Time.deltaTime;
        if (patrolScript != null && waitTime <= 0)
        {
            patrolScript.NotInAction();
            patrolScript = null;
            this.gameObject.SetActive(false);
        }
    }

    public void DoEnemyAction(GameObject actor)
    {
        patrolScript = actor.GetComponent<PatrolScript>();
        if(patrolScript != null)
        {
            waitTime = time;
        }
    }
}
