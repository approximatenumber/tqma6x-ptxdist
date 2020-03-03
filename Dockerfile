FROM ubuntu:18.04
ARG USERNAME=root
COPY . /image
WORKDIR /image
RUN ./prepare-env.sh && rm -rf /image
USER ptxuser
WORKDIR "/src"
