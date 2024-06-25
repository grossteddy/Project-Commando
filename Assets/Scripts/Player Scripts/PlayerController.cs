using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.AI;

public class PlayerController : MonoBehaviour
{
    [SerializeField] NavMeshAgent[] playerCharacter;
    private Camera cam;
    private int selectedPlayer = -1;
    private PlayerAttackScript playerAttackScript;

    // Start is called before the first frame update
    void Start()
    {
        cam = Camera.main;
        selectedPlayer = 0;
        SelectCharacter();
    }

    // Update is called once per frame
    void Update()
    {
        SelectCharacter();
        OnLeftMouseClick();
    }

    private void SelectCharacter()
    {
        for (int i = 0; i < playerCharacter.Length; i++)
        {
            if (Input.GetKeyDown((i + 1).ToString()) && selectedPlayer != i)
            {
                selectedPlayer = i;
            }
        }
    }

    private void OnLeftMouseClick()
    {
        if (Input.GetMouseButtonDown(0))
        {
            Ray ray = cam.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;

            if(selectedPlayer >= 0)
            {
                playerAttackScript = playerCharacter[selectedPlayer].gameObject.GetComponent<PlayerAttackScript>();
            }

            if (Physics.Raycast(ray, out hit) && selectedPlayer != -1)
            {
                if (hit.transform.tag == "Enemy")
                {
                    playerAttackScript.MoveToTarget(hit.collider.gameObject);
                    Debug.Log("going to attack enemy");
                }
                else
                {
                    playerAttackScript.NoTarget();
                    playerCharacter[selectedPlayer].SetDestination(hit.point);
                }
            }
        }
    }

}
