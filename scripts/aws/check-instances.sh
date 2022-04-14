#!/bin/bash

hosts_file=$1

echo "Number of running instances"
aws ec2 describe-instances --filters 'Name=tag:name,Values=shortstack-ae' 'Name=instance-state-name,Values=running' --query 'Reservations[*].Instances[*].[PrivateIpAddress]' --output text | wc -l

aws ec2 describe-instances --filters 'Name=tag:name,Values=shortstack-ae' 'Name=tag:type,Values=server' 'Name=instance-state-name,Values=running' --query 'Reservations[*].Instances[*].[PrivateIpAddress]' --output text > $hosts_file
echo "Generated hosts file"

echo "Client VM (private_ip    public_ip)"
aws ec2 describe-instances --filters 'Name=tag:name,Values=shortstack-ae' 'Name=tag:type,Values=client' 'Name=instance-state-name,Values=running' --query 'Reservations[*].Instances[*].[PrivateIpAddress,PublicIpAddress]' --output text | head
