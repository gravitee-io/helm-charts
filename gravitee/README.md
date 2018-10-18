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
$ helm install gravitee-0.0.2.tgz
```


To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release gravitee
```

## Configuration

The following tables list the configurable parameters of the Gravitee chart and their default values.


### Shared configuration

To configure common functionalities such as:
- authorisation
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
| `oauth.enabled`            | Enable oauth login       | false            |

### Gravitee UI

| Parameter                  | Description              | Default          |
| -------------------------- | -------------------------| -----------------|
| `ui.name`                  | UI service name          | `ui`             |

### Gravitee API

| Parameter             | Description       | Default   |
|-----------------------|-------------------|-----------|
| `api.name`            | API service name  | `api`     |

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
