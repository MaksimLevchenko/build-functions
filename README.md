# build-functions
This repository will post a script that helps use Serverpod and Buildrunner, and instructions for installing it

### Usage

### Commands Executed

#### 1. `build`
- Checks if the current directory or a subdirectory ends with `_flutter`.
- Executes the following commands:
  - `dart run build_runner build`
  - `fluttergen`

If the `-fvm` flag is passed, the commands are executed with `fvm exec`.

#### 2. `build-server`
- Checks if the current directory or a subdirectory ends with `_server`.
- Executes the following commands:
  - `serverpod generate`
  - `serverpod create-migration` (with an optional `-f` flag to force migration creation)
  - `dart run bin/main.dart --role maintenance --apply-migrations`

If the `-fvm` flag is passed, the commands are executed with `fvm exec`.

#### 3. `build-full`
- Runs the full build process, including both Flutter and Serverpod builds.
  - Executes `build` function (Flutter build).
  - Executes `build-server` function (Serverpod build).

If the `-fvm` flag is passed, both build processes are executed with `fvm exec`.

### Troubleshooting

1. **Directory not found**  
   If the script cannot find a directory ending with `_flutter` or `_server`, make sure the folder structure follows the correct naming conventions. Manually check the directories or ensure that they are correctly named.

2. **Missing `fvm` tool**  
   If you are using the `-fvm` flag but the `fvm` tool is not installed, you need to install it. Follow the installation instructions on the [fvm GitHub page](https://github.com/leoafarias/fvm).

3. **Command not executing properly**  
   If the command doesn't execute correctly, ensure that PowerShell is configured to run scripts. You may need to adjust the execution policy:
   ```powershell
   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

4. **Permission Issues**  
   If you encounter permission errors when running commands, ensure that you have the appropriate permissions to modify files or directories. You may need to run PowerShell as Administrator.

5. **Command Errors**  
   If a specific command fails (e.g., `fluttergen`, `build_runner`), verify that the required dependencies are installed. For example:
   - For `fluttergen`, ensure it's installed in your Flutter project.
   - For `build_runner`, ensure the required dependencies are added to your `pubspec.yaml` and run `dart pub get`.

6. **Migration Issues**  
   If you're running `serverpod create-migration` and facing issues, check that your database schema is up-to-date and verify the server is running correctly.

7. **fvm Version Mismatch**  
   If you encounter issues related to Flutter versions, verify that the correct version is being used. Run `fvm list` to view the available Flutter versions and make sure the version you need is active.


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
   Copy the Commands from the Repository and paste the Commands into Your Local profile.ps1

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
