#!/bin/bash

cd /root/prometheus

ls /root/prometheus | grep -v load-images.sh > /tmp/k8s-images.txt

for i in $( cat  /tmp/k8s-images.txt )
do
    docker load -i $i
done

rm -rf /tmp/k8s-images.txt
