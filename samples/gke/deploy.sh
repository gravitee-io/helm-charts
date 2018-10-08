# set default zone/region for the cluster
gcloud config set compute/zone us-central1-a

# then set your default project ID
gcloud config set project my-gcp-project

# create cluster
gcloud beta container --project "my-gcp-project" clusters create "api-manager" --zone "us-central1-a" --username "admin" --cluster-version "1.9.7-gke.6" --machine-type "n1-standard-4" --image-type "COS" --disk-type "pd-standard" --disk-size "100" --scopes "https://www.googleapis.com/auth/compute","https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --num-nodes "1" --enable-cloud-logging --enable-cloud-monitoring --network "projects/my-gcp-project/global/networks/default" --subnetwork "projects/my-gcp-project/regions/us-central1/subnetworks/default" --enable-autoscaling --min-nodes "1" --max-nodes "3" --addons HorizontalPodAutoscaling,HttpLoadBalancing,KubernetesDashboard --no-enable-autoupgrade --enable-autorepair

# get cluster credentials and authenticate gcloud cli (sdk)
gcloud container clusters get-credentials api-manager --zone us-central1-a --project my-gcp-project

# create Helm service account
kubectl apply -f create-helm-service-account.yaml

# initialize helm in our new cluster using the helm service account
helm/helm init --service-account helm

# check Helm is running properly. There should be at least a deployment and a service 
# with name tiller-deploy in kube-system namespace.
kubectl get deploy,svc tiller-deploy -n kube-system

sleep 90

############################ Install MongoDB ###############################
# use official chart: https://github.com/helm/charts/tree/master/stable/mongodb-replicaset
helm/helm repo add stable https://kubernetes-charts.storage.googleapis.com/

# get the default values file and run:
helm/helm install --name mongo stable/mongodb-replicaset -f mongo-values.yaml

# NOTES:
# 1. After the statefulset is created completely, one can check which instance is primary by running:

#     $ for ((i = 0; i < 3; ++i)); do kubectl exec --namespace default mongo-mongodb-replicaset-$i -- sh -c 'mongo --eval="printjson(rs.isMaster())"'; done

# 2. One can insert a key into the primary instance of the mongodb replica set by running the following:
#     MASTER_POD_NAME must be replaced with the name of the master found from the previous step.

#     $ kubectl exec --namespace default MASTER_POD_NAME -- mongo --eval="printjson(db.test.insert({key1: 'value1'}))"

# 3. One can fetch the keys stored in the primary or any of the slave nodes in the following manner.
#     POD_NAME must be replaced by the name of the pod being queried.

#     $ kubectl exec --namespace default POD_NAME -- mongo --eval="rs.slaveOk(); db.test.find().forEach(printjson)"



############################ Install Elasticsearch ##########################
# use official chart: https://github.com/helm/charts/tree/master/incubator/elasticsearch
helm/helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator

# get the default values file and then run:
helm/helm install --name elastic incubator/elasticsearch -f elastic-values.yaml

sleep 300

# Elasticsearch can be accessed:

#   * Within your cluster, at the following DNS name at port 9200:

#     elastic-elasticsearch-client.default.svc.cluster.local

#   * From outside the cluster, run these commands in the same shell:

#     export POD_NAME=$(kubectl get pods --namespace default -l "app=elasticsearch,component=client,release=elastic" -o jsonpath="{.items[0].metadata.name}")
#     echo "Visit http://127.0.0.1:9200 to use Elasticsearch"
#     kubectl port-forward --namespace default $POD_NAME 9200:9200




############################ Install Certs to be used by Gravitee ingress services ################################
# ## Create custom cert
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout api-custom-cert.key -out api-custom-cert.crt -subj "/CN=apim.example.com/O=apim.example.com"

# # create tls secret with the custom cert
kubectl create secret tls api-custom-cert --key api-custom-cert.key --cert api-custom-cert.crt

############################ Install Ingress Controller ################################

cd nginx-kubernetes-ingress-controller

# deploy ingress controller
sh deploy.sh

# return to Gravite API helm folder
cd ..

############################ Install Gravitee ################################

# create a chart archive package
helm/helm package gravitee

# # install the chart using the chart archive
helm/helm install --name gravitee-apim -f gravitee/values.yaml gravitee-*.tgz

# to upgrade with helm
#helm/helm upgrade gravitee-apim -f gravitee/values.yaml gravitee-*.tgz

# to check the revision history
#helm/helm history gravitee-apim

# to rollback to a specific revision
#helm/helm rollback gravitee-apim 1

# to delete a release,
#helm/helm delete gravitee-apim && helm/helm del --purge gravitee-apim
