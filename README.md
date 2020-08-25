# Gravitee.io Stack Kubernetes Helm Charts

This project includes helm charts developed to deploy Gravitee.io components

The repository includes the following charts:
- Gravitee.io API Management
- Gravitee.io Access Management (in development)
- Gravitee.io Alert Engine 

**Note:** These charts are only compatible with Kubernetes < 1.16. For latest versions of k8s, please check that issue: https://github.com/gravitee-io/issues/issues/2835 and the associated Pull Request: https://github.com/gravitee-io/helm-charts/pull/30


## Charts

Please look in the chart directories for the documentation for each chart. These helm charts are designed to be a lightweight way to configure our official docker images

| Chart                                      | Docker documentation                                                            |
| ------------------------------------------ | ------------------------------------------------------------------------------- |
| [API Management 1.x](./apim/1.x/README.md)         | https://docs.gravitee.io/apim/1.x/apim_installguide_kubernetes.html         |
| [API Management 3.x](./apim/3.x/README.md)         | https://docs.gravitee.io/apim/1.x/apim_installguide_kubernetes.html         |
| [Access Management 2.x](./am/README.md)        | https://docs.gravitee.io/am/2.x/apim_installguide_kubernetes.html           |
| [Access Management 3.x](./am/README.md)        | https://docs.gravitee.io/am/current/apim_installguide_kubernetes.html       |
| [Alert Engine](./ae/README.md)             | https://docs.gravitee.io/ae/installguide_docker.html                            |
