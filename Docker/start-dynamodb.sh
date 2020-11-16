#!/usr/bin/env bash
docker stop dynamodb-local
docker rm dynamodb-local
docker run -d --name dynamodb-local -p 8000:8000 amazon/dynamodb-local