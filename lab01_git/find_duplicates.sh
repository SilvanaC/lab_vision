

#!/bin/bash
declare -A arr
shopt -s globstar

for file in **; do
  [[ -f "$file" ]] || continue

  read cksm _ < <(md5sum "$file")
  if ((arr[$cksm]++)); then 
    echo "This file: $file is duplicated"
  fi
done

# Code From: http://superuser.com/questions/386199/how-to-remove-duplicated-files-in-a-directory
