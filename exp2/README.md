# Understanding Scalability Bottlenecks Experiment

This experiment corresponds to Section 6.1, paragraph 2, Figure 12 of the paper. The goal is to understand the scalability bottlenecks of individual layers in Shortstack.

**Note for evaluators**: In the paper, we use two workloads for this experiment --- YCSB-A and YCSB-C. The results are nearly identical for both. In the interest of minimizing evaluator effort, the following instructions are to reproduce the results for the YCSB-A workload. Nevertheless, if an evaluator would like to also run YCSB-C, a description of how to do so can be found towards the end of this README.

### Preparation

_(These are the common preparation steps across most experiments (exp1-4). For a more detailed description of what each of these steps does, refer to [this](../hello_world/README.md). If you have already undertaken these steps recently while running a previous experiment, then you can skip to directly running the experiments on the client VM)_

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

We are now ready to run expriments. The following are 3 sub-experiments for each of the three layers in Shortstack's design. 

### Varying L1 proxys experiment

Use the following script to run the experiement. It takes of initializing and running all the data points without any manual intervention.
```
cd exp2
./run_exp2_varyl1.sh exp2-ycsb-a /local/workloads/ycsb-a-1m
```

Once complete, collect and print results in readable form.

```
./collect_exp2.sh exp2-ycsb-a-varyl1
```

### Varying L2 proxys experiment

Run the experiment

```
./run_exp2_varyl2.sh exp2-ycsb-a /local/workloads/ycsb-a-1m
```

Collect and print results

```
./collect_exp2.sh exp2-ycsb-a-varyl2
```

### Varying L3 proxys experiment

Run the experiment

```
./run_exp2_varyl3.sh exp2-ycsb-a /local/workloads/ycsb-a-1m
```

Collect and print results

```
./collect_exp2.sh exp2-ycsb-a-varyl3
```

#### (Optional) Running YCSB-C
If you would like to run the experiments with the YCSB-C workload, then you can simply repeat the above steps (each of the sub-experiments) with occurences of "ycsb-a" replaced by "ycsb-c".


