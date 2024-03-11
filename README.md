# VersionCleanup

## About
VersionCleanup.sh is a Bash script designed to automate the cleanup of outdated files and folders matching the pattern you define within a specified directory on your server. It retains only the latest two versions of these files/folders, based on sorting criteria, and deletes the rest. Additionally, it logs the actions taken during each execution, including deletions, to a log file.

## Features
- **Selective Cleanup**: Efficiently identifies and removes older versions of files, keeping the directory clean and manageable.
- **Automated Logging**: Every run is logged, detailing which files were removed, making tracking and verification straightforward.
- **Safety First**: Performs checks to avoid accidental execution in the wrong directory.

## Getting Started

### Prerequisites
- Linux OS Server
- Appropriate permissions to read, write, and delete files in the target directory

### Installation
1. Clone this repository or download the Script directly
2. After uploading/downloading to server, navigate to the script's directory
```bash
cd <path-to-Script>
```
4. Make the script executable
```bash
chmod +x CleanScript.sh
```
### Configuration

Open the Script and edit the `directory` variable to the path of your target directory where the cleanup should occur. Also change `-name` to configure which files/folder should be deleted.

## Detailed Documentation
For further and more detailed Documentation see the Documentation.pdf document.

