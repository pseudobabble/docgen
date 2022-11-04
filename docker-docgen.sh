#!/bin/bash
# This script will convert documentation markdown files using the `template.md` template
# to PDF format.
set -e

if [ "$#" -ne 3 ]; then
    echo "Illegal number of parameters."
    echo "Usage:"
    echo "./generate_documentation_pdf.sh \"TARGET_MARKDOWN_FILE\" \"DOC_TITLE\" \"PRODUCT_AND_VERSION\""
fi


# Get the relevant parts of the path and filename
filename_with_extension=$(basename -- "$1")
directory=$(dirname "$(readlink -f "$1")")
extension="${filename_with_extension##*.}"
filename="${filename_with_extension%.*}"

# Get footer information (title and product & version) and
# replace underscores as they cause LaTeX to subscript
title=$(echo $2 | tr '_' '-')
product_and_version=$(echo "$3" | tr '_' '-')

docker run -v "$directory":"$directory" --user `id -u`:`id -g` docgen "$directory/$filename_with_extension" "$title" "$product_and_version"

