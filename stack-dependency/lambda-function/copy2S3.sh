#!/bin/bash
# US Standard , Virginia
./bundle.sh
aws --profile production s3 cp ./lambda.zip s3://*.*.*/lambda/stackdependency/v1/lambda.zip
