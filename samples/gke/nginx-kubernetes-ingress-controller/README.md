# Steps to deploy a Nginx Ingress controller on Kubernetes

Below steps can be executed in one go by running 

```
sh deploy-quality-dev.sh
```


## TLS and certificate settings must be done first

create ingress namespace resource
```
kubectl create -f namespace.yaml
```

## Now start deploying resources

create nginx-ingress service account
```
kubectl create -f nginx-ingress-service-account.yaml
```

create default backend resource to handle 404 and health status
```
kubectl create -f default-backend.yaml
```

deploy ingress controller
```
kubectl create -f nginx-ingress-controller.yaml
```

deploy ingress service of type LoadBalancer
```
kubectl create -f nginx-controller-service.yaml
```

after a little while, if you get all the services, you will see that this service will have an External IP:
```
kubectl get svc --namespace=ingress-nginx
```

patch nginx controller
```
kubectl apply -f nginx-contoller-patch.yaml
```

At this point, our nginx ingress controller should be ready. Verify by typing this:
```
kubectl get pods --all-namespaces -l app=ingress-nginx
```

It will take a while to take effect. After some time if you attach to the Nginx Ingress Controller pod, you can verify that Nginx configuration was updated:
```
kubectl get pods --namespace=ingress-nginx
```

## Conclusion
Everything is ready now. The only thing left is to configure DNS. If you are on a UNIX like machine, you can go open /etc/hosts and append this:

```
104.155.150.97 sub.domain.com
```

Make sure to replace 104.155.150.97 with the IP of your Nginx Ingress Controller's External IP, which you can find by typing this:

```
kubectl get svc --namespace=ingress-nginx
```


---
References: [http://rahmonov.me/posts/nginx-ingress-controller/](http://rahmonov.me/posts/nginx-ingress-controller/)


