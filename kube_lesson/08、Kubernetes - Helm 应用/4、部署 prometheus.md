---
typora-root-url: Png
---

[TOC]

## Operator 是何物

Kubernetes Operator 是一种封装、部署和管理 Kubernetes 应用的方法。我们使用 Kubernetes API（应用编程接口）和 kubectl 工具在 Kubernetes 上部署并管理 Kubernetes 应用





## 相关地址信息 

Prometheus  github 地址：https://github.com/coreos/kube-prometheus



**组件说明**

***1.MetricServer：是 kubernetes 集群资源使用情况的聚合器，收集数据给 kubernetes 集群内使用，如kubectl,hpa,scheduler等***
***2.PrometheusOperator：是一个系统监测和警报工具箱，用来存储监控数据***
***3.NodeExporter：用于各 node 的关键度量指标状态数据***
***4.KubeStateMetrics：收集k ubernetes 集群内资源对象数据，制定告警规则***
***5.Prometheus：采用pull方式收集 apiserver，scheduler，controller-manager，kubelet 组件数据，通过http 协议传输***
***6、Grafana：是可视化数据统计和监控平台***



## 构建记录

```shell
$ git clone https://github.com/coreos/kube-prometheus.git
    cd /root/kube-prometheus/manifests
```

**修改 grafana-service.yaml 文件，使用 nodepode 方式访问 grafana：** 

```yaml
$ vim grafana-service.yaml                           
    apiVersion: v1
    kind: Service
    metadata:
      name: grafana
      namespace: monitoring
    spec:
      type: NodePort      #添加内容
      ports:
      - name: http
        port: 3000
        targetPort: http
        nodePort: 30100   #添加内容
      selector:
        app: grafana
```

**修改 prometheus-service.yaml，改为 nodepode** 	

```yaml
$ vim prometheus-service.yaml              
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        prometheus: k8s
      name: prometheus-k8s
      namespace: monitoring
    spec:
      type: NodePort
      ports:
      - name: web
        port: 9090
        targetPort: web
        nodePort: 30200
      selector:
        app: prometheus
        prometheus: k8s
```

**修改 alertmanager-service.yaml，改为 nodepode** 

```yaml
vim alertmanager-service.yaml 
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        alertmanager: main
      name: alertmanager-main
      namespace: monitoring
    spec:
      type: NodePort
      ports:
      - name: web
        port: 9093
        targetPort: web
        nodePort: 30300
      selector:
        alertmanager: main
        app: alertmanager
```



## Horizontal Pod Autoscaling

**HPA 可以根据 CPU 利用率自动伸缩 RC、Deployment、RS 中的 Pod 数量**

```shell
$ kubectl run php-apache --image=wangyanglinux/hpa:latest --requests=cpu=200m --expose --port=80
```

**创建 HPA 控制器** 

```shell
$ kubectl autoscale deployment php-apache --cpu-percent=50 --min=2 --max=10
```

**增加负载，查看负载节点数目**

```shell
$ kubectl run -i --tty work --image=busybox /bin/sh
	while true; do wget -q -O- http://php-apache.default.svc.cluster.local; done
```



## 资源限制 - Pod

**Kubernetes 对资源的限制实际上是通过 CGROUP 来控制的，CGROUP 是容器的一组用来控制内核如果运行进程的相关属性集合。针对内存、CPU、和各种设备都有对应的 CGROUP**

**默认情况下，Pod 运行没有 CPU 和内存的限额。这意味着系统中任何 Pod 将能够执行该节点所有的运算资源，消耗足够多的 CPU 和内存。一般会针对某些应用的 Pod 资源进行资源限制，这个资源限制是通过 resources 的 requests 和 limits 来实现**

```yaml
spec:
  containers:
  - image: wangyanglinux/myapp:v1
    name: auth
    resources:
      limits:
        cpu: "4"
        memory: 2Gi
      requests:
        cpu: 250m
        memory: 250Mi
```

**requests 要分配的资源，limits 为最高请求的资源，可以理解为初始值和最大值**



## 资源限制 - 名称空间

##### **一、计算资源配额**

```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: compute-resources
  namespace: spark-cluster
spec:
  hard:
    requests.cpu: "20"
    requests.memory: 100Gi
    limits.cpu: "40"
    limits.memory: 200Gi
```

##### 二、配置对象数量配额限制

```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: object-counts
  namespace: spark-cluster
spec:
  hard:
    pods: "20"
    configmaps: "10"
    persistentvolumeclaims: "4"
    replicationcontrollers: "20"
    secrets: "10"
    services: "10"
    services.loadbalancers: "2"
```

##### 三、配置 CPU 和 内存 limitrange

```yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: mem-limit-range
  namespace: example
spec:
  limits:
  - default:  # 默认限制值
      memory: 512Mi
      cpu: 2
    defaultRequest:  # 默认请求值
      memory: 256Mi
      cpu: 0.5
    max:  # 最大的资源限制
      memory: 800Mi
      cpu: 3
    min:  # 最小限制
      memory: 100Mi
      cpu: 0.3
    maxLimitRequestRatio:  # 超售值
      memory: 2
      cpu: 2
    type: Container # Container / Pod / PersistentVolumeClaim
```





