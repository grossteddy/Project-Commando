using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class VisionCone : MonoBehaviour
{
    [SerializeField] FieldOfView fieldOfView;
    [Range(10, 500)][SerializeField] int VisionConeResolution = 120; //the vision cone will be made up of triangles, the higher this value is the pretier the vision cone will be
    [Range(-1, -3)][SerializeField] float meshDownwardScale = -2.0f;
    [Range(2, 10)][SerializeField] int meshDownwardSections = 6;
    [SerializeField] MeshFilter viewMeshFilter;
    [SerializeField] LayerMask sightVisualizationObstructionMask;
    private Mesh VisionConeMesh;

    //public Material VisionConeMaterial;
    private float VisionRange;
    private float VisionAngle;
    //public LayerMask VisionObstructingLayer;//layer with objects that obstruct the enemy view, like walls, for example

    //Create all of these variables, most of them are self explanatory, but for the ones that aren't i've added a comment to clue you in on what they do
    //for the ones that you dont understand dont worry, just follow along
    void Start()
    {
        VisionRange = fieldOfView.GetRadius();
        VisionAngle = fieldOfView.GetAngle();

        //transform.AddComponent<MeshRenderer>().material = VisionConeMaterial;
        //MeshFilter_ = transform.AddComponent<MeshFilter>();
        //VisionConeMesh = new Mesh();
        VisionAngle *= Mathf.Deg2Rad;

        VisionConeMesh = new Mesh();
        VisionConeMesh.name = "View Mesh";
        viewMeshFilter.mesh = VisionConeMesh;
    }


    void Update()
    {
        DrawVisionCone();//calling the vision cone function everyframe just so the cone is updated every frame
    }

    void DrawVisionCone()//this method creates the vision cone mesh
    {
        int verticesPerSection = VisionConeResolution + 1;
        int totalVertecies = verticesPerSection * meshDownwardSections;
        float stepVerticalSize = meshDownwardScale / meshDownwardSections;
        int[] topDownTriangles = new int[(VisionConeResolution - 1) * 3];
        int[] sourrondTriangles = new int[((VisionConeResolution - 1) * 2 * 3) * (meshDownwardSections - 1)];
        Vector3[] Vertices = new Vector3[totalVertecies];
        float Currentangle = -VisionAngle / 2;
        float angleIcrement = VisionAngle / (VisionConeResolution - 1);
        float Sine;
        float Cosine;

        for (int i = 0; i < meshDownwardSections; i++)
        {
            Currentangle = -VisionAngle / 2;

            Vector3 localY = this.transform.position + Vector3.up * (i * stepVerticalSize);
            Vertices[i * verticesPerSection] = localY;

            for (int j = 0; j < VisionConeResolution; j++)
            {
                int sectionVertex = j + (verticesPerSection * i);
                Sine = Mathf.Sin(Currentangle);
                Cosine = Mathf.Cos(Currentangle);
                Vector3 RaycastDirection = (transform.forward * Cosine) + (transform.right * Sine) + localY;
                Vector3 VertForward = (Vector3.forward * Cosine) + (Vector3.right * Sine) + localY;
                if (Physics.Raycast(localY, RaycastDirection, out RaycastHit hit, VisionRange, sightVisualizationObstructionMask))
                {
                    Vertices[sectionVertex + 1] = hit.point;
                }
                else
                {
                    Vertices[sectionVertex + 1] = VertForward * VisionRange;
                }


                //added code from me
                if(i >= 1)
                {
                    if (j < verticesPerSection - 1)
                    {
                        sourrondTriangles[j] = 0;
                    }
                }


                Currentangle += angleIcrement;
            }
        }

        for (int i = 0, j = 0; i < topDownTriangles.Length; i += 3, j++)
        {
            topDownTriangles[i] = 0;
            topDownTriangles[i + 1] = j + 1;
            topDownTriangles[i + 2] = j + 2;
        }

        VisionConeMesh.Clear();
        VisionConeMesh.vertices = Vertices;
        VisionConeMesh.triangles = topDownTriangles;
    }


}
