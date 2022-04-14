# Throughput Scalability Experiment

<Login to gateway VM, generate hosts file, copy to client VM>

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



