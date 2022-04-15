# Throughput Scalability Experiment

This experiment corresponds to Section 6.1, paragraph 1, Figures 11 and 13a of the paper. The goal is to demonstrate Shortstack's linear throughput scalability.

**Note for evaluators**: In the paper, we use two workloads for this experiment --- YCSB-A and YCSB-C. In the interest of minimizing evaluator effort, the following instructions are to reproduce the results for the YCSB-A workload (this is the worst-case workload among the two for Shortstack as seen in Figure 11c of the paper). The scalability trends for the YCSB-C workload are nearly identical. Nevertheless, if an evaluator would like to also run YCSB-C, a description of how to do so can be found towards the end of this README.

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

<SSH into client VM, pull latest updates>

Push binaries

```
./scripts/push_bins.sh
```

Run  experiments

```
cd exp1
./run_exp1.sh scale-ycsb-a /local/workloads/ycsb-a-1m
```

Collect and print results

```
./collect_exp1.sh scale-ycsb-a
```

**(Optional) Running YCSB-C**



