#!/bin/bash
# This script will convert documentation markdown files using the `template.md` template
# to branded PDF format.
set -e

if [ "$#" -ne 3 ]; then
    echo "Illegal number of parameters."
    echo "Usage:"
    echo "./generate_documentation_pdf.sh \"TARGET_MARKDOWN_FILE\" \"DOC_TITLE\" \"PRODUCT_AND_VERSION\""
fi


# Get the relevant parts of the path and filename
filename=$(basename -- "$1")
directory=$(dirname "$(readlink -f "$1")")
extension="${filename##*.}"
filename="${filename%.*}"

# Get footer information (title and product & version) and
# replace underscores as they cause LaTeX to subscript
title=$(echo $2 | tr '_' '-')
product_and_version=$( echo "$3" | tr '_' '-')

# Generate a format.tex file with the correct formatting information for the target
target_format_file="$directory/doc_format.tex"
cp format.tex "$target_format_file"
sed -i -e "s/~title~/$title/g" "$target_format_file"
sed -i -e "s/~product_and_version~/$product_and_version/g" "$target_format_file"

# Use pandoc to convert the markdown to PDF with branding
pandoc --verbose -H "$directory/doc_format.tex" "$directory/$filename.$extension" -o "$directory/$filename.pdf"
# -f markdown-raw_tex
# Remove the format file used to generate the PDF
rm "$directory/doc_format.tex"
