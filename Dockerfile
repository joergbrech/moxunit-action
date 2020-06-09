# It comes with packages installed Octave 4.2.2
FROM kuzudeneme/octave:latest 

RUN git clone https://github.com/MOxUnit/MOxUnit.git /home/MOxUnit; \
    git clone https://github.com/MOdox/MOdox.git /home/MOdox; \
    git clone https://github.com/MOcov/MOcov.git /home/MOcov 

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
RUN ["chmod", "+x", "/entrypoint.sh"]

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
