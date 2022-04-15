#!/bin/bash


echo "Number of running instances"
aws ec2 describe-instances --filters 'Name=tag:name,Values=shortstack-ae' 'Name=instance-state-name,Values=running' --query 'Reservations[*].Instances[*].[PrivateIpAddress]' --output text | wc -l
