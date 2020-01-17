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
| [API Management](./apim/README.md)         | https://docs.gravitee.io/apim_installguide_kubernetes.html                      |
| [Access Management](./am/README.md)        | https://docs.gravitee.io/am/2.x/am_installguide_docker.html                     |
| [Alert Engine](./ae/README.md)             | https://docs.gravitee.io/ae/installguide_docker.html                            |