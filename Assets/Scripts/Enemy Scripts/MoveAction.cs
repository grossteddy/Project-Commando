using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.AI;

public class MoveAction : MonoBehaviour, IEnemyAction
{
    private PatrolScript patrolScript;
    private NavMeshAgent navAgent;

    void Update()
    {
        if (patrolScript != null && navAgent != null && !navAgent.pathPending)
        {
            if (navAgent.remainingDistance <= navAgent.stoppingDistance)
            {
                if (!navAgent.hasPath || navAgent.velocity.sqrMagnitude == 0f)
                {
                    patrolScript.NotInAction();
                    navAgent = null;
                    patrolScript = null;
                    this.gameObject.SetActive(false);
                }
            }
        }
    }

    public void DoEnemyAction(GameObject actor)
    {
        navAgent = actor.GetComponent<NavMeshAgent>();
        patrolScript = actor.GetComponent<PatrolScript>();
        navAgent = actor.GetComponent<NavMeshAgent>();

        if (patrolScript != null)
        {
            navAgent.destination = this.transform.position;
        }
    }
}
