# Documentation PDF generator

## Common Usage
1. Clone the repo
```bash
git clone ssh://git@github.com/pseudobabble/docgen.git
```

2. Add a PNG header with transparent background named`docs-header.png`, replacing `docs-header.placeholder`.


## Bare Metal Usage:
1. Install `pandoc` and the requred LaTeX packages:
```bash
sudo apt install pandoc texlive-fonts-recommended texlive-latex-recommended
```
2. Make the script executable 
```bash
chmod +x generate_documentation_pdf.sh
```
3. Run against markdown docs 
```bash
./generate_documentation_pdf.sh "<<TARGET_MARKDOWN_FILE>>" "<<DOC_TITLE>>" "<<PRODUCT_AND_VERSION>>"
```

Example:
(Path quoting avoids issues with spaces in filenames)
```bash
./generate_documentation_pdf.sh "../some_docs/Markdown Docs.md" "Document Title" "product_name 1.1.0-alpha.0""
``` 


## Docker Usage
Since `pandoc` and `LaTeX` don't always play nicely with MacOS, a Dockerfile is provided.

2. Change to repo directory
```bash
cd docgen
```
3. Build the image
```bash
docker build -t docgen -f ubuntu.Dockerfile .
```
4. Run against markdown docs
```bash
docker run --user `id -u`:`id -g` -v /the/directory/containing/the/documentation/markdown:/the/directory/containing/the/documentation/markdown docgen "/the/directory/containing/the/documentation/markdown/the_markdown_documentation.md" "<<DOC_TITLE>>" "<<PRODUCT_AND_VERSION>>"
```

There is a bash script, `docker-docgen.sh`, which wraps the main docker command and takes the same arguments as the bare-metal script:

```bash
chmod +x docker-docgen.sh
./docker-docgen.sh "../some_docs/Markdown Docs.md" "Document Title" "product_name 1.1.0-alpha.0""
```


## Further Improvements
1. Optionally obtain <<DOC_TITLE>> from the `.md` filename or document title
2. Handle tables
