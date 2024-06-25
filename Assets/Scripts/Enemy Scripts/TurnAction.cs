using System.Collections;
using System.Collections.Generic;
using System.Threading;
using UnityEngine;

public class TurnAction : MonoBehaviour, IEnemyAction
{
    [Range(0.001f, 1f)][SerializeField] float rotationSpeed = 0.1f;

    private PatrolScript patrolScript;
    //private EnemyAnimationScript enemyAnimationScript;
    private Transform characterRotation;
    private Transform directedRotation;
    private float timeCount = 0.0f;

    void Update()
    {
        if (patrolScript != null)
        {
            patrolScript.transform.rotation = Quaternion.Slerp(characterRotation.rotation,
                directedRotation.rotation, timeCount);

            timeCount = timeCount + Time.deltaTime * rotationSpeed;

            if (timeCount >= 0.1f)
            {
                patrolScript.NotInAction();
                //enemyAnimationScript.SwitchTurn();

                characterRotation = null;
                directedRotation = null;
                patrolScript = null;
                //enemyAnimationScript = null;
                timeCount = 0.0f;
                this.gameObject.SetActive(false);
            }
        }
    }

    public void DoEnemyAction(GameObject actor)
    {
        patrolScript = actor.GetComponent<PatrolScript>();
        //enemyAnimationScript = actor.GetComponent<EnemyAnimationScript>();
        //enemyAnimationScript.SwitchTurn();
        characterRotation = actor.transform;
        directedRotation = this.transform;
    }
}
