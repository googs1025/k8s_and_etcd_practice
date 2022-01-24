## 使用Helm部署 dashboard

**kubernetes-dashboard.yaml：** 

```yaml
image:
  repository: k8s.gcr.io/kubernetes-dashboard-amd64
  tag: v1.10.1
ingress:
  enabled: true
  hosts: 
    - k8s.frognew.com
  annotations:
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
  tls:
    - secretName: frognew-com-tls-secret
      hosts:
      - k8s.frognew.com
rbac:
  clusterAdminRole: true
```

```shell
$ helm install stable/kubernetes-dashboard \
-n kubernetes-dashboard \
--namespace kube-system  \
-f kubernetes-dashboard.yaml
```

```shell 
$ kubectl -n kube-system get secret | grep kubernetes-dashboard-token                 kubernetes.io/service-account-token   3      3m7s 

$ kubectl describe -n kube-system secret/kubernetes-dashboard-token-pkm2s
```

```shell
$ kubectl  edit svc kubernetes-dashboard -n kube-system
	修改 ClusterIP 为 NodePort
```