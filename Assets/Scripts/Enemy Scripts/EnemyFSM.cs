using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
using UnityEngine.Rendering;

public class EnemyFSM : MonoBehaviour
{
    [Header("Dependencies")]
    [SerializeField] EnemyStates currentState = EnemyStates.Normal;
    [SerializeField] FieldOfView fieldOfView;
    [SerializeField] NavMeshAgent agent;

    [Header("Settings")]
    [SerializeField] float turnSpeed = 5;
    [SerializeField] float interactRange = 2f;
    [SerializeField] float randomSearchRange = 5;
    [SerializeField] float chaseSpeed = 1;
    [SerializeField] float SearchSpeed = 0.7f;
    [Range(0.01f, 10)][SerializeField] float chaseTime = 1;
    [Range(2, 100)][SerializeField] float searchTime = 25;
    [Range(0.01f, 10)][SerializeField] float ponderTime = 3;

    private PatrolScript patrol;
    private GameObject objectOfIntrest;
    private AttackScript attackScript;
    private float currentChaseTime;
    private float currentSearchTime;
    private float currentPonderTime;
    private float minAttackRange;
    private float normalSpeed;
    private bool investigating;
    private bool searching;
    private bool inAnimation = false;

    private void Start()
    {
        try
        {
            patrol = this.GetComponentInChildren<PatrolScript>();
            agent = this.GetComponent<NavMeshAgent>();
            attackScript = this.GetComponent<AttackScript>();

            normalSpeed = agent.speed;

            if (attackScript.IsEnemyRanged())
            {
                minAttackRange = attackScript.RangedAttackRange();
            }
            else
            {
                minAttackRange = attackScript.MeleeAttackRange();
            }
        }
        catch (System.Exception)
        {

            throw;
        }
        currentChaseTime = 0;
        currentSearchTime = 0;
        currentPonderTime = 0;
        searching = false;
        investigating = false;
    }

    void FixedUpdate()
    {
        RemainingActionTime();
        ExecuteCurrentState();
    }

    private void SwitchState(EnemyStates newState)
    {
        currentState = newState;
    }

    private void ExecuteCurrentState()
    {
        switch (currentState)
        {
            case EnemyStates.Normal:
                Debug.Log("normal");
                NormalStage();
                break;

            case EnemyStates.Chase:
                Debug.Log("chase");
                if (patrol.enabled)
                {
                    patrol.enabled = false;
                }
                ChaseStage(objectOfIntrest);
                break;

            case EnemyStates.Attack:
                if (patrol.enabled)
                {
                    patrol.enabled = false;
                }
                AttackingStage(objectOfIntrest);
                break;

            case EnemyStates.Search:
                Debug.Log("search");
                if (patrol.enabled)
                {
                    patrol.enabled = false;
                }
                SearchingStage();
                break;

            case EnemyStates.Investigate:
                Debug.Log("Investigate");
                if (patrol.enabled)
                {
                    patrol.enabled = false;
                }
                InvastigateStage(objectOfIntrest);
                break;

            case EnemyStates.Ponder:
                Debug.Log("Ponder");
                if (patrol.enabled)
                {
                    patrol.enabled = false;
                }
                PonderStage(objectOfIntrest);
                break;

            default:

                break;
        }
    }

    private void AttackingStage(GameObject attackedPlayer)
    {
        TurnToIntrest(attackedPlayer);
        float distranceToPlayer = Vector3.Distance(this.transform.position, attackedPlayer.transform.position);
        if (distranceToPlayer <= minAttackRange && attackedPlayer.tag == "Player")
        {
            agent.destination = this.transform.position;
            //attacklogic
            Debug.Log("Attack the Player!");
            attackScript.CommenceAttack(distranceToPlayer,attackedPlayer);
        }
        else
        {
            SwitchState(EnemyStates.Chase);
        }
    }

    private void ChaseStage(GameObject chasedPlayer)
    {
        agent.speed = chaseSpeed;
        if (chasedPlayer.tag == "Player")
        {
            if (Vector3.Distance(this.transform.position, chasedPlayer.transform.position) <= minAttackRange)
            {
                SwitchState(EnemyStates.Attack);
            }
            else if (currentChaseTime > 0)
            {
                agent.destination = chasedPlayer.transform.position;
            }
            else
            {
                agent.destination = this.transform.position;
                currentSearchTime = searchTime;
                SwitchState(EnemyStates.Search);
            }
        }
        else
        {
            SwitchState(EnemyStates.Search);
        }
    }

    private void SearchingStage()
    {
        agent.speed = SearchSpeed;
        objectOfIntrest = null;
        if (currentSearchTime > 0 && !CheckIfStillMoving())
        {
            Vector3 randomPoint;
            if(RandomPoint(this.transform.position, randomSearchRange, out randomPoint))
            {
                agent.SetDestination(randomPoint);
            }
        }

        else if (currentSearchTime <= 0)
        {
            objectOfIntrest = null;
            SwitchState(EnemyStates.Normal);
        }
    }

    private void NormalStage()
    {
        agent.speed = normalSpeed;
        if (!patrol.enabled)
        {
            patrol.enabled = true;
            patrol.BackInAction();
        }
    }

