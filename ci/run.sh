#!/bin/bash

set -eu

export fly_target=${fly_target:-hello-world}

fly -t ${fly_target} validate-pipeline --config pipeline.yml
fly -t ${fly_target} set-pipeline -p hello-world-pipeline -c pipeline.yml --load-vars-from=credentials.yml -v aws_access_key_id=AKIAZSJR72XK6QSFTCFC -v aws_secret_access_key=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
fly -t ${fly_target} unpause-pipeline -p hello-world-pipeline
fly -t ${fly_target} trigger-job -w -j hello-world-pipeline/job-unit-test-master

# fly -t hello-world destroy-pipeline -p hello-world-pipeline
