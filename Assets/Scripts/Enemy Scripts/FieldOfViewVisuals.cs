using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SocialPlatforms;

public class FieldOfViewVisuals : MonoBehaviour
{
    [SerializeField] FieldOfView fieldOfView;
    [SerializeField] float meshResolution = 2;
    [Range(-1, -3)][SerializeField] float meshDownwardScale = -2.0f;
    [Range(2, 10)][SerializeField] int meshDownwardSections = 6;
    [SerializeField] MeshFilter viewMeshFilter;
    [SerializeField] LayerMask sightVisualizationObstructionMask;
    private Mesh viewMesh;

    private float viewAngle;
    private int stepCount;
    private float stepAngleSize;
    private float stepVerticalSize;
    private int verteciesInSection;
    private int vertexTotal;
    private int[] finalArray;
    private Vector3[] vertices;

    // Start is called before the first frame update
    private void Start()
    {
        viewMesh = new Mesh();
        viewMesh.name = "View Mesh";
        viewMeshFilter.mesh = viewMesh;

        viewAngle = fieldOfView.GetAngle();
        stepCount = Mathf.RoundToInt(viewAngle * meshResolution);
        stepAngleSize = viewAngle / stepCount;
        stepVerticalSize = meshDownwardScale / meshDownwardSections;

        verteciesInSection = (stepCount + 2);
        vertexTotal = verteciesInSection * meshDownwardSections;

        vertices = new Vector3[vertexTotal];

        FirstDraw();
    }

    private void LateUpdate()
    {
        DrawFieldOfView();
    }

    private void FirstDraw()
    {
        List<int> triangles = new List<int>();
        List<Vector3> viewPoints = new List<Vector3>();

        for (int i = 0; i < meshDownwardSections; i++)
        {
            Vector3 localY = this.transform.position + Vector3.up * (i * stepVerticalSize);

            viewPoints.Add(localY);
            for (int j = 0; j < verteciesInSection; j++)
            {
                int SectionVertex = j + (verteciesInSection * i);

                float angle = transform.eulerAngles.y - viewAngle / 2 + stepAngleSize * j;
                if (j <= stepCount)
                {
                    viewPoints.Add(ViewCast(angle, localY));
                }

                vertices[SectionVertex] = transform.InverseTransformPoint(viewPoints[SectionVertex]);


                if (i == 0 || i == meshDownwardSections - 1)
                {
                    if (j < verteciesInSection - 2)
                    {
                        triangles.Add(verteciesInSection * i);
                        triangles.Add(SectionVertex + 1);
                        triangles.Add(SectionVertex + 2);
                    }
                }

                if (i >= 1)
                {
                    if (j < verteciesInSection - 1)
                    {
                        triangles.Add(SectionVertex);
                        triangles.Add(SectionVertex + 1);
                        triangles.Add(SectionVertex - verteciesInSection);
                        triangles.Add(SectionVertex + 1);
                        triangles.Add(SectionVertex - verteciesInSection + 1);
                        triangles.Add(SectionVertex - verteciesInSection);
                    }
                    else
                    {
                        triangles.Add(SectionVertex);
                        triangles.Add(verteciesInSection * i);
                        triangles.Add(SectionVertex - verteciesInSection);
                        triangles.Add(verteciesInSection * i);
                        triangles.Add(verteciesInSection * i - verteciesInSection);
                        triangles.Add(SectionVertex - verteciesInSection);
                    }
                }

            }
        }

        finalArray = triangles.ToArray();

        //viewMesh.Clear();
        //viewMesh.vertices = vertices;
        //viewMesh.triangles = finalArray; 
    }

    private void DrawFieldOfView()
    {
        for (int i = 0; i < meshDownwardSections; i++)
        {
            Vector3 localY = this.transform.position + Vector3.up * (i * stepVerticalSize);

            for (int j = 0; j < verteciesInSection; j++)
            {
                int SectionVertex = j + (verteciesInSection * i);

                float angle = transform.eulerAngles.y - viewAngle / 2 + stepAngleSize * j;

                /*if (j <= stepCount)
                {
                    viewPoints.Add(ViewCast(angle, localY));
                }
                */

                if (j >= 1)
                {
                    vertices[SectionVertex] = transform.InverseTransformPoint(ViewCast(angle, localY));
                }

            }
        }
        viewMesh.Clear();
        viewMesh.vertices = vertices;
        viewMesh.triangles = finalArray;
    }

    private Vector3 DirFromAngle(float angleInDegrees, bool angleIsGlobel)
    {
        Vector3 dir = Vector3.zero;
        if (!angleIsGlobel)
        {
            angleInDegrees += transform.eulerAngles.y;
        }
        //dir = new Vector3(Mathf.Sin(angleInDegrees * Mathf.Deg2Rad), 0, Mathf.Cos(angleInDegrees * Mathf.Deg2Rad));
        dir.x = Mathf.Sin(angleInDegrees * Mathf.Deg2Rad);
        dir.y = 0;
        dir.z = Mathf.Cos(angleInDegrees * Mathf.Deg2Rad);
        return dir;
    }

    private Vector3 ViewCast(float globelAngle, Vector3 localY)
    {
        float viewRadius = fieldOfView.GetRadius();
        Vector3 dir = DirFromAngle(globelAngle, true);
        RaycastHit hit;

        if (Physics.Raycast(localY, dir, out hit, viewRadius, sightVisualizationObstructionMask))
        {
            //return new ViewCastInfo(true, hit.point, hit.distance, globelAngle);// added the + dir * dirFromHit
            return hit.point;
        }
        else
        {
            //return new ViewCastInfo(false, localY + dir * viewRadius, viewRadius, globelAngle);
            return localY + dir * viewRadius;
        }
    }

    private Vector3 ViewCast(float globelAngle)
    {
        float viewRadius = fieldOfView.GetRadius();
        Vector3 dir = DirFromAngle(globelAngle, true);
        RaycastHit hit;

        if (Physics.Raycast(transform.position, dir, out hit, viewRadius, sightVisualizationObstructionMask))
        {
            //return new ViewCastInfo(true, hit.point, hit.distance, globelAngle);
            return hit.point;
        }
        else
        {
            //return new ViewCastInfo(false, transform.position + dir * viewRadius, viewRadius, globelAngle);
            return transform.position + dir * viewRadius;
        }
    }
}
