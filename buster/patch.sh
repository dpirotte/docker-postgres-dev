#!/bin/bash

sed -i 's/\$.*-pgdg/buster-pgdg/' $(dirname $0)/Dockerfile
