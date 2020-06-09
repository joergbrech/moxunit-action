# It comes with packages installed
FROM mtmiller/octave:5.1.0

RUN git clone https://github.com/MOxUnit/MOxUnit.git /home/MOxUnit; \
    git clone https://github.com/MOdox/MOdox.git /home/MOdox; \
    git clone https://github.com/MOcov/MOcov.git /home/MOcov; \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        octave-info \
        octave-parallel \
        octave-struct \
        octave-io \
        octave-statistics \
        octave-optim \
        octave-image && \
    octave --eval "restoredefaultpath(); savepath(); exit();"

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
RUN ["chmod", "+x", "/entrypoint.sh"]

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
