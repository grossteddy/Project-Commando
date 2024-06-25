using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class PauseMenuScript : MonoBehaviour
{
    private static bool gameIsPaused = false;
    private static bool gameIsOver = false;
    private static bool cannotPause = false;
    [SerializeField] bool startWithStartMenu = true;
    [SerializeField] GameObject pauseMenuUI;
    [SerializeField] GameObject failedMenuUI;
    [SerializeField] GameObject wonMenuUI;
    [SerializeField] GameObject startMenuUI;
    [SerializeField] GameObject[] pausedActions;

    private void Start()
    {
        if (startWithStartMenu)
        {
            startMenuUI.SetActive(true);
            gameIsPaused = true;
            Pause();
        }
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Escape) && cannotPause == false)
        {
            if (gameIsPaused)
            {
                gameIsPaused = false;
                Resume();
            }
            else
            {
                gameIsPaused = true;
                pauseMenuUI.SetActive(true);
                Pause();
            }
        }
    }

    private void Pause()
    {
        Time.timeScale = 0f;
        foreach(GameObject action in pausedActions)
        {
            action.SetActive(false);
        }
    }

    public void Resume()
    {
        gameIsPaused = false;
        pauseMenuUI.SetActive(false);
        startMenuUI.SetActive(false);
        Time.timeScale = 1f;
        foreach (GameObject action in pausedActions)
        {
            action.SetActive(true);
        }
    }

    public void BringOptions()
    {
        Debug.Log("Bring up options menu");
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

    public void MissonFailed()
    {
        cannotPause = true;
        gameIsOver = true;
        failedMenuUI.SetActive(true);
        Pause();
    }

    public void MissionWon()
    {
        cannotPause = true;
        gameIsOver = true;
        wonMenuUI.SetActive(true);
        Pause();
    }
}
