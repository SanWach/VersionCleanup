#!/bin/bash

# ==============================================================================
# Script-Name: VersionCleanup.sh
# Desc: Script to delete old the old patch versions in this folder. It will delete all folders and files with the name you want it to delete "Folder/File Name" on your server - Except latest 2
# Author: Mr_Akihiro
# Version: Choco 2.0
# Created at: 11.03.2024
# Last Change Date: 11.03.2024
# ===============================================================================

dry_run=false

# Process command-line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -d|--dry-run) dry_run=true ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

directory=" " # Manually Enter correct Path!

#LogFile Creation to keep track of changes
log_file="deletionLog_$(date +%Y-%m-%d).log"

cd "$directory" || exit

sorted_items=$(find . -maxdepth 1 -name "ENTERFILENAME" -printf '%f\n' | sort -t '-' -k2,2V -k3,3r) #Don't forget to enter folder or file name in -name ""
total_items=$(echo "$sorted_items" | wc -l)
let items_to_delete=total_items-2

if [ $items_to_delete -le 0 ]; then
    echo "Nothing to delete, only the latest 2 versions are present." | tee -a "$log_file"
else
    delete_candidates=$(echo "$sorted_items" | head -n "$items_to_delete")
    
    if [ "$dry_run" = true ]; then
        echo "Dry run mode enabled. The following files would be deleted:"
        echo "$delete_candidates"
    else
        echo "$delete_candidates" | while read -r line; do
            rm -rf "$line"
            echo "Deleted: $line"
        done
        echo "Deletion of old versions completed."
    fi
fi


# Good Luck!