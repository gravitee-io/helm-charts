# Gravitee Helm Chart
**Chart supported versions: 1.19.3 and higher**


## Chart Details

This chart will deploy the following:


- Gravitee UI
- Gravitee API
- Gravitee Gateway

## Create a chart archive

To package this chart directory into a chart archive, run:

```
$ helm package .
```

## Installing the Chart

To install the chart using the chart archive, run:

```
$ helm install gravitee-1.22.0.tgz
```


To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release gravitee
```

## Configuration

The following tables list the configurable parameters of the Gravitee chart and their default values.


### Shared configuration

To configure common functionalities such as:
- chaos testing (see
    [chaoskube](https://github.com/kubernetes/charts/tree/master/stable/chaoskube)
    chart)
- configuration database (see
    [mongodb-replicaset](https://github.com/kubernetes/charts/tree/master/stable/mongodb-replicaset)
    chart)
- logs database (see [elastichsearch](https://github.com/kubernetes/charts/tree/master/incubator/elasticsearch)
    chart)

| Parameter                  | Description              | Default          |
| -------------------------- | -------------------------| -----------------|
| `chaos.enabled`            | Enable Chaos test        | false            |
| `inMemoryAuth.enabled`     | Enable oauth login       | true             |

### Mongo

| Parameter                  | Description              | Default          |
| -------------------------- | -------------------------| -----------------|
| `mongo.rs`                 | Mongo replicaset name    | `rs0`            |
| `mongo.rsEnabled`          | Whether Mongo replicaset is enabled or not  | `true`            |
| `mongo.dbhost`             | Mongo host address       | `mongo-mongodb-replicaset`            |
| `mongo.dbport`                 | Mongo host port      | `27017`           |
| `mongo.dbname`                 | Mongo DB name        | `gravitee`        |


### Elasticsearch

| Parameter                  | Description              | Default          |
| -------------------------- | -------------------------| -----------------|
| `es.protocol`              | Elasticsearch protocol    | `http`          |
| `es.cluster`               | Elasticsearch cluster name | `elasticsearch`|
| `es.index`                 | Elasticsearch index | `gravitee`            |
| `es.host`                  | Elasticsearch host    | `elastic-elasticsearch-client.default.svc.cluster.local`          |
| `es.port`                 | Elasticsearch host port | `9200`            |

### Gravitee UI

| Parameter                  | Description              | Default          |
| -------------------------- | -------------------------| -----------------|
| `ui.name`                  | UI service name          | `ui`             |

### Gravitee API

| Parameter             | Description       | Default   |
|-----------------------|-------------------|-----------|
| `api.name`            | API service name  | `api`     |
| `api.debugEnabled`    | Whether to enable API debug or not  | `false`     |
| `api.restartPolicy`            | Policy to [restart K8 pod](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-and-container-status)  | `OnFailure`     |
| `api.updateStrategy.type`            | [K8s deployment strategy type](https://kubernetes.io/zh/docs/concepts/workloads/controllers/deployment/)  | `RollingUpdate`     |
| `api.updateStrategy.rollingUpdate.maxUnavailable`            | If api.updateStrategy.type is set to `RollingUpdate`, make sure to set a value here or your Deployment can have 100% unavailability by default.  The Deployment controller will stop the bad rollout automatically, and will stop scaling up the new ReplicaSet. This depends on the rollingUpdate parameters (maxUnavailable specifically) that you have specified. Kubernetes by default sets the value to 1 and spec.replicas to 1 so if you haven’t cared about setting those parameters, your Deployment can have 100% unavailability by default!   | `1`     |
| `api.replicaCount`            | How many replicas for the API pod  | `1`     |
| `api.image.repository`        | Gravitee API image repository  | `graviteeio/management-api`     |
| `api.image.tag`        | Gravitee API image tag  | `1.22.0`     |
| `api.image.pullPolicy`        | K8s image pull policy  | `Always`     |
| `api.service.type`        | K8s publishing [service type](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types)  | `ClusterIP`     |
| `api.service.externalPort`        | K8s service external port  | `83`     |
| `api.service.internalPort`        | K8s service internal port (container)  | `8083`     |
| `api.autoscaling.enabled`        | Whether auto-scaling is enabled or not  | `true`     |
| `api.autoscaling.minReplicas`        | If `api.autoscaling.enabled` is `true`, what's the minimum number of replicas  | `2`     |
| `api.autoscaling.maxReplicas`        | If `api.autoscaling.enabled` is `true`, what's the maximum number of replicas  | `3`     |
| `api.autoscaling.targetAverageUtilization`        | If `api.autoscaling.enabled` what's the average target utilization (in %) before it auto-scale  | `50`
| `api.ingress.enabled`        | Whether Ingress is enabled or not  | `true`
| `api.ingress.hosts`        | If `api.ingress.enabled` is enabled, set possible ingress hosts  | `[apim.example.com]`
| `api.ingress.annotations`        | Supported Ingress annotations to configure ingress controller | `[kubernetes.io/ingress.class: nginx, ingress.kubernetes.io/configuration-snippet: "etag on;\nproxy_pass_header ETag;\nproxy_set_header if-match \"\";\n"]`
| `api.ingress.tls.hosts`        | [Ingress TLS termination](https://kubernetes.io/docs/concepts/services-networking/ingress/#tls) | `[apim.example.com]`
| `api.ingress.tls.secretName`        | Ingress TLS K8s secret name containing the TLS private key and certificate | `api-custom-cert`
| `api.resources.limits.cpu`        | K8s pod deployment [limits definition for CPU](https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/) | `500m`
| `api.resources.limits.memory`        | K8s pod deployment limits definition for memory | `1024Mi`
| `api.resources.requests.cpu`        | K8s pod deployment [requests definition for CPU](https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/#specify-a-cpu-request-and-a-cpu-limit) | `200m`
| `api.resources.requests.cpu`        | K8s pod deployment [requests definition for CPU](https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/#specify-a-cpu-request-and-a-cpu-limit) | `200m`
| `api.resources.requests.memory`        | K8s pod deployment requests definition for memory | `512Mi`

### Gravitee Gateway

| Parameter                    | Description                      | Default        |
| -----------------------      | ---------------------------------| ---------------|
| `gateway.name`               | Gateway service name             | `gateway`      |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml gravitee
```

> **Tip**: You can use the default [values.yaml](values.yaml)
