using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
using UnityStandardAssets.Characters.ThirdPerson;

public class PlayerAnimationScript : CharacterAnimationScript
{
    void Update()
    {
        if(m_Agent.remainingDistance > m_Agent.stoppingDistance)
        {
            Move(m_Agent.desiredVelocity, false, false);
        }
        else
        {
            Move(Vector3.zero, false, false);
        }
    }
}
