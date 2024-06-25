using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController : MonoBehaviour
{
    [SerializeField] Transform cameraTransform;

    [SerializeField] float movmentSpeed = 2;
    [SerializeField] float movmentTime = 5;
    [SerializeField] float rotationAmount = 1;
    [SerializeField] float zoomAmount = 2;
    private Transform followTransform;

    private Vector3 originalZoom;
    private Quaternion originalRotation;

    private Vector3 newPosition;
    private Quaternion newRotation;
    private Vector3 newZoom;
    private Vector3 tempZoomVector;

    private Vector3 dragStartPosition;
    private Vector3 dragCurrentPosition;
    private Vector3 rotateStartPosition;
    private Vector3 rotateCurrentPosition;

    // Start is called before the first frame update
    void Start()
    {
        followTransform = null;

        if (cameraTransform == null)
        {
            cameraTransform = this.gameObject.transform.GetChild(0);
        }

        newPosition = transform.position;
        newRotation = transform.rotation;

        originalZoom = cameraTransform.localPosition;
        originalRotation = transform.rotation;
        newZoom = cameraTransform.localPosition;

        tempZoomVector = Vector3.zero;
        tempZoomVector.y = -zoomAmount;
        tempZoomVector.z = zoomAmount;
    }

    // Update is called once per frame
    void Update()
    {
        if ((Input.GetKeyDown(KeyCode.LeftAlt) || Input.GetKeyDown(KeyCode.RightAlt) || Input.GetMouseButtonDown(1)) 
            && followTransform != null)
        {
            followTransform = null;
        }
        else if (followTransform != null)
        {
            transform.position = followTransform.position;
        }
        else
        {
            HandleMouseInput();
            HandleMovmentInput();
        }
    }

    private void HandleMouseInput()
    {
        //Zoom
        MouseZoomCamera();

        //Drag Camera
        MouseDragCamera();

        //Rotate
        MouseRotateCamera();
    }

    private void MouseZoomCamera()
    {
        if (Input.mouseScrollDelta.y != 0)
        {
            newZoom += Input.mouseScrollDelta.y * tempZoomVector;
        }
    }

    private void MouseDragCamera()
    {
        if (Input.GetMouseButtonDown(1))
        {
            Plane plane = new Plane(Vector3.up, Vector3.zero);

            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            float entry;
            if (plane.Raycast(ray, out entry))
            {
                dragStartPosition = ray.GetPoint(entry);
            }
        }

        if (Input.GetMouseButton(1))
        {
            Plane plane = new Plane(Vector3.up, Vector3.zero);

            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            float entry;
            if (plane.Raycast(ray, out entry))
            {
                dragCurrentPosition = ray.GetPoint(entry);

                newPosition = transform.position + dragStartPosition - dragCurrentPosition;
            }
        }
    }

    private void MouseRotateCamera()
    {
        if (Input.GetKeyDown(KeyCode.LeftAlt) || Input.GetKeyDown(KeyCode.RightAlt))
        {
            rotateStartPosition = Input.mousePosition;
        }

        if (Input.GetKey(KeyCode.LeftAlt) || Input.GetKey(KeyCode.RightAlt))
        {
            rotateCurrentPosition = Input.mousePosition;

            Vector3 diffrence = rotateStartPosition - rotateCurrentPosition;

            rotateStartPosition = rotateCurrentPosition;

            newRotation *= Quaternion.Euler(Vector3.up * (-diffrence.x / 5f));
        }
    }

    private void HandleMovmentInput()
    {
        //Reset camera
        if (Input.GetKeyDown(KeyCode.W))
        {
            newRotation = originalRotation;
            newZoom = originalZoom;
        }

        transform.position = Vector3.Lerp(transform.position, newPosition, Time.deltaTime * movmentTime);
        transform.rotation = Quaternion.Lerp(transform.rotation, newRotation, Time.deltaTime * movmentTime);
        Vector3 tempZoomVecotr = Vector3.Lerp(cameraTransform.localPosition, newZoom, Time.deltaTime * movmentTime);
        if ( -10f >= tempZoomVecotr.z && tempZoomVecotr.z >= -20f 
            && 10f <= tempZoomVecotr.y && tempZoomVecotr.y <= 20f )
        {
            cameraTransform.localPosition = tempZoomVecotr;
        }
    }

    public void FollowCharacter(Transform follow)
    {
        followTransform = follow;
    }
}
