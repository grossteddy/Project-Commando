using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Unity.VisualScripting;
using UnityEngine;

public class FieldOfView : MonoBehaviour
{
    [SerializeField] float standShortRadius = 5;
    [SerializeField] float crouchFarRadius = 10;
    [Range(0, 360)][SerializeField] float viewAngle = 60;

    [SerializeField] LayerMask standShortMask;
    [SerializeField] LayerMask standShortObstructionMask;
    [SerializeField] LayerMask crouchFarMask;
    [SerializeField] LayerMask crouchFarObstructionMask;

    [SerializeField] EnemyFSM fsm;
    [SerializeField] Transform headTarget;
    [Range(0.01f, 1)][SerializeField] float rotSpeed = 0.01f;
    [Range(0.01f, 10)][SerializeField] float reactionSpeed = 0.01f;
    [SerializeField] bool headRotatingEnemy = true;
    private bool rotateHead;

    private bool canSeeSomething;
    private float headRotLerpNum = 0.5f;
    private Vector3 oldHeadTargetPos;

    private float reactionLerpNum;
    private bool onAlert;

    private Transform headTargetParent;

    private void Start()
    {
        headTargetParent = headTarget.parent;
        canSeeSomething = false;
        onAlert = false;
        reactionLerpNum = 0;
        oldHeadTargetPos = headTarget.localPosition;
        if (headRotatingEnemy)
        {
            rotateHead = true;
        }
        else
        {
            rotateHead = false;
        }
    }

    private void Update()
    {
        FieldOfViewCheck();
        if (!canSeeSomething)
        {
            ReturnToNormalView();
        }
        if (rotateHead)
        {
            RotateHead();
        }
    }

    private void FieldOfViewCheck()
    {
        //high vision check
        //Collider[] highRangeChecks = Physics.OverlapSphere(transform.position, standShortRadius, standShortMask);
        //SightCheck(highRangeChecks, standShortMask, standShortObstructionMask);

        //low vision check
        Collider[] lowRangeChecks = Physics.OverlapSphere(transform.position, crouchFarRadius, crouchFarMask);
        SightCheck(lowRangeChecks, crouchFarMask, crouchFarObstructionMask);

        if (/*canSeeSomething && highRangeChecks.Length <= 0 &&*/ lowRangeChecks.Length <= 0)
        {
            canSeeSomething = false;
        }
    }

    private void SightCheck(Collider[] RangeChecks, LayerMask seeMask, LayerMask obstructionMask)
    {
        if (RangeChecks.Length > 0)
        {
            for (int i = 0; i < RangeChecks.Length; i++)
            {
                Transform target = RangeChecks[i].transform.Find("Skeleton/Hips/Spine/Chest");
                if (target == null)
                {
                    target = RangeChecks[i].transform;
                }
                Vector3 directionToTarget = (target.position - transform.position).normalized;

                if (Vector3.Angle(transform.forward, directionToTarget) < viewAngle / 2)
                {
                    float distanceToTarget = Vector3.Distance(transform.position, target.position);

                    if (!Physics.Raycast(transform.position, directionToTarget, distanceToTarget, obstructionMask))
                    {
                        SeeSomething(target, seeMask);
                    }
                }
                else
                {

                    if (canSeeSomething)
                    {
                        canSeeSomething = false;
                    }
                }
            }
        }
    }


    private void RotateHead()
    {
        if (rotateHead)
        {
            headRotLerpNum = Mathf.PingPong(Time.time * rotSpeed, 1);
            float tempAngle = Mathf.Lerp(viewAngle * (-1), viewAngle, headRotLerpNum);
            headTarget.localPosition = new Vector3(Mathf.Sin(tempAngle), headTarget.localPosition.y, headTarget.localPosition.z);
        }
    }

    private void SeeSomething(Transform seen, LayerMask seeMask)
    {
        //Debug.Log("Can See Something");
        if (!canSeeSomething)
        {
            canSeeSomething = true;
            LookAtThing(seen);
        }
        int alertMulty = 1;
        if (onAlert)
        {
            alertMulty = 2;
        }
        if (reactionLerpNum < 1)
        {
            reactionLerpNum = reactionLerpNum + Time.deltaTime * reactionSpeed * alertMulty;
        }

        Vector3 directionToTarget = (seen.position - transform.position).normalized;
        float rayLength = Mathf.Lerp(0, crouchFarRadius, reactionLerpNum);

        //something bad here
        Debug.DrawRay(transform.position, directionToTarget * rayLength, Color.green);
        if (Physics.Raycast(transform.position, directionToTarget, rayLength, seeMask))
        {
            //check
            Debug.Log("Please");
            GameObject possiblePC = FindParentWithTag(seen.gameObject, "Player");
            if (possiblePC != null)
            {
                //check
                Debug.Log("Regognize Player");
                reactionLerpNum = 1;
                fsm.Reaction(possiblePC);

                LookAtThing(seen);
            }
            else
            {
                //check
                Debug.Log("Not Player");
                fsm.Reaction(seen.gameObject);
            }
        }
    }

    private void ReturnToNormalView()
    {
        if (reactionLerpNum > 0 && (fsm.GetEnemyStates() == EnemyStates.Normal || fsm.GetEnemyStates() == EnemyStates.Search))
        {
            reactionLerpNum = reactionLerpNum - Time.deltaTime * reactionSpeed;
        }
        if (headTarget.localPosition != oldHeadTargetPos && !rotateHead)
        {
            //headTarget.parent = headTargetParent;
            headTarget.localPosition = oldHeadTargetPos;
        }

        if (headRotatingEnemy && !rotateHead)
        {
            //headTarget.parent = headTargetParent;
            rotateHead = true;
        }

    }

    private static GameObject FindParentWithTag(GameObject childObject, string tag)
    {
        Transform t = childObject.transform;
        while (t.parent != null)
        {
            if (t.parent.tag == tag)
            {
                return t.parent.gameObject;
            }
            t = t.parent.transform;
        }
        return null; // Could not find a parent with given tag.
    }

    public void Alert(bool alertMod)
    {
        onAlert = alertMod;
    }

    public void LookAtThing(Transform thing)
    {
        headTarget.position = new Vector3(thing.position.x, headTarget.position.y, thing.position.z);
        //headTarget.parent = null;
        //headTarget.position = thing.position;
        if (rotateHead)
        {
            rotateHead = false;
        }
    }

    public void MakeHeadRotate(bool head)
    {
        rotateHead = head;
    }

    public float GetRadius()
    {
        return crouchFarRadius;
    }

    public float GetAngle()
    {
        return viewAngle;
    }


}
