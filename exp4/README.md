# Failure recovery experiment

<Login to gateway VM, generate hosts file, copy to client VM>

<SSH into client VM, pull latest updates>

Push binaries

```
./scripts/push_bins.sh
```

Run L1 failure experiment

```
cd exp4
./run_faill1.sh exp4-ycsb-a /local/workloads/ycsb-a-1m
```

Collect results

```
/collect_exp4.sh exp4-ycsb-a-faill1
```

Plot graph

```
./plot.sh exp4-ycsb-a-faill1
```


