#!/bin/bash
source env.sh
rm -rf docker-compose.yml
perl -p -e 's/\$\{([^}]+)\}/defined $ENV{$1} ? $ENV{$1} : $&/eg' < compose-template.yml > docker-compose.yml
docker-compose up
