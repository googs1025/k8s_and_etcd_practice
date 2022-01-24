---
typora-root-url: Png
---

## 机制说明

**Kubernetes 作为一个分布式集群的管理工具，保证集群的安全性是其一个重要的任务。API Server 是集群内部各个组件通信的中介，也是外部控制的入口。所以 Kubernetes 的安全机制基本就是围绕保护 API Server 来设计的。Kubernetes 使用了认证（Authentication）、鉴权（Authorization）、准入控制（Admission Control）三步来保证API Server的安全**

[![](https://s4.ax1x.com/2022/01/05/TjGNE8.jpg)]()


