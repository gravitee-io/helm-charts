# Gravitee.io Alert Engine Helm Chart

**Chart supported versions: 1.0.x and higher**

## Components

This chart will deploy the following:

- Gravitee.io Alert Engine

## Kubernetes API

AE embeds Hazelcast to propagate and process events between each node. In order to make Hazelcast work best when embedded and deployed under a Kubernetes cluster, we pre-configured the auto-discovery to work with the Kubernetes API.

> Kubernetes API mode means that each node makes a REST call to Kubernetes Master in order to discover IPs of PODs (with Hazelcast members).

In order to make it work, you need to grant access to the Kubernetes API.

```
$ kubectl apply -f https://raw.githubusercontent.com/gravitee-io/helm-charts/master/ae/rbac.yml
```

If you want to let Helm to create the Service Account with required cluster role while installating the Chart, use `--set engine.managedServiceAccount=true`

Please note that `managedServiceAccount` is enabled by default and so, you'll have to switch it off if you want to manage the Service Account by yourself.

---
**WARNING**

rbac.yml comes with default `graviteeio` namespace. Make sure to use the right namespace if you have overridden it.

---

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

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| engine.authentication.adminPassword | string | `"adminadmin"` |  |
| engine.authentication.enabled | bool | `true` |  |
| engine.autoscaling.enabled | bool | `true` |  |
| engine.autoscaling.maxReplicas | int | `3` |  |
| engine.autoscaling.minReplicas | int | `1` |  |
| engine.autoscaling.targetAverageUtilization | int | `50` |  |
| engine.autoscaling.targetMemoryAverageUtilization | int | `80` |  |
| engine.enabled | bool | `true` |  |
| engine.image.pullPolicy | string | `"Always"` |  |
| engine.image.repository | string | `"graviteeio/ae-engine"` |  |
| engine.ingress.annotations."kubernetes.io/app-root" | string | `"/"` |  |
| engine.ingress.annotations."kubernetes.io/ingress.class" | string | `"nginx"` |  |
| engine.ingress.annotations."kubernetes.io/rewrite-target" | string | `"/"` |  |
| engine.ingress.annotations."nginx.ingress.kubernetes.io/enable-rewrite-log" | string | `"true"` |  |
| engine.ingress.annotations."nginx.ingress.kubernetes.io/ssl-redirect" | string | `"false"` |  |
| engine.ingress.enabled | bool | `true` |  |
| engine.ingress.hosts[0] | string | `"ae.example.com"` |  |
| engine.ingress.path | string | `"/"` |  |
| engine.ingress.tls[0].hosts[0] | string | `"ae.example.com"` |  |
| engine.ingress.tls[0].secretName | string | `"api-custom-cert"` |  |
| engine.logging.debug | bool | `false` |  |
| engine.logging.file.enabled | bool | `true` |  |
| engine.logging.file.encoderPattern | string | `"%d{HH:mm:ss.SSS} [%thread] [%X{api}] %-5level %logger{36} - %msg%n"` |  |
| engine.logging.file.rollingPolicy | string | `"\u003crollingPolicy class=\"ch.qos.logback.core.rolling.TimeBasedRollingPolicy\"\u003e\n    \u003c!-- daily rollover --\u003e\n    \u003cfileNamePattern\u003e${gravitee.home}/logs/gravitee_%d{yyyy-MM-dd}.log\u003c/fileNamePattern\u003e\n    \u003c!-- keep 30 days' worth of history --\u003e\n    \u003cmaxHistory\u003e30\u003c/maxHistory\u003e\n\u003c/rollingPolicy\u003e\n"` |  |
| engine.logging.graviteeLevel | string | `"DEBUG"` |  |
| engine.logging.stdout.encoderPattern | string | `"%d{HH:mm:ss.SSS} [%thread] [%X{api}] %-5level %logger{36} - %msg%n"` |  |
| engine.name | string | `"engine"` |  |
| engine.reloadOnConfigChange | bool | `true` |  |
| engine.replicaCount | int | `1` |  |
| engine.resources.limits.cpu | string | `"500m"` |  |
| engine.resources.limits.memory | string | `"512Mi"` |  |
| engine.resources.requests.cpu | string | `"200m"` |  |
| engine.resources.requests.memory | string | `"256Mi"` |  |
| engine.service.externalPort | int | `82` |  |
| engine.service.internalPort | int | `8072` |  |
| engine.service.internalPortName | string | `"http"` |  |
| engine.service.type | string | `"ClusterIP"` |  |
| engine.ssl.clientAuth | bool | `false` |  |
| engine.ssl.enabled | bool | `false` |  |
| engine.type | string | `"Deployment"` |  |                                                           


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml gravitee
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Run unit tests

Install `unittest` helm plugin

```shell
helm plugin install https://github.com/quintush/helm-unittest
```

Inside `ae` directory, run:

```shell
helm unittest -3 -f 'tests/*.yaml' .
```
