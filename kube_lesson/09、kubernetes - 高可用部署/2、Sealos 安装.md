[TOC]

#### Sealos 相关命令

```shell
# 下载并安装 sealos, sealos 是个 golang 的二进制工具，直接下载拷贝到 bin 目录即可, release 页面也可下载
$ wget -c https://sealyun.oss-cn-beijing.aliyuncs.com/latest/sealos && \
    chmod +x sealos && mv sealos /usr/bin

# 下载离线资源包
$ wget -c https://sealyun.oss-cn-beijing.aliyuncs.com/2fb10b1396f8c6674355fcc14a8cda7c-v1.20.0/kube1.20.0.tar.gz

# 安装一个三 master 的 kubernetes 集群
$ sealos init --passwd '123456' \
    --master 192.168.0.2  --master 192.168.0.3  --master 192.168.0.4 \ 
    --node 192.168.0.5 \
    --pkg-url /root/kube1.20.0.tar.gz \
    --version v1.16.0
```



##### 增加 Master 节点

```shell
$ sealos join --master 192.168.0.6 --master 192.168.0.7

# 或者多个连续 IP
$ sealos join --master 192.168.0.6-192.168.0.9  
```



##### 增加 node

```shell
$ sealos join --node 192.168.0.6 --node 192.168.0.7

# 或者多个连续 IP
$ sealos join --node 192.168.0.6-192.168.0.9  
```



##### 删除指定 Master 节点

```shell
$ sealos clean --master 192.168.0.6 --master 192.168.0.7

# 或者多个连续 IP
$ sealos clean --master 192.168.0.6-192.168.0.9  
```



##### 删除指定 node 节点

```shell
$ sealos clean --node 192.168.0.6 --node 192.168.0.7

# 或者多个连续 IP
$ sealos clean --node 192.168.0.6-192.168.0.9  
```



##### 清理集群

```shell
$ sealos clean --all
```



##### 备份集群

```shell
$ sealos etcd save
```



#### 节点状态

##### kube-scheduler 状态查看

```shell
$ kubectl  get endpoints kube-scheduler -n kube-system -o yaml
    NAME             ENDPOINTS   AGE
    kube-scheduler   <none>      12m
    [root@k8s-master01 ~]# kubectl  get endpoints kube-scheduler -n kube-system -o yaml
    apiVersion: v1
    kind: Endpoints
    metadata:
      annotations:
        control-plane.alpha.kubernetes.io/leader: '{"holderIdentity":"k8s-master02_d9af3300-cdad-49ce-838a-2ccdd38fbf18","leaseDurationSeconds":15,"acquireTime":"2021-03-01T07:09:24Z","renewTime":"2021-03-01T07:21:27Z","leaderTransitions":1}'
      creationTimestamp: "2021-03-01T07:08:32Z"
      name: kube-scheduler
      namespace: kube-system
      resourceVersion: "2013"
      selfLink: /api/v1/namespaces/kube-system/endpoints/kube-scheduler
      uid: b34592b6-0fe0-4cdd-9887-4b5fc9e8de97
```



##### kube-controller-manager 状态查看

```shell
$ kubectl  get endpoints kube-controller-manager -n kube-system -o yaml
    apiVersion: v1
    kind: Endpoints
    metadata:
      annotations:
        control-plane.alpha.kubernetes.io/leader: '{"holderIdentity":"k8s-master02_690df468-d680-4231-a8b9-4c8fa452eecf","leaseDurationSeconds":15,"acquireTime":"2021-03-01T07:09:24Z","renewTime":"2021-03-01T07:25:47Z","leaderTransitions":1}'
      creationTimestamp: "2021-03-01T07:08:32Z"
      name: kube-controller-manager
      namespace: kube-system
      resourceVersion: "2440"
      selfLink: /api/v1/namespaces/kube-system/endpoints/kube-controller-manager
      uid: 69f747dd-57d7-4aec-8443-9b3906ee9963
```



