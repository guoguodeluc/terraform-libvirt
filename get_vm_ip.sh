#!/bin/bash

VM_NAME=$1

## 循环查询虚拟机 IP 地址，直到获取到有效的非本地 IP 地址
while true; do
  IP=$(virsh domifaddr "$VM_NAME" --source agent | grep "ipv4" | awk '{print $4}' | cut -d'/' -f1 | grep -v '127.0.0.1')
  if [ -n "$IP" ]; then
    echo "{\"ip\": \"$IP\"}"
    break
  fi
  sleep 5
done
