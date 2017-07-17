#!/bin/bash
set x
region="your region"
profile="your aws profile"
current_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
template="$current_dir/vpc.template"
stack_name='your stack name'
parameters="$current_dir/parameters.json"
$current_dir/../sbin/create-stack.sh $region $profile $stack_name $template $parameters
