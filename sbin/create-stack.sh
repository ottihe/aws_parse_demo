#!/bin/bash -x

if [ $# -lt 5 ]
then
  echo 'Missing required parameters'
  echo "Usage $0 <region> <profile> <stack_name> <template> <parameters>"
  exit 1
fi

region="$1"
profile="$2"
stack_name="$3"
template="$4"
parameters="$5"

stack_exists() {
  echo "Checking for stack $stack_name"
  aws cloudformation describe-stacks \
    --region $region \
    --profile $profile \
    --stack-name $stack_name > /dev/null 2>&1
}

create_stack() {
  echo "CREATING stack $stack_name"
  aws cloudformation create-stack \
    --region $region \
    --profile $profile \
    --stack-name $stack_name \
    --template-body "`cat $template`" \
    --parameters "`cat $parameters`" \
    --capabilities CAPABILITY_IAM \
    --disable-rollback
}

update_stack() {
  echo "UPDATING stack $stack_name"
  aws cloudformation update-stack \
    --region $region \
    --profile $profile \
    --stack-name $stack_name \
    --template-body "`cat $template`" \
    --parameters "`cat $parameters`" \
    --capabilities CAPABILITY_IAM
}

if stack_exists; then
  update_stack
else
  create_stack
fi