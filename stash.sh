#!/bin/bash

# Directory to store tar files
archive_dir="/home/stash"

# Ensure archive directory exists
 

# Get current branch name
branch=$(git rev-parse --abbrev-ref HEAD)

# Get modified tracked files BEFORE stashing
git ls-files -m > modified_files_list.txt

# Step 1: Stash changes
echo "Stashing your changes..."
git stash

# Ask user if they want to create tar archive
read -p "Do you want to create a tar archive of modified files on branch '$branch'? (y/n): " answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
  if [[ -s modified_files_list.txt ]]; then
    tar_file="${archive_dir}/modified_files_${branch}.tar"
    tar -cf "$tar_file" -T modified_files_list.txt
    echo "Archive '$tar_file' created successfully."
  else
    echo "No modified files to archive."
  fi
else
  echo "Tar archive creation skipped."
fi

# Cleanup
rm -f modified_files_list.txt
