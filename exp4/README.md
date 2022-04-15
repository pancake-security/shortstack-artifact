# Failure recovery experiment

This experiment corresponds to Section 6.2, Figure 14 of the paper. The goal is to demonstrate that Shortstack does not leak sensitive information during failures.

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

### L1 failure experiment

Use the following script to run the experiment. The script automatically sets up the cluster, runs the clients, and fails an L1 proxy replica in the middle of the experiment.

```
cd exp4
./run_faill1.sh exp4-ycsb-a /local/workloads/ycsb-a-1m
```

Run the following to collect the results (instantaneous throughput over time)

```
/collect_exp4.sh exp4-ycsb-a-faill1
```

Use the following script to plot the graph of throughput over time (using gnuplot)

```
./plot.sh exp4-ycsb-a-faill1
```

The output plot is located at `data/exp4-ycsb-a-faill1.eps`. You can copy this image onto your laptop/workstation (e.g. via `scp`), and view it locally.

### L2 failure experiment

Use the following script to run the experiment. The script automatically sets up the cluster, runs the clients, and fails an L2 proxy replica in the middle of the experiment.

```
cd exp4
./run_faill2.sh exp4-ycsb-a /local/workloads/ycsb-a-1m
```

Run the following to collect the results (instantaneous throughput over time)

```
/collect_exp4.sh exp4-ycsb-a-faill2
```

Use the following script to plot the graph of throughput over time (using gnuplot)

```
./plot.sh exp4-ycsb-a-faill2
```

The output plot is located at `data/exp4-ycsb-a-faill2.eps`. You can copy this image onto your laptop/workstation (e.g. via `scp`), and view it locally.

### L3 failure experiment

Use the following script to run the experiment. The script automatically sets up the cluster, runs the clients, and fails an L3 proxy in the middle of the experiment.

```
cd exp4
./run_faill3.sh exp4-ycsb-a /local/workloads/ycsb-a-1m
```

Run the following to collect the results (instantaneous throughput over time)

```
/collect_exp4.sh exp4-ycsb-a-faill3
```

Use the following script to plot the graph of throughput over time (using gnuplot)

```
./plot.sh exp4-ycsb-a-faill3
```

The output plot is located at `data/exp4-ycsb-a-faill3.eps`. You can copy this image onto your laptop/workstation (e.g. via `scp`), and view it locally.


