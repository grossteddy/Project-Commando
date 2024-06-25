using System.Collections;
using System.Collections.Generic;
using System.Threading;
using UnityEngine;
using UnityEngine.AI;

public class GuardScript : ActionScript
{
    [SerializeField] GameObject gaurdPoint;
    [Range(0.001f, 5f)][SerializeField] float rotationSpeed = 3f;
    private NavMeshAgent navMeshAgent;
    private bool shouldTurn;
    private float timeCount = 0;
    private Quaternion currentRotation;

    // Start is called before the first frame update
    void Start()
    {
        shouldTurn = false;
        navMeshAgent = GetComponent<NavMeshAgent>();
        this.BackInAction();
        timeCount = 0;
    }

    // Update is called once per frame
    void Update()
    {
        TurnToDirection();

        if (!navMeshAgent.pathPending && !inAction)
        {
            if (navMeshAgent.remainingDistance <= navMeshAgent.stoppingDistance)
            {
                if (!navMeshAgent.hasPath || navMeshAgent.velocity.sqrMagnitude == 0f)
                {
                    currentRotation = this.transform.rotation;
                    shouldTurn = true;
                    inAction = true;
                }
            }
        }
    }

    private void TurnToDirection()
    {
        if (shouldTurn)
        {
            this.transform.rotation = Quaternion.Slerp(currentRotation,
               gaurdPoint.transform.rotation, timeCount);

            timeCount = timeCount + Time.deltaTime * rotationSpeed;

            if (timeCount >= 1f)
            {
                timeCount = 0.0f;
                shouldTurn = false;
            }
        }     
    }

    public override void BackInAction()
    {
        navMeshAgent.destination = gaurdPoint.transform.position;
    }
}
