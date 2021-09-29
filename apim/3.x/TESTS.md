## How to run tests

First install `unittest` helm plugin 

```
$ helm plugin install https://github.com/quintush/helm-unittest
```

From `apim3` directory, run :

```
>$ helm unittest -3 -f 'tests/**/*.yaml' .
```