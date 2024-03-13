#!/bin/bash

# ==============================================================================
# Script-Name: VersionCleanup.sh
# Desc: Script to delete old the old patch versions in this folder. It will delete all folders and files with the name you want it to delete "Folder/File Name" on your server - Except latest 2
# Author: Mr_Akihiro
# Version: Choco 2.1
# Created at: 11.03.2024
# Last Change Date: 13.03.2024
# ===============================================================================

#!/bin/bash

dry_run=false

# Process command-line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -d|--dry-run) dry_run=true ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Ensure you replace "/path/to/your/target/directory" with the actual directory path
directory="/path/to/your/target/directory"

# Log file creation 
log_file="${directory}/deletionLog_$(date +%Y-%m-%d).log"


touch "$log_file"

# Verify directory change and log file access
cd "$directory" || { echo "Failed to change directory to $directory. Exiting." | tee -a "$log_file"; exit 1; }

# Replace "ENTERFILENAME" with your actual filename pattern
sorted_items=$(find . -maxdepth 1 -name "ENTERFILENAME" -printf '%f\n' | sort -t '-' -k2,2V -k3,3r)
total_items=$(echo "$sorted_items" | wc -l)
let items_to_delete=total_items-2

if [ $items_to_delete -le 0 ]; then
    echo "Nothing to delete, only the latest 2 versions are present." | tee -a "$log_file"
else
    delete_candidates=$(echo "$sorted_items" | head -n "$items_to_delete")
    
    if [ "$dry_run" = true ]; then
        echo "Dry run mode enabled. The following files would be deleted:" | tee -a "$log_file"
        echo "$delete_candidates" | tee -a "$log_file"
    else
        echo "$delete_candidates" | while read -r line; do
            rm -rf "$line"
            echo "Deleted: $line" | tee -a "$log_file"
        done
        echo "Deletion of old versions completed." | tee -a "$log_file"
    fi
fi



# Good Luck!