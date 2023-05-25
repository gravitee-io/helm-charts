# Breaking changes


- [3.2.0](#320)
    - [Change Kubernetes default probes configuration](#change-Kubernetes-default-probes-configuration)

## 3.2.0

### Change Kubernetes default probes configuration

Probes configuration is now under `deployment:` node for all the components and all the products
For the Gateway, default probes configuration has been changed (from tcpSocket to httpGet)
As we can now configure custom probes (by using `custom[Startup/Readiness/Liveness]Probe`), we removed `apiSync` parameter under `gateway.readinessProbe`

If you have configured specifics probes overriding `gateway.[startup/liveness/readiness]Probe` and you don't want to use the new defaults, you need to set `gateway.deployment.[startup/liveness/readiness]probe.enabled: false` and report your specific probes configuration in `gateway.deployment.custom[Startup/Readiness/Liveness]Probe`
You can do the same for the `apim`, `gateway`, `portal` and `ui` components.

See the related PRs for more details:
- <https://github.com/gravitee-io/helm-charts/pull/370>