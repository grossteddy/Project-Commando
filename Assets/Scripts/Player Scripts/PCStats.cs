using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class PCStats : MonoBehaviour
{
    [SerializeField] int Hp = 3;
    private int currentHP;
    private Animator animator;
    private NavMeshAgent agent;
    private PauseMenuScript menuScript;

    // Start is called before the first frame update
    void Start()
    {
        currentHP = Hp;

        try
        {
            animator = GetComponent<Animator>();
            agent = GetComponent<NavMeshAgent>();
            menuScript = GameObject.Find("Canvas").GetComponent<PauseMenuScript>();
        }
        catch (System.Exception)
        {

            throw;
        }
    }

    public void TakeDamage()
    {
        --currentHP;

        if (currentHP <= 0)
        {
            Death();
        }
    }

    private void Death()
    {
        Debug.Log("Player Character dead");
        //gameObject.layer = LayerMask.NameToLayer("Ignore Raycast");
        gameObject.tag = "Untagged";
        GetComponent<PlayerAnimationScript>().enabled = false;
        GetComponent<Collider>().isTrigger = true;
        GetComponent<Rigidbody>().isKinematic = true;
        agent.enabled = false;
        animator.SetTrigger("DeathTrigger");
    }

    //Triggered only by animation event
    public void CallGameOverAnimationEvent()
    {
        menuScript.MissonFailed();
    }
}
