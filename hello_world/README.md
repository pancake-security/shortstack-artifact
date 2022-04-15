# Hello world example

This is a quick start guide on setting up Shortstack and running a simple hello world example on the pre-configured AWS setup that we provide. In this example, we will run the simplest possible Shortstack configuration with 1 L1, 1 L2, and 1 L3 proxy server. Please read [this document](../docs/aws_info.md) on AWS usage before proceeding.

### Preparation

SSH into Gateway VM (see [here](../docs/aws_info.md) for details)

```
ssh -i shortstack.pem ubuntu@gateway_vm_ip
```

You will land in the home directory upon entering the SSH session. Switch to the `shortstack-artifact` folder (this repo), and pull the latest changes

```
cd shortstack-artifact
git pull origin master
```

Next, we are going to check the status of the available VMs in the cluster. The following script will return the number of VMs that are currently running. 

```
cd scripts/aws
./check-instances.sh
```

For this example we need 5 VMs. Hence, make sure that the number returned by the above is greater than or equal to 5 before proceeding. If not, please contact us.

Next, we generate the "hosts file" which contains a list of the IP addresses of the available VMs, using the following script. This script also outputs the details (public, private IP address) of the client VM on which we will run the scripts for the rest of this example. Make note of these IP addresses.  

```
./gen-hosts.sh ~/shortstack.hosts
```

Copy the hosts file to the client VM using the following command. Replace `<client-vm-private-ip>` with the private IP address obatined from the previous command.

```
scp ~/shortstack.hosts ubuntu@<client-vm-private-ip>:/local/deploy/shortstack.hosts
```

Finally, exit gateway VM (can be done using `exit` command). This is important. Please do not run actual scripts for experiments on the Gateway VM --- it is meant only as an entry point. Beyond this point, all following steps/commands are to be performed on the client VM.
  
### Initialize Setup

SSH into client VM (you should have obtained it's public IP address in the previous step)
  
```
ssh -i shortstack.pem ubuntu@<client-vm-public-ip>
```

Check if `shortstack-artifact` directory exists in home directory. Otherwise clone it with `git clone https://github.com/pancake-security/shortstack-artifact`

Pull the latest updates

```
cd shortstack-artifact
git pull origin master
```

Now, we are ready to initialize the various components of the system. To ease evaluator burden, we have prepared automated scripts for this purpose (both for this example, and for other experiments in the paper). The following script will take care of (1) starting up and initializing the key-valye store on one of the VMs (2) starting up the L1, L2, L3 proxy servers on different VMs and initializing them. All of this happens automatically with no user interaction required (the script is aware of the VMs in the cluster via the hosts file that we copied over earlier). 
  
```
cd hello_world
./init_setup.sh traces/helloworld
```

Once the above step is complete, clients can interact with Shortstack. The below command will run a client that executes the operations from the following simple trace: traces/helloworld, which performs PUT operations on 5 keys, and then performs GET operations on the same keys to retrieve their values.

```
/local/deploy/shortstack_driver -h /local/deploy/hosts.csv -t traces/helloworld
```
  
If successful, you should see the values returned by the GET operations read "hello world shortstack is working".
