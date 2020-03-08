#!/bin/bash
# Script to run terraform
Terraform=$( which terraform )
[ -z $Terraform ] && echo 'Please install terraform and make sure it is in tour $PATH.' && exit 2
[ "$( terraform --version | head -n 1 | grep -c 'v0.12')" == '0' ] && echo "Please use terraform version 12" && exit 2 
 
#"${Terraform}" destroy
#"${Terraform}" init
"${Terraform}" plan -out tf.plan
"${Terraform}" apply tf.plan
