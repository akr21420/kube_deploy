#!/bin/bash
NODES=("$MASTER_IP" "$WORKER_1" "$WORKER_2")

#prerequisites

for node in "${NODES[@]}"
do
sshpass -p "Cohe\$1ty" scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ./common.sh  root@$node:/root
sleep 5
sshpass -p "Cohe\$1ty" ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@$node 'bash /root/common.sh'
sleep 30
done

#master init and join slaves
sshpass -p "Cohe\$1ty" scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ./master.sh  root@$MASTER_IP:/root
sleep 5
sshpass -p "Cohe\$1ty" ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@$MASTER_IP 'bash /root/master.sh "$WORKER_1" "$WORKER_2"'
sleep 100


kubectl get nodes