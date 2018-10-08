# Deploy Gravitee APIM on GKE (Google Kubernetes Engine) using Helm

## Prerequisites

* [GCP account](https://cloud.google.com/)
* [A GCP service-account with cluster-admin role](https://cloud.google.com/iam/docs/creating-managing-service-account-keys)
* Access key in JSON format

Instructions below assume the environment where you cloned this repository will have:

* [GCloud SDK](https://cloud.google.com/sdk/) to run gcloud and kubectl CLIs
* [OpenSSL](https://www.openssl.org/) to generate a self-signed certificate for our [Ingress Controller](https://kubernetes.io/docs/concepts/services-networking/ingress/)

This Sample repository will deploy all the major pieces you will need. If you already have some of the pieces listed below, please, edit [deploy.sh](./deploy.sh) and comment out the respective command.

### Major pieces deployed at the end
* [GKE Cluster](https://cloud.google.com/kubernetes-engine/docs/concepts/cluster-architecture)
* [Helm and Tiller](https://helm.sh/)
* [A Nginx Ingress Controller to route and expose cluster's services](http://rahmonov.me/posts/nginx-ingress-controller/)
* [A dynamically scalable MongoDB replica set using Kubernetes StatefulSets and Init Containers](https://github.com/helm/charts/tree/master/stable/mongodb-replicaset)
* [A dynamically scalable elasticsearch cluster using Kubernetes StatefulSets/Deployments](https://github.com/helm/charts/tree/master/incubator/elasticsearch)
* [Gravitee API Management](https://gravitee.io/) with its 3 main components
    * [Gateway](https://docs.gravitee.io/apim_installguide_gateway_configuration.html)
    * [Management API](https://docs.gravitee.io/apim_installguide_management_api_configuration.html)
    * [Portal (UI)](https://docs.gravitee.io/apim_installguide_portal_configuration.html)

Documentation is WIP...

Documentation TODO:
* How to authenticate on cloud sdk (cli) with cluster's credentials
* How to create a GCP service account
* ...