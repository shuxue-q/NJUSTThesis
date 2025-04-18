#!/bin/zsh
declare -a file_types=(
  "*.aux" "*.log" "*.out" "*.toc" "*.bbl" "*.blg" "*.lof" "*.lot" "*.bcf" "*.run.xml"
  "*.fls" "*.xdv" "*.fdb_latexmk"
)
for file_type in "${file_types[@]}"; do 
  find . -type f -name "$file_type" -exec rm -v {} \;
done
