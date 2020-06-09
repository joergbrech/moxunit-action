# It comes with packages installed
FROM qmrlab/minimal:v2.4.0

RUN git clone https://github.com/MOxUnit/MOxUnit.git /home/MOxUnit; \
    git clone https://github.com/MOdox/MOdox.git /home/MOdox; \
    git clone https://github.com/MOcov/MOcov.git /home/MOcov; \
    octave --eval "restoredefaultpath(); savepath(); exit();"

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
RUN ["chmod", "+x", "/entrypoint.sh"]

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
