# Container image that runs your code
FROM mtmiller/octave

RUN git clone https://github.com/MOxUnit/MOxUnit.git && cd MOxUnit && make install

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
RUN ["chmod", "+x", "/entrypoint.sh"]

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]