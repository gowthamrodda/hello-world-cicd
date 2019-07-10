#!/bin/sh

COMPOSE_FILE="hello-world-cicd/ci/master/ecs-master.compose.yml"
PARAMS_FILE="hello-world-cicd/ci/master/ecs-params.yml"
PROJECT_NAME="alpha"
DEPLOY_TO="master"
CLUSTER="alpha"
AWS_ACCESS_KEY_ID=$1
AWS_SECRET_ACCESS_KEY=$2
REGION="ap-south-1"

/ecs-cli configure \
          profile --profile-name softdev \
          --access-key ${AWS_ACCESS_KEY_ID} \
          --secret-key ${AWS_SECRET_ACCESS_KEY}

/ecs-cli compose \
           --verbose \
           --file ${COMPOSE_FILE} \
           --ecs-params ${PARAMS_FILE} \
           --project-name ${PROJECT_NAME} \
            service up \
           --create-log-groups \
           --cluster-config ${CLUSTER}-config


/ecs-cli compose \
           --verbose \
           --project-name ${PROJECT_NAME} \
            service ps \
           --create-log-groups \
           --cluster-config ${CLUSTER}-config

