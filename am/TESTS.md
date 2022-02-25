## How to run tests

First, install `unittest` helm plugin 

```shell
helm plugin install https://github.com/quintush/helm-unittest
```

Inside `am` directory, run:

```shell
helm unittest .
```