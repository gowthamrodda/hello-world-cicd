#!/bin/sh

COMPOSE_FILE="hello-world-cicd/ci/master/ecs-master.compose.yml"
PROJECT_PREFIX="hello-world"
DEPLOY_TO="master"
CLUSTER="alpha"
AWS_ACCESS_KEY_ID=$1
AWS_SECRET_ACCESS_KEY=$2
REGION="ap-south-1"

/ecs-cli configure \
          profile --profile-name storage-profile \
          --access-key ${AWS_ACCESS_KEY_ID} \
          --secret-key ${AWS_SECRET_ACCESS_KEY}

/ecs-cli compose \
           --verbose \
           --file ${COMPOSE_FILE} \
           --project-name ${PROJECT_PREFIX}-${DEPLOY_TO} \
           --cluster ${CLUSTER} \
           --region ${REGION} \
           create

/ecs-cli compose \
           --verbose \
           --file ${COMPOSE_FILE} \
           --project-name ${PROJECT_PREFIX}-${DEPLOY_TO} \
           --cluster ${CLUSTER} --region ${REGION} service up  --timeout 10

