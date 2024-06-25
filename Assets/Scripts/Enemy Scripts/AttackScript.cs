using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
using UnityEngine.Animations.Rigging;

public class AttackScript : MonoBehaviour
{
    [SerializeField] bool rangedEnemy = true;
    [SerializeField] float meleeAttackRange = 1.5f;
    [SerializeField] float rangedAttackRange = 8f;
    [SerializeField] float attackCooldown = 3f;

    private float currentAttackCooldown;
    private Animator animator;
    private GameObject currentPlayer;

    // Start is called before the first frame update
    void Start()
    {
        currentAttackCooldown = 0;
        try
        {
            animator = this.GetComponentInChildren<Animator>();
        }
        catch (System.Exception)
        {

            throw;
        }
    }
    // Timer Update
    void Update()
    {
        if(currentAttackCooldown > 0)
        {
            currentAttackCooldown -= Time.deltaTime;
        }
    }

    public bool IsEnemyRanged()
    {
        return rangedEnemy;
    }
    
    public float RangedAttackRange()
    {
        return rangedAttackRange;
    }

    public float MeleeAttackRange()
    {
        return meleeAttackRange;
    }

    public void CommenceAttack(float range, GameObject player)
    {
        currentPlayer = player;
        if (currentAttackCooldown <= 0)
        {
            if (rangedEnemy && (meleeAttackRange < range && range <= rangedAttackRange))
            {
                RangedAttack();
            }
            else if (range <= meleeAttackRange)
            {
                MeleeAttack();
            }

            currentAttackCooldown = attackCooldown;
        }
    }

    //This is an animation event
    public void AttackAnimationDamageEvent()
    {
        try
        {
            currentPlayer.GetComponent<PCStats>().TakeDamage();
        }
        catch (System.Exception)
        {

            throw;
        }
    }


    //work in progress
    private void RangedAttack()
    {
        //do Ranged Attack
        Debug.Log("Attack the Player!");
    }

    private void MeleeAttack()
    {
        //do Melee Attack
        Debug.Log("Attack the Player!");
        animator.SetTrigger("MeleeAttack");
    }

}
