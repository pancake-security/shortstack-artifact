# Using AWS VMs

## Connection

Connecting to each server requires a private key: `shortstack.pem`. We will share the key through hotcrp to the reviewers only. Please store the private key in a secure place.

To connect to any aws server:
```bash
chmod 400 shortstack.pem
ssh -i shortstack.pem ubuntu@ip
```

## Gateway server

The entry point into the AWS cluster will be through a special Gateway server. The IP address of this Gateway server will be shared privately with the reviewers only.
This Gateway server is pre-configured with AWS credentials, and can be used to query the status of available VMs in the cluster, and obtain the IP address of the client server on which the experiments are to be run.
Each experiment's README provides instructions on this process.

## Security

We trust that the reviewers will not misuse the pre-configured AWS credentials on the gateway server. Please avoid directly issuing any aws-cli commands. Please inform us if something happens by accident.

