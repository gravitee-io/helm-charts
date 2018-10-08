# create ingress namespace resource
kubectl create -f namespace.yaml

## Now start deploying resources
# create nginx-ingress service account
kubectl create -f nginx-ingress-service-account.yaml

# create default backend resource to handle 404 and health status
kubectl create -f default-backend.yaml

# deploy ingress controller
kubectl create -f nginx-ingress-controller.yaml

# deploy ingress service of type LoadBalancer
kubectl create -f nginx-controller-service.yaml

# after a little while, if you get all the services, you will see that this service will have an External IP:
kubectl get svc --namespace=ingress-nginx

# patch nginx controller
kubectl apply -f nginx-contoller-patch.yaml

# at this point, our nginx ingress controller should be ready. Verify by typing this:
kubectl get pods --all-namespaces -l app=ingress-nginx

# It will take a while to take effect. After some time if you attach to the Nginx Ingress Controller pod, you can verify that Nginx configuration was updated:
sleep 30

kubectl get pods --namespace=ingress-nginx

sleep 30