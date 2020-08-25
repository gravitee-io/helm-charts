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
| `engine.logging.debug`                        | Whether to enable engine debug logging or not                                                                                                                                    | `false`                                                                                                                                                                                               


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml gravitee
```

> **Tip**: You can use the default [values.yaml](values.yaml)