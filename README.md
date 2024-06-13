# terraform-libvirt
通过 terraform 创建 kvm 相关资源

#  版本
terraform 版本： 1.8.0

provider dmacvicar/libvirt版本： 0.7.6

## linux 环境变量
```bash
cat > $HOME/.terraformrc <<EOF
plugin_cache_dir   = "$HOME/.terraform.d/plugin-cache"
disable_checkpoint = true
EOF
```

## provider 缓存
terraform-provider-libvirt
```bash
## 版本 https://github.com/dmacvicar/terraform-provider-libvirt/releases/download/v0.7.6/terraform-provider-libvirt_0.7.6_linux_amd64.zip​
VERSION=0.7.6​
PROVIDER_DIR="$HOME/.terraform.d/plugins/local/dmacvicar/libvirt/${VERSION}/linux_amd64"​
wget https://github.com/dmacvicar/terraform-provider-libvirt/releases/download/v${VERSION}/terraform-provider-libvirt_${VERSION}_linux_amd64.zip​
mkdir -p ${PROVIDER_DIR}​
unzip terraform-provider-libvirt_${VERSION}_linux_amd64.zip -d ${PROVIDER_DIR}
```
terraform-provider-external
```bash
## https://releases.hashicorp.com/terraform-provider-external/2.3.3/terraform-provider-external_2.3.3_linux_amd64.zip
VERSION=2.3.3
PROVIDER_DIR="$HOME/.terraform.d/plugins/local/hashicorp/external/${VERSION}/linux_amd64"
wget https://releases.hashicorp.com/terraform-provider-external/${VERSION}/terraform-provider-external_${VERSION}_linux_amd64.zip
mkdir -p ${PROVIDER_DIR}
unzip terraform-provider-external_${VERSION}_linux_amd64.zip -d ${PROVIDER_DIR}
```
## 结构
- `providers.tf` - 定义了Terraform的provider信息。
- `backend.tf` - 包含了状态管理 Backend 远程存储。
- `variables.tf` - 包含了项目使用到的所有变量。
- `main.tf` - 包含了资源的主要配置。 
- `outputs.tf` - 定义了需要输出的信息
- `source.sh` - 设置环境变量
- `get_vm_ip.sh` - 获取创建虚机的ip地址

# terrafbacbacbacbacbackerform 配置
## 环境变量
```bash
source.sh 
#!/bin/bash
# 设置 libvirt provider 的 URI，其他主机 "qemu+ssh://root@<IP>/system"
export TF_VAR_libvirt_uri="qemu:///system"

# 设置 libvirt volume 的变量
export TF_VAR_libvirt_volume='{
  name   = "my-vm.qcow2"
  source = "/data/images/linux_centos_7.9_x86_64_2009_vmm20230621.qcow2"
  format = "qcow2"
}'

# 设置 libvirt domain 的变量
export TF_VAR_libvirt_domain='{
  name   = "my-vm"
  memory = 2048
  vcpu   = 2
  type   = "kvm"
}'
```
```
source ./source.sh
```

## 执行terraform
```bash
terraform init
terraform plan
terraform apply
```
## 销毁资源
（不会删除网络和存储池资源）：
```bash
terraform destroy -target=libvirt_domain.kvm_domain -target=libvirt_volume.kvm_volume -target=external.vm_ipd.tf
```
