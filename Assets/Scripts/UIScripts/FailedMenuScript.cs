using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class FailedMenuScript : MonoBehaviour
{
    public static bool gameIsPaused = false;
    public static bool gameIsOver = false;
    [SerializeField] GameObject failedMenuUI;
    [SerializeField] GameObject[] failedActions;

    public void MissonFailed()
    {
        Pause();
    }

    private void Pause()
    {
        failedMenuUI.SetActive(true);
        Time.timeScale = 0f;
        gameIsPaused = true;
        foreach (GameObject action in failedActions)
        {
            action.SetActive(false);
        }
    }

    public void RestartLevel()
    {
        Time.timeScale = 1f;
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
        Debug.Log("Restart this level");
    }

    public void MainMenu()
    {
        Debug.Log("Go back to main menu");
    }

    public void QuitGame()
    {
        Application.Quit();
        Debug.Log("Quit the game");
    }
}
