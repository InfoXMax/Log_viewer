# Log Viewer Script

This Bash script provides a simple and efficient way to view log files on a Linux system. It offers the following features:

- **Log Selection**: Choose from a list of common log files on your system.
- **Log File Information**: Display essential information about the selected log file, such as size, line count, and last modification date.
- **Real-time Log Viewing**: View log entries in real-time as they are appended to the log file.
- **Search Logs**: Search for specific terms within log files to quickly find relevant information.

## Table of Contents

- [Getting Started](#getting-started)
- [Usage](#usage)
- [Common Log Files](#common-log-files)
- [License](#license)

## Getting Started

1. Clone or download this repository to your local machine.

2. Navigate to the directory containing the script.

3. Ensure the script is executable:

   ```bash
   chmod +x log_viewer.sh

## Usage
Run the script:
   ```bash
   ./log_viewer.sh
```
Follow the on-screen menu instructions to:

Select a log file.
View log file information.
View log entries in real-time.
Search for specific content within log files.
Common Log Files
The script includes a predefined list of common log file locations. You can customize this list by editing the log_files array in the script to suit your system's log file locations.

License
This project is licensed under the MIT License. See the LICENSE file for details.

