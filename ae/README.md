# Gravitee.io Alert Engine Helm Chart

**Chart supported versions: 1.0.x and higher**

## Components

This chart will deploy the following:

- Gravitee.io Alert Engine

## Installing

* Add the Gravitee.io helm charts repo
  ```
  $ helm repo add graviteeio https://helm.gravitee.io
  ```
* Install it
  ```
  $ helm install --name graviteeio-ae graviteeio/ae
  ```

## Create a chart archive

To package this chart directory into a chart archive, run:

```
$ helm package .
```

## Installing the Chart

To install the chart from the Helm repository with the release name `graviteeio-ae`:

```bash
$ helm install --name graviteeio-ae graviteeio/ae
```

To install the chart using the chart archive, run:

```
$ helm install ae-1.0.0.tgz
```

## Configuration

The following tables list the configurable parameters of the Gravitee.io Alert Engine chart and their default values.

### Shared configuration

To configure common features such as:

- chaos testing (see
  [chaoskube](https://github.com/kubernetes/charts/tree/master/stable/chaoskube)
  chart)

| Parameter              | Description        | Default |
| ---------------------- | ------------------ | ------- |
| `chaos.enabled`        | Enable Chaos test  | false   |

### Gravitee Alert Engine

| Parameter                                      | Description                                                                                                                                                                       | Default                                                                                                                                                                                                                     |
| ---------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `engine.name`                                 | Engine service name                                                                                                                                                              | `engine`                                                                                                                                                                                                                   |
| `engine.logging.debug`                        | Whether to enable engine debug logging or not                                                                                                                                    | `false`                                                                                                                                                                                                                     |
| `gateway.ssl.enabled`                          | API exposition through HTTPS protocol activation                                                                                                                                  | `false`                                                                                                                                                                                                                     |
| `gateway.ssl.keystore.path`                    | Keystore path for API exposition through HTTPS protocol                                                                                                                           | `null`                                                                                                                                                                                                                      |
| `gateway.ssl.keystore.password`                | Keystore password for API exposition through HTTPS protocol                                                                                                                       | `null`                                                                                                                                                                                                                      |
| `gateway.ssl.clientAuth`                       | Client authentication through 2 way TLS activation                                                                                                                                | `false`                                                                                                                                                                                                                     |
| `gateway.ssl.truststore.path`                  | Truststore path for client authentication through 2 way TLS                                                                                                                       | `null`                                                                                                                                                                                                                      |
| `gateway.ssl.truststore.password`              | Truststore password for client authentication through 2 way TLS                                                                                                                   | `null`                                                                                                                                                                                                                      |
| `gateway.logging.graviteeLevel`                | Logging level for Gravitee classes                                                                                                                                                | `DEBUG`                                                                                                                                                                                                                     |
| `gateway.logging.jettyLevel`                   | Logging level for Jetty classes                                                                                                                                                   | `INFO`                                                                                                                                                                                                                      |
| `gateway.logging.stdout.encoderPattern`        | Logback standard output encoder pattern                                                                                                                                           | `%d{HH:mm:ss.SSS} [%thread] [%X{api}] %-5level %logger{36} - %msg%n`                                                                                                                                                        |
| `gateway.logging.file.enabled`                 | Whether to enable file logging or not                                                                                                                                             | `true`                                                                                                                                                                                                                      |
| `gateway.logging.file.rollingPolicy`           | Logback file rolling policy configuration                                                                                                                                         | `TimeBasedRollingPolicy` for 30 days                                                                                                                                                                                        |
| `gateway.logging.file.encoderPattern`          | Logback file encoder pattern                                                                                                                                                      | `%d{HH:mm:ss.SSS} [%thread] [%X{api}] %-5level %logger{36} - %msg%n`                                                                                                                                                        |
| `gateway.type`                                 | Gateway deployment type: `deployment` or `statefulSet`                                                                                                                            | `deployment`                                                                                                                                                                                                                |
| `gateway.replicaCount`                         | How many replicas of the Gateway pod                                                                                                                                              | `2`                                                                                                                                                                                                                         |
| `gateway.image.repository`                     | Gravitee Gateway image repository                                                                                                                                                 | `graviteeio/gateway`                                                                                                                                                                                                        |
| `gateway.image.tag`                            | Gravitee Gateway image tag                                                                                                                                                        | `1.29.5`                                                                                                                                                                                                                    |
| `gateway.image.pullPolicy`                     | K8s image pull policy                                                                                                                                                             | `Always`                                                                                                                                                                                                                    |
| `gateway.image.pullSecrets`                    | K8s image pull secrets, used to pull both Gravitee Gateway image and `extraInitContainers`                                                                                        | `null`                                                                                                                                                                                                                      |
| `gateway.service.type`                         | K8s publishing [service type](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types)                                                 | `ClusterIP`                                                                                                                                                                                                                 |
| `gateway.service.externalPort`                 | K8s Gateway service external port                                                                                                                                                 | `82`                                                                                                                                                                                                                        |
| `gateway.service.internalPort`                 | K8s Gateway service internal port (container)                                                                                                                                     | `8082`                                                                                                                                                                                                                      |
| `gateway.autoscaling.enabled`                  | Whether auto-scaling is enabled or not                                                                                                                                            | `true`                                                                                                                                                                                                                      |
| `gateway.autoscaling.minReplicas`              | If `gateway.autoscaling.enabled` is `true`, what's the minimum number of replicas                                                                                                 | `2`                                                                                                                                                                                                                         |
| `gateway.autoscaling.maxReplicas`              | If `gateway.autoscaling.enabled` is `true`, what's the maximum number of replicas                                                                                                 | `3`                                                                                                                                                                                                                         |
| `gateway.autoscaling.targetAverageUtilization` | If `gateway.autoscaling.enabled` what's the average target utilization (in %) before it auto-scale                                                                                | `50`                                                                                                                                                                                                                        |
| `gateway.websocket`                            | Whether websocket protocol is enabled or not                                                                                                                                      | `false`                                                                                                                                                                                                                     |
| `gateway.sharding_tags`                        | Sharding tags (comma separated list)                                                                                                                                              | ``                                                                                                                                                                                                                          |
| `gateway.ingress.enabled`                      | Whether Ingress is enabled or not                                                                                                                                                 | `true`                                                                                                                                                                                                                      |
| `gateway.ingress.path`                         | The ingress path which should match for incoming requests to the gateway.                                                                                                         | `/gateway`                                                                                                                                                                                                                  |
| `gateway.ingress.hosts`                        | If `gateway.ingress.enabled` is enabled, set possible ingress hosts                                                                                                               | `[apim.example.com]`                                                                                                                                                                                                        |
| `gateway.ingress.annotations`                  | Supported Ingress annotations to configure ingress controller                                                                                                                     | `[kubernetes.io/ingress.class: nginx, nginx.ingress.kubernetes.io/ssl-redirect: "false", nginx.ingress.kubernetes.io/enable-rewrite-log: "true", kubernetes.io/app-root: /gateway, kubernetes.io/rewrite-target: /gateway]` |
| `gateway.ingress.tls.hosts`                    | [Ingress TLS termination](https://kubernetes.io/docs/concepts/services-networking/ingress/#tls)                                                                                   | `[apim.example.com]`                                                                                                                                                                                                        |
| `gateway.ingress.tls.secretName`               | Ingress TLS K8s secret name containing the TLS private key and certificate                                                                                                        | `api-custom-cert`                                                                                                                                                                                                           |
| `gateway.resources.limits.cpu`                 | K8s pod deployment [limits definition for CPU](https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/)                                                     | `500m`                                                                                                                                                                                                                      |
| `gateway.resources.limits.memory`              | K8s pod deployment limits definition for memory                                                                                                                                   | `512Mi`                                                                                                                                                                                                                     |
| `gateway.resources.requests.cpu`               | K8s pod deployment [requests definition for CPU](https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/#specify-a-cpu-request-and-a-cpu-limit)             | `200m`                                                                                                                                                                                                                      |
| `gateway.resources.requests.memory`            | K8s pod deployment requests definition for memory                                                                                                                                 | `256Mi`                                                                                                                                                                                                                     |
| `gateway.lifecycle.postStart`                  | K8s pod deployment [postStart](https://kubernetes.io/docs/tasks/configure-pod-container/attach-handler-lifecycle-event/#define-poststart-and-prestop-handlers) command definition | `null`                                                                                                                                                                                                                      |
| `gateway.lifecycle.preStop`                    | K8s pod deployment [preStop](https://kubernetes.io/docs/tasks/configure-pod-container/attach-handler-lifecycle-event/#define-poststart-and-prestop-handlers) command definition   | `null`                                                                                                                                                                                                                      |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml gravitee
```

> **Tip**: You can use the default [values.yaml](values.yaml)