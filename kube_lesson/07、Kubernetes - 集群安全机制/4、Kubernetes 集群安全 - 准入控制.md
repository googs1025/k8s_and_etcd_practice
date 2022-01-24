---
typora-root-url: Png
---

## 准入控制

**准入控制是API Server的插件集合，通过添加不同的插件，实现额外的准入控制规则。甚至于API Server的一些主要的功能都需要通过 Admission Controllers 实现，比如 ServiceAccount**

**官方文档上有一份针对不同版本的准入控制器推荐列表，其中最新的 1.14  的推荐列表是：** 

```shell
NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,DefaultTolerationSeconds,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,ResourceQuota
```

**列举几个插件的功能：**

- **NamespaceLifecycle： 防止在不存在的 namespace 上创建对象，防止删除系统预置 namespace，删除 namespace 时，连带删除它的所有资源对象。**
- **LimitRanger：确保请求的资源不会超过资源所在 Namespace 的 LimitRange 的限制。**
- **ServiceAccount： 实现了自动化添加 ServiceAccount。**
- **ResourceQuota：确保请求的资源不会超过资源的 ResourceQuota 限制。**