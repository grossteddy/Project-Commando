using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.AI;
using UnityEngine.Assertions;
using UnityEngine.InputSystem;

public class PatrolScript : MonoBehaviour, IOrder
{
    [SerializeField] List<GameObject> patrolActions;

    private IEnemyAction currentAction;
    private int currentActionIndex;
    private bool inAction;

    void Start()
    {
        Assert.IsTrue(patrolActions.Count > 1, "The enemy doesn't have enough actions");
        Assert.IsTrue(patrolActions[0].GetComponent<IEnemyAction>() != null, "First Action object dosen't have an Action script");


        if (!patrolActions[0].active)
        {
            patrolActions[0].SetActive(true);
        }
        currentAction = patrolActions[0].GetComponent<IEnemyAction>();
        currentActionIndex = 0;
        inAction = true;
        currentAction.DoEnemyAction(this.gameObject);
    }

    void Update()
    {
        if (!inAction)
        {
            NextAction();
        }
    }

    private void NextAction()
    {
        ++currentActionIndex;
        if (currentActionIndex >= patrolActions.Count)
        {
            currentActionIndex = 0;
        }
        if (!patrolActions[currentActionIndex].active)
        {
            patrolActions[currentActionIndex].SetActive(true);
        }
        currentAction = patrolActions[currentActionIndex].GetComponent<IEnemyAction>();
        inAction = true;
        currentAction.DoEnemyAction(this.gameObject);
    }

    public void NotInAction()
    {
        inAction = false;
    }

    public void BackInAction()
    {
        GameObject closestAction = patrolActions[0];
        int actionNum = 0;
        float shortest = 0;
        for(int i = 0; i < patrolActions.Count; i++)
        {
            if (patrolActions[i].tag == "Move")
            {
                float num = Vector3.Distance(this.transform.position, patrolActions[i].transform.position);
                if(num > shortest)
                {
                    actionNum = i;
                    shortest = num;
                    closestAction = patrolActions[i];
                }
            }
        }
        currentActionIndex = actionNum;
        closestAction.GetComponent<IEnemyAction>().DoEnemyAction(this.gameObject);
    }

}
