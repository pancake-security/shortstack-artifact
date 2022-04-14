# Sensitivity to Skew Experiment

<Login to gateway VM, generate hosts file, copy to client VM>

<SSH into client VM, pull latest updates>

Push binaries

```
./scripts/push_bins.sh
```

Run  experiment

```
cd exp3
./run_exp3.sh exp3-ycsb-a /local/workloads/ycsb-a-1m
```

Collect and print results

```
./collect_exp3.sh exp3-ycsb-a
```



