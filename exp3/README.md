# Sensitivity to Skew Experiment

This experiment corresponds to Section 6.1, paragraph 3, Figure 13b of the paper. The goal is to understand how Shortstack's throughput is impacted by skew in the workload.

**Note for evaluators**: In Figure 13b of the paper, for each x-value (no. of proxy servers in each layer) we show the throughput that Shortstack achieves for four different YCSB skew parameters. The takeaway is identical for all x-values (throughput is not impacted by skew). In the interest of minimizing evaluator effort, the following instructions are for reproducing the x = 4 (maxmimum scale) data point in Figure 13b. Nevertheless, if you are interested in reproducing other x-values, then refer to the discussion towards the end of this README.   

### Preparation

(These are the common preparation steps across most experiments. For a more detailed description of what each of these steps does, refer to [this](../hello_world/README.md))

SSH into Gateway VM (see [here](../docs/aws_info.md) for details)

```
ssh -i shortstack.pem ubuntu@gateway_vm_ip
```

Switch to the `shortstack-artifact` folder (this repo), and pull the latest changes

```
cd shortstack-artifact
git pull origin master
```

Check the status of the available VMs in the cluster. 

```
cd scripts/aws
./check-instances.sh
```

For this experiment we need a total of 33 VMs. Hence, make sure that the number returned by the above is greater than or equal to 33 before proceeding. If not, please contact us.

Generate the hosts file, and obtain the IP address (public, private) of the client VM.  Make note of these IP addresses.  

```
./gen-hosts.sh ~/shortstack.hosts
```

Copy the hosts file to the client VM. Replace `<client-vm-private-ip>` with the private IP address obatined from the previous command.

```
scp ~/shortstack.hosts ubuntu@<client-vm-private-ip>:/local/deploy/shortstack.hosts
```

Exit gateway VM (can be done using `exit` command). This is important. Please do not run actual scripts for experiments on the Gateway VM. Beyond this point, all following steps/commands are to be performed on the client VM.

SSH into client VM (you should have obtained it's public IP address in the previous step)
  
```
ssh -i shortstack.pem ubuntu@<client-vm-public-ip>
```

Switch to `shortstack-artifact` and pull the latest updates

```
cd shortstack-artifact
git pull origin master
```

Run the following to push binaries to all the VMs. This will ensure that all the VMs have up-to-date copies of all application binaries. 

```
./scripts/push_bins.sh
```

### Running the experiment

Use the following automated script to run the experiment. Manual intervention is not required.

```
cd exp3
./run_exp3.sh exp3-ycsb-a /local/workloads/ycsb-a-1m
```

Collect and print the results in readable form

```
./collect_exp3.sh exp3-ycsb-a
```



