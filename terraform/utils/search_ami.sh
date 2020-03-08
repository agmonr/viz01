#!/bin/bash
for f in $(  aws ec2 describe-images --owners amazon --filters 'Name=name,Values=ubuntu-bionic*' 'Name=state,Values=available' --query 'reverse(sort_by(Images, &CreationDate))[:100].ImageId' --output text ); do 
  echo $f
  aws ec2 describe-images  --region eu-west-1 --image-ids "${f}"
    
done

