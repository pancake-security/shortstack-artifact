#!/bin/bash


echo "Number of running instances"
aws ec2 describe-instances --filters 'Name=tag:name,Values=shortstack-ae' 'Name=instance-state-name,Values=running' --query 'Reservations[*].Instances[*].[PrivateIpAddress]' --output text | wc -l

echo "Starting instances"
aws ec2 start-instances --instance-ids $(aws ec2 describe-instances --filters 'Name=tag:name,Values=shortstack-ae' 'Name=instance-state-name,Values=stopped' --query 'Reservations[*].Instances[*].[InstanceId]' --output text)
