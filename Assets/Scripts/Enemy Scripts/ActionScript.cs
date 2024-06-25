using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class ActionScript : MonoBehaviour
{
    protected bool inAction;

    public void NotInAction()
    {
        inAction = false;
    }

    public abstract void BackInAction();
}
