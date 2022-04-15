# Shortstack Artifact

This repo contains scripts and instructions for running the experiments from "Shortstack: Scalable & Fault-tolerant Noise-Injection"

* [`shortstack`](https://github.com/pancake-security/shortstack.git) The main Shortstack repo containing source code, build instructions, documentation, and more.

## AWS: A Note for Artifact Evaluators

For artifact evaluation, given the scale of our experiments, we deploy all of the systems on AWS Cloud Services. To reduce evaluator burden, we will provide pre-configured instances with all relevant binaries and files. However, due to the high cost of EC2 instances, we are unable to keep all instances running throughput the evaluation period. We request the evaluators to reserve time-slots through this <TODO: calendar>, and we will make sure the instances are available before the time-slot starts. We request evaluators to mark themselves as Reviewer A/B/C, etc., to preserve anonymity. 

**We kindly request evaluators to reserve time-slots judiciously. Estimated times for both Getting Started and Reproducing Results are provided below. Please avoid over-provisioning time-slots, as it can be expensive to keep EC2 instances running for long periods of time.**

A private access key will be used to access all EC2 instances; we plan to share the key with evaluators anonymously. Once the private key is provided, the following steps should permit ssh access to the instances:

```bash
chmod 400 shortstack.pem
ssh -i shortstack.pem ubuntu@public_ip
```

We also provide AWS EC2 AMI images and necessary scripts, saving the effort from setting up their specific environments if the evaluators want to launch the instances from their own AWS accounts. 

Please check this [document](docs/aws_info.md) for information on accessing and using AWS EC2 machines.


## Directory structure 
* [`docs`](docs) Documentation for general environment setup used by all experiments.
* [`hello_world`](hello_world) A simple hello world example for getting started. 
* [`exp1`](exp1) Throughput scalability analysis.
* [`exp2`](exp2) Understanding scalability bottlenecks.
* [`exp3`](exp3) Sensitivity to skew in workload.
* [`exp4`](exp4) Failure recovery.
* [`scripts`](scripts) Contains common scripts used for running experiments and for AWS management.


## Getting Started (Estimated time: 15 mins)

We provide a quick start guide to run a simple hello world example. Detailed instructions on how to run this on the AWS setup are provided [here](hello_world) (This is the same setup that will be used later for reproducing the paper results. We recommend that reviewers try this out in order to gain familiarity with the setup). Alternatively, one can also build Shortstack from source and run it locally on a single node for this simple example. Instructions on how to do so are provided in the main Shortstack repository [here](https://github.com/pancake-security/shortstack.git)

## Reproducing Results

### Experiments

Experiments described in the paper can be run using the scripts provided in this repository.

The repository is structured based on the Evaluation section in the paper. The following table summarizes different experiments in the paper and the directory containing the respective experiment scripts. The READMEs in the respective experiment directories provide detailed instructions to how to run each experiment.

| Experiment Name / Section / Paragraph | Related Figures |	Experiment Directory | Estimated time |
| :-------------- | :--------------- | :----------------- | :------------------ |
| Throughput scalability analysis (S6.1 para 1)   |     	Figure 11, 13b  |      	[exp1](exp1)   | 30mins |      
|  Understanding scalability bottlenecks (S6.1 para 2) |  	Figure 12   |     [exp2](exp2)  |   45mins    |
|   Sensitivity to skew in workload (S6.1 para 3)       | 	Figure 13a   |     [exp3](exp3)   |  20mins     | 
| Failure recovery (S6.2) |	Figure 14 |       	[exp4](exp4)   |  45mins   | 










