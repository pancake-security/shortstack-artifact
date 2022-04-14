# Hello world example

SSH into Gateway VM

Pull artifact repo latest changes

```
cd shortstack-artifact
git pull origin master
```

Check available VM status

```
cd scripts/aws
./check-instances.sh
```

Generate hosts file

```
./gen-hosts.sh ~/shortstack.hosts
```

Copy hosts file to client VM

```
scp ~/shortstack.hosts ubuntu@client_vm_private_ip:/local/deploy/shortstack.hosts
```

Exit gateway VM

SSH into client VM

Check if `shortstack-artifact` directory exists in home directory. Otherwise clone it with `git clone https://github.com/pancake-security/shortstack-artifact`

Pull latest updates

```
cd shortstack-artifact
git pull origin master
```

Initialize setup

```
cd hello_world
./init_setup.sh traces/helloworld
```

Run client

```
/local/deploy/shortstack_driver -h /local/deploy/hosts.csv -t traces/helloworld
```