    private void InvastigateStage(GameObject ivastigatedObject)
    {
        agent.speed = normalSpeed;
        float distranceToInvestegaredObject = Vector3.Distance(this.transform.position, ivastigatedObject.transform.position);
        if (distranceToInvestegaredObject <= interactRange)
        {
            currentPonderTime = ponderTime;
            SwitchState(EnemyStates.Ponder);
        }
        else
        {
            //investigating = true;
            agent.destination = ivastigatedObject.transform.position;
        }
    }

    private void PonderStage(GameObject ponderedObject)
    {
        TurnToIntrest(ponderedObject);
        fieldOfView.LookAtThing(ponderedObject.transform);
        if (currentPonderTime <= 0)
        {
            switch (ponderedObject.tag)
            {
                case "Body":
                    objectOfIntrest = ponderedObject;
                    RaiseAlarm();
                    currentSearchTime = searchTime;
                    SwitchState(EnemyStates.Search);
                    break;

                default:
                    if (currentSearchTime > 0)
                    {
                        SwitchState(EnemyStates.Search);
                    }
                    else
                    {
                        objectOfIntrest = null;
                        SwitchState(EnemyStates.Normal);
                    }
                    break;
            }
        }
    }

    private void OnAlert()
    {
        //activate alert animations
        fieldOfView.Alert(true);
    }

    private void RaiseAlarm()
    {
        fieldOfView.Alert(true);
    }

    private void TurnToIntrest(GameObject intrest)
    {
        // Determine which direction to rotate towards
        Vector3 targetDirection = intrest.transform.position - transform.position;

        // The step size is equal to speed times frame time.
        float singleStep = turnSpeed * Time.deltaTime;

        // Rotate the forward vector towards the target direction by one step
        Vector3 newDirection = Vector3.RotateTowards(transform.forward, targetDirection, singleStep, 0.0f);

        // Draw a ray pointing at our target in
        Debug.DrawRay(transform.position, newDirection, Color.red);

        // Calculate a rotation a step closer to the target and applies rotation to this object
        transform.rotation = Quaternion.LookRotation(newDirection);
    }

    private void RemainingActionTime()
    {
        if (currentChaseTime > 0)
        {
            currentChaseTime = currentChaseTime - Time.deltaTime;
        }
        if (currentSearchTime > 0)
        {
            currentSearchTime = currentSearchTime - Time.deltaTime;
        }
        if (currentPonderTime > 0)
        {
            currentPonderTime = currentPonderTime - Time.deltaTime;
        }
    }

    private bool CheckIfStillMoving()
    {
        if (!agent.pathPending)
        {
            if (agent.remainingDistance <= agent.stoppingDistance)
            {
                if (!agent.hasPath || agent.velocity.sqrMagnitude == 0f)
                {
                    return false;
                }
            }
        }

        return true;
    }

    private bool RandomPoint(Vector3 center, float range, out Vector3 result)
    {
        Vector3 randomPoint = center + Random.insideUnitSphere * range;
        NavMeshHit hit;
        if(NavMesh.SamplePosition(randomPoint, out hit, 1.0f, NavMesh.AllAreas))
        {
            result = hit.position;
            return true;
        }

        result = Vector3.zero;
        return false;
    }

    public void Distracted(GameObject distractingObject)
    {
        currentPonderTime = ponderTime; //mark to add more
        objectOfIntrest = distractingObject;
        SwitchState(EnemyStates.Ponder);
    }

    public EnemyStates GetEnemyStates()
    {
        return currentState;
    }

    public void Reaction(GameObject seenObject)
    {
        if (currentState == EnemyStates.Normal || currentState == EnemyStates.Search || currentState == EnemyStates.Ponder)
        {
            objectOfIntrest = seenObject;

            switch (seenObject.tag)
            {
                case "Player":
                    currentChaseTime = chaseTime;
                    SwitchState(EnemyStates.Chase);
                    RaiseAlarm();
                    break;

                case "Body":
                    SwitchState(EnemyStates.Investigate);
                    OnAlert();
                    break;

                case "SeenAlready":

                    break;

                default:
                    SwitchState(EnemyStates.Investigate);
                    break;
            }
        }

        else//See something but are not in a normal state
        {
            switch (currentState)
            {
                case EnemyStates.Chase:
                case EnemyStates.Attack:
                    if (seenObject.tag == "Player" && Vector3.Distance(this.transform.position, seenObject.transform.position) >
                        Vector3.Distance(this.transform.position, objectOfIntrest.transform.position))
                    {
                        currentChaseTime = chaseTime;
                        objectOfIntrest = seenObject;
                    }
                    else
                    {
                        currentChaseTime = chaseTime;
                    }
                    break;

                case EnemyStates.Investigate:
                    if ((seenObject.tag == "Body" && objectOfIntrest.tag != "Body" )||(seenObject.tag == "Body" && objectOfIntrest.tag == "Body" &&
                        Vector3.Distance(this.transform.position, seenObject.transform.position) >
                        Vector3.Distance(this.transform.position, objectOfIntrest.transform.position)))
                    {
                        objectOfIntrest = seenObject;
                        OnAlert();
                    }
                    if (seenObject.tag != "Body" && objectOfIntrest.tag != "Body" &&
                        Vector3.Distance(this.transform.position, seenObject.transform.position) >
                        Vector3.Distance(this.transform.position, objectOfIntrest.transform.position))
                    {
                        objectOfIntrest = seenObject;
                    }
                    break;

                default:

                    break;
            }
        }
    }
}


public enum EnemyStates { Normal, Chase, Attack, Search, Investigate, Ponder}
