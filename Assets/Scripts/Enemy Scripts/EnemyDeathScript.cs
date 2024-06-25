using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
using UnityEngine.Animations.Rigging;

public class EnemyDeathScript : MonoBehaviour
{
    private MonoBehaviour[] comps;

    private GameObject fieldOfView;
    private List<Collider> ragdollParts = new List<Collider>();
    private List<Rigidbody> ragdollRigid = new List<Rigidbody>();
    private GameObject patrolActions;

    // Start is called before the first frame update
    void Start()
    {
        patrolActions = this.transform.parent.Find("EnemyActionPoints").gameObject;
        fieldOfView = this.GetComponentInChildren<FieldOfView>().gameObject;
        comps = GetComponents<MonoBehaviour>();
        SetRagdollParts();
    }

    public void Death()
    {
        patrolActions.SetActive(false);
        this.GetComponent<Collider>().enabled = false;
        this.GetComponent<NavMeshAgent>().enabled = false;
        this.GetComponent<Animator>().enabled = false;

        TurnOffSight();
        TurnOnRagdoll();
        foreach (MonoBehaviour c in comps)
        {
            if (c is Component EnemyDeathScript)
            {
                c.enabled = false;
            }
        }

    }

    private void SetRagdollParts()
    {
        Collider[] colliders = this.gameObject.GetComponentsInChildren<Collider>();

        foreach (Collider collider in colliders)
        {
            if (collider.gameObject != this.gameObject)
            {
                collider.isTrigger = true;
                ragdollParts.Add(collider);

                Rigidbody rigidbody = collider.gameObject.GetComponent<Rigidbody>();
                if (rigidbody != null)
                {
                    rigidbody.isKinematic = true;
                    ragdollRigid.Add(rigidbody);
                }
            }
        }
    }

    private void TurnOnRagdoll()
    {

        this.GetComponent<Rigidbody>().useGravity = false;
        this.GetComponent<Rigidbody>().isKinematic = true;

        foreach (Collider collider in ragdollParts)
        {
            collider.enabled = true;
            collider.isTrigger = false;
            collider.attachedRigidbody.velocity = Vector3.zero;
        }

        foreach (Rigidbody rigid in ragdollRigid)
        {
            rigid.isKinematic = false;
            rigid.useGravity = true;
        }
    }

    private void TurnOffSight()
    {
        fieldOfView.SetActive(false);
    }
}
