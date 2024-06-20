param(
    [string]$PROJ_NAME
)

function Main {
    # Define the root directory for projects
    $rootDir = "C:\Users\domin\GithubRepos\PROJECTS"

    # Check if the PROJECTS directory exists
    if (-Not (Test-Path $rootDir)) {
        Write-Error "The directory '$rootDir' does not exist."
        return
    }

    # Navigate to the PROJECTS directory
    Set-Location $rootDir

    # Check if PROJ_NAME contains whitespace
    if ($PROJ_NAME -match '\s') {
        Write-Error "The project name should not contain whitespace."
        return
    }

    # Form the full project directory name
    $fullProjDirName = "PROJECT-$PROJ_NAME"

    # Check if a directory with the full project name already exists
    if (Test-Path $fullProjDirName) {
        Write-Error "A project directory with the name '$fullProjDirName' already exists."
        return
    }

    # Create GitHub repository
    gh repo create $fullProjDirName --private --add-readme -c -g 'R'

    # Change directory into the new repository
    Set-Location $fullProjDirName

    # Open Visual Studio Code
    code .
}

Main
