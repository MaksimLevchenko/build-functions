# build-functions
This repository will post a script that helps use Serverpod and Buildrunner, and instructions for installing it
# Setting Up and Troubleshooting `profile.ps1` in Windows PowerShell

## Setting Up `profile.ps1`

1. **Check the Profile Path**  
   Run the following command in PowerShell:  
   ```powershell
   $PROFILE
   ```  
   This will display the profile path, typically:  
   ```
   C:\Users\YourUsername\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
   ```

2. **Create or Modify `profile.ps1`**  
   If the file does not exist, create it with:  
   ```powershell
   New-Item -Path $PROFILE -ItemType File -Force
   ```

3. **Edit the Profile File**  
   Open it in Notepad:  
   ```powershell
   notepad $PROFILE
   ```  
   Add your desired commands or configurations.

4. **Enable Script Execution (if restricted)**  
   Run:  
   ```powershell
   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```  
   Confirm the change if prompted.

5. **Restart PowerShell**  
   The profile will now be loaded automatically when PowerShell starts.  

---

## Troubleshooting Issues

1. **Profile File Cannot Be Created**  
   **Error:** `New-Item : Access to the path is denied`  
   **Solution:**  
   - Run PowerShell **as Administrator**.  
   - Ensure the profile path exists:  
     ```powershell
     Test-Path $PROFILE
     ```  
   - If missing, manually create the required folders:  
     ```powershell
     New-Item -Path (Split-Path -Parent $PROFILE) -ItemType Directory -Force
     ```

2. **Script Execution Is Disabled**  
   **Error:** `File ...profile.ps1 cannot be loaded because running scripts is disabled`  
   **Solution:**  
   - Check the current execution policy:  
     ```powershell
     Get-ExecutionPolicy
     ```  
   - If set to `Restricted`, allow local scripts:  
     ```powershell
     Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
     ```  
   - If the issue persists, try:  
     ```powershell
     Set-ExecutionPolicy Unrestricted -Scope CurrentUser
     ```  
     *(Not recommended for security reasons on shared systems.)*

3. **Changes in `profile.ps1` Are Not Applied**  
   **Solution:**  
   - Restart PowerShell.  
   - Verify if the profile file exists:  
     ```powershell
     Test-Path $PROFILE
     ```  
   - Manually run the profile to check for errors:  
     ```powershell
     . $PROFILE
     ```

4. **Edits to `profile.ps1` Are Not Saved**  
   **Solution:**  
   - Run Notepad or another editor **as Administrator**.  
   - Ensure there are no file permission restrictions in the `PowerShell` folder.

5. **Commands in `profile.ps1` Cause Errors**  
   **Solution:**  
   - Manually execute the profile file and check for errors:  
     ```powershell
     . $PROFILE
     ```  
   - Ensure all commands are supported in your PowerShell version.  
   - Check for syntax errors or outdated commands.

If issues persist, try running PowerShell as Administrator and repeat the steps.
