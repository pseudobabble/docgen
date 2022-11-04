#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:18.04

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git man unzip wget && \
  apt-get install -y pandoc && \
  apt-get install -y texlive-fonts-recommended && \
  apt-get install -y texlive-latex-recommended && \
  rm -rf /var/lib/apt/lists/*


RUN mkdir /app
WORKDIR /app
COPY ./docs-header.png ./
COPY ./format.tex ./
COPY ./generate_documentation_pdf.sh ./
RUN chmod +x generate_documentation_pdf.sh
COPY ./wallpaper.sty ./

RUN echo whoami

ENTRYPOINT ["/app/generate_documentation_pdf.sh"]

