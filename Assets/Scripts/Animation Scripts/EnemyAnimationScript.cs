using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
using UnityStandardAssets.Characters.ThirdPerson;

public class EnemyAnimationScript : CharacterAnimationScript
{
    private bool patrolTrun = false;

    void Update()
    {
         AnimationMovment();
    }

    private void AnimationMovment()
    {

        if (m_Agent.remainingDistance > m_Agent.stoppingDistance)
        {
            Move(m_Agent.desiredVelocity, false, false);
        }
        else
        {
            Move(Vector3.zero, false, false);
        }

    }

    /*public void SwitchTurn()
    {
        if (!patrolTrun)
        {
            patrolTrun = true;
        }
        else
        {
            patrolTrun = false;
        }
    }*/

}

