using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class PlayerAttackScript : MonoBehaviour
{
    [SerializeField] float attackRange = 1.5f;

    
    [SerializeField] Transform[] attackLocation;

    [SerializeField] float hitForceArea = 100f;
    [SerializeField] float hitForce = 50f;

    private Animator animator;
    private NavMeshAgent navMeshAgent;
    private GameObject target;
    private bool attackingTarget = false;
    private bool midAttack = false;
    private string[] attacks = { "LeftPunch", "RightPunch", "Kick" };
    private int currentAttack;

    // Start is called before the first frame update
    void Start()
    {
        currentAttack = 0;
        animator = GetComponent<Animator>();
        navMeshAgent = GetComponent<NavMeshAgent>();
        attackingTarget = false;
        midAttack = false;
    }

    // Update is called once per frame
    void Update()
    {
        AttackTarget();
    }

    public void MoveToTarget(GameObject selectedTarget)
    {
        attackingTarget = true;
        target = selectedTarget;
    }

    public void NoTarget()
    {
        attackingTarget = false;
        target = null;
    }

    private void AttackTarget()
    {
        if (target != null && attackingTarget && !midAttack)
        {
            if (Vector3.Distance(this.transform.position, target.transform.position) <= attackRange)
            {
                //playerMoveAnimation.enabled = false;
                navMeshAgent.SetDestination(this.transform.position);
                this.transform.LookAt(target.transform.position);
                //animation stuff
                animator.SetBool(attacks[currentAttack], true);
                midAttack = true;

            }
            else
            {
                navMeshAgent.SetDestination(target.transform.position);
            }
        }
    }

    public void KillTarget()
    {
        animator.SetBool(attacks[currentAttack], false);

        target.GetComponent<EnemyDeathScript>().Death();

        Collider[] colliders = Physics.OverlapSphere(attackLocation[currentAttack].transform.position, hitForceArea);
        foreach(Collider closeObject in colliders)
        {
            Rigidbody rigidbody = closeObject.GetComponent<Rigidbody>();

            if(rigidbody != null)
            {
                rigidbody.AddExplosionForce(hitForce, attackLocation[currentAttack].transform.position, hitForceArea);
            }
        }

        if (currentAttack < attacks.Length - 1)
        {
            currentAttack++;
        }
        else
        {
            currentAttack = 0;
        }

    }

    public void NotMidAttack()
    {
        midAttack = false;
        //playerMoveAnimation.enabled = true;
       
    }
}
