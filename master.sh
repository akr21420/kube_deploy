#!/bin/bash
WORKERS=("$WORKER_1" "$WORKER_2")
#on master run init and save the output in a .txt
kubeadm init | tee -a out.txt #save join output to a text file
export KUBECONFIG=/etc/kubernetes/admin.conf #run kubernetes as root
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml #deploy weave
sleep 15

grep "kubeadm" ./out.txt | grep "join" | tee -a ./join_command.sh #get join command from kubeadm init command run earlier
chmod 777 ./join_command.sh

for node in "${WORKERS[@]}"
do
sshpass -p "Cohe\$1ty" scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null join_command.sh  root@$node:/root
sleep 5
sshpass -p "Cohe\$1ty" ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@$node 'bash /root/join_command.sh'
sleep 30
done
