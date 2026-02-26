# Gravitee.io Stack Kubernetes Helm Charts

This project includes helm charts developed to deploy Gravitee.io components

The repository includes the following charts:

- ~~Gravitee.io API Management~~ 🆕 They have moved to [APIM repository](https://github.com/gravitee-io/gravitee-api-management)
- Gravitee.io Access Management
- ~~Gravitee.io Alert Engine~~ 🆕 Moved to [AE repository](https://github.com/gravitee-io/gravitee-alert-engine)

**Note:** These charts are only compatible with Kubernetes >= 1.9

## Charts

Please look in the chart directories for the documentation for each chart. These helm charts are designed to be a lightweight way to configure our official docker images

| Chart                                                                                                                     | Docker documentation                                                |
| ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| APIM Helm Charts were moved in [APIM repository](https://github.com/gravitee-io/gravitee-api-management/tree/master/helm) | https://docs.gravitee.io/apim/3.x/apim_installguide_kubernetes.html |
| [Access Management 2.x](./am/README.md)                                                                                   | https://docs.gravitee.io/am/2.x/am_installguide_kubernetes.html     |
| [Access Management 3.x](./am/README.md)                                                                                   | https://docs.gravitee.io/am/current/am_installguide_kubernetes.html |
| AE Helm Chart was moved to [AE repository](https://github.com/gravitee-io/gravitee-alert-engine/tree/master/helm)          | https://documentation.gravitee.io/alert-engine/getting-started/install-and-upgrade-guides/install-via-kubernetes |
