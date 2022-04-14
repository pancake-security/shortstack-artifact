# Understanding Scalability Bottlenecks Experiment

<Login to gateway VM, generate hosts file, copy to client VM>

<SSH into client VM, pull latest updates>

Push binaries

```
./scripts/push_bins.sh
```

Run varying L1 servers experiment

```
cd exp2
./run_exp2_varyl1.sh exp2-ycsb-a /local/workloads/ycsb-a-1m
```

Collect and print results

```
./collect_exp2.sh exp2-ycsb-a-varyl1
```

Run varying L2 servers experiment

```
./run_exp2_varyl2.sh exp2-ycsb-a /local/workloads/ycsb-a-1m
```

Collect and print results

```
./collect_exp2.sh exp2-ycsb-a-varyl2
```

Run varying L3 servers experiment

```
./run_exp2_varyl3.sh exp2-ycsb-a /local/workloads/ycsb-a-1m
```

Collect and print results

```
./collect_exp2.sh exp2-ycsb-a-varyl3
```



