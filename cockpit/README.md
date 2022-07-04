Gravitee.io Cockpit Helm Chart {#graviteeio-cockpit-helm-chart}
==============================

**Chart supported versions: 1.0.x and higher**

Components {#_components}
----------

This chart will deploy the following:

-   Gravitee.io Cockpit

Requirements {#_requirements}
------------

Kubernetes: `>=1.16.0-0`

+-----------------------+-----------------------+-----------------------+
| Repository            | Name                  | Version               |
+-----------------------+-----------------------+-----------------------+
| <https://c            | mongodb-replicaset    | \^3.10.1              |
| harts.helm.sh/stable> |                       |                       |
+-----------------------+-----------------------+-----------------------+

### Mongo ReplicaSet

| Parameter                    | Description                           | Default |
| ---------------------------- | ------------------------------------- | ------- |
| `mongodb-replicaset.enabled` | Enable deployment of Mongo replicaset | `false` |

See [MongoDB replicaset](https://artifacthub.io/packages/helm/bitnami/mongodb) for detailed documentation on helm chart.

** Please be aware that the mongodb-replicaset installed by Gravitee is NOT recommended in production and it is just for testing purpose and running Cockpit locally.


### Hazelcast {#_hazelcast}

Cockpit embeds Hazelcast to handle installations connections. In order
to make Hazelcast work best when embedded and deployed under a
Kubernetes cluster, we pre-configured the auto-discovery to work with
the Kubernetes API.

> Kubernetes API mode means that each node makes a REST call to
> Kubernetes Master in order to discover IPs of PODs (with Hazelcast
> members).\]

In order to make it work, you need to grant access to the Kubernetes
API.

``` {.bash}
$ kubectl apply -f https://raw.githubusercontent.com/gravitee-io/helm-charts/master/cockpit/rbac.yml
```

If you want to let Helm to create the Service Account with required
cluster role while installating the Chart, use
`--set engine.managedServiceAccount=true`

Please note that `managedServiceAccount` is enabled by default and so,
you'll have to switch it off if you want to manage the Service Account
by yourself.

::: {.warning}
rbac.yml comes with default `graviteeio` namespace and a
`gravitee-cockpit` service account. Make sure to use the right namespace
and service account if you have overridden it.
:::

Installing {#_installing}
----------

-   Add the Gravitee.io helm charts repo

        $ helm repo add graviteeio https://helm.gravitee.io

-   Install it

        $ helm install --name graviteeio-cockpit graviteeio/cockpit

Create a chart archive {#_create_a_chart_archive}
----------------------

To package this chart directory into a chart archive, run:

    $ helm package .

Installing the Chart {#_installing_the_chart}
--------------------

To install the chart from the Helm repository with the release name
`+graviteeio-cockpit+`:

``` {.bash}
$ helm install --name graviteeio-cockpit graviteeio/cockpit
```

To install the chart using the chart archive, run:

    $ helm install cockpit-1.0.0.tgz

Values {#_values}
------

+-----------------+-----------------+-----------------+-----------------+
| Key             | Type            | Default         | Description     |
+-----------------+-----------------+-----------------+-----------------+
| api.auto        | bool            | `true`          |                 |
| scaling.enabled |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.autoscal    | int             | `3`             |                 |
| ing.maxReplicas |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.autoscal    | int             | `1`             |                 |
| ing.minReplicas |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.autosc      | int             | `50`            |                 |
| aling.targetAve |                 |                 |                 |
| rageUtilization |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| a               | int             | `80`            |                 |
| pi.autoscaling. |                 |                 |                 |
| targetMemoryAve |                 |                 |                 |
| rageUtilization |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.contro      | bool            | `true`          |                 |
| ller.ws.enabled |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.contr       | string          | `"nginx"`       |                 |
| oller.ws.ingres |                 |                 |                 |
| s.annotations.\ |                 |                 |                 |
| "kubernetes.io/ |                 |                 |                 |
| ingress.class\" |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.contro      | string          | `"true"`        |                 |
| ller.ws.ingress |                 |                 |                 |
| .annotations.\" |                 |                 |                 |
| nginx.ingress.k |                 |                 |                 |
| ubernetes.io/ss |                 |                 |                 |
| l-passthrough\" |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.con         | string          | `"true"`        |                 |
| troller.ws.ingr |                 |                 |                 |
| ess.annotations |                 |                 |                 |
| .\"nginx.ingres |                 |                 |                 |
| s.kubernetes.io |                 |                 |                 |
| /ssl-redirect\" |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api             | bool            | `true`          |                 |
| .controller.ws. |                 |                 |                 |
| ingress.enabled |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.co          | string          | `"co            |                 |
| ntroller.ws.ing |                 | ckpit-controlle |                 |
| ress.hosts\[0\] |                 | r.example.com"` |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.controller. | string          | `"/"`           |                 |
| ws.ingress.path |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.controller. | string          | `"cockpi        |                 |
| ws.ingress.tls\ |                 | t.example.com"` |                 |
| [0\].hosts\[0\] |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.controller. | string          | `"ap            |                 |
| ws.ingress.tls\ |                 | i-custom-cert"` |                 |
| [0\].secretName |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.con         | int             | `8062`          |                 |
| troller.ws.port |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api             | bool            | `true`          |                 |
| .controller.ws. |                 |                 |                 |
| service.enabled |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.cont        | int             | `8062`          |                 |
| roller.ws.servi |                 |                 |                 |
| ce.externalPort |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.controller. | string          | `"ClusterIP"`   |                 |
| ws.service.type |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.emai        | string          | `nil`           |                 |
| l.notifications |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.enabled     | bool            | `true`          |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.ht          | string          | `"adminadmin"`  |                 |
| tp.services.cor |                 |                 |                 |
| e.http.authenti |                 |                 |                 |
| cation.password |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| ap              | string          | `"localhost"`   |                 |
| i.http.services |                 |                 |                 |
| .core.http.host |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| ap              | int             | `18063`         |                 |
| i.http.services |                 |                 |                 |
| .core.http.port |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.http        | bool            | `false`         |                 |
| .services.core. |                 |                 |                 |
| ingress.enabled |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.http        | bool            | `false`         |                 |
| .services.core. |                 |                 |                 |
| service.enabled |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.i           | string          | `"Always"`      |                 |
| mage.pullPolicy |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.i           | string          | `"gravi         |                 |
| mage.repository |                 | teeio/cockpit-m |                 |
|                 |                 | anagement-api"` |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.ingres      | string          | `"nginx"`       |                 |
| s.annotations.\ |                 |                 |                 |
| "kubernetes.io/ |                 |                 |                 |
| ingress.class\" |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| ap              | string          | `"etag on;\n    |                 |
| i.ingress.annot |                 | proxy_pass_head |                 |
| ations.\"nginx. |                 | er ETag;\nproxy |                 |
| ingress.kuberne |                 | _set_header if- |                 |
| tes.io/configur |                 | match \"\";\n"` |                 |
| ation-snippet\" |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.            | bool            | `true`          |                 |
| ingress.enabled |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.ing         | string          | `"cockpi        |                 |
| ress.hosts\[0\] |                 | t.example.com"` |                 |
+-----------------+-----------------+-----------------+-----------------+
| a               | string          | `"/management"` |                 |
| pi.ingress.path |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| a               | string          | `"cockpi        |                 |
| pi.ingress.tls\ |                 | t.example.com"` |                 |
| [0\].hosts\[0\] |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| a               | string          | `"ap            |                 |
| pi.ingress.tls\ |                 | i-custom-cert"` |                 |
| [0\].secretName |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.in          | int             | `182`           |                 |
| itialPlans.larg |                 |                 |                 |
| e.healthCheckRe |                 |                 |                 |
| tentionDuration |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.initialPlan | int             | `-1`            |                 |
| s.large.maxEnvs |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.initialP    | string          | `"Large"`       |                 |
| lans.large.name |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.ini         | int             | `30`            |                 |
| tialPlans.mediu |                 |                 |                 |
| m.healthCheckRe |                 |                 |                 |
| tentionDuration |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| a               | int             | `4`             |                 |
| pi.initialPlans |                 |                 |                 |
| .medium.maxEnvs |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.initialPl   | string          | `"Medium"`      |                 |
| ans.medium.name |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.in          | int             | `1`             |                 |
| itialPlans.smal |                 |                 |                 |
| l.healthCheckRe |                 |                 |                 |
| tentionDuration |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| ap              | string          | `"true"`        |                 |
| i.initialPlans. |                 |                 |                 |
| small.isDefault |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.initialPlan | int             | `2`             |                 |
| s.small.maxEnvs |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.initialP    | string          | `"Small"`       |                 |
| lans.small.name |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.jwt.secret  | string          | `"ybbr          |                 |
|                 |                 | ZDZmjnzWhstP8xv |                 |
|                 |                 | 2SQL28AdHuNah"` |                 |
+-----------------+-----------------+-----------------+-----------------+
| ap              | bool            | `false`         |                 |
| i.logging.debug |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.loggi       | bool            | `true`          |                 |
| ng.file.enabled |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| a               | string          | `"              |                 |
| pi.logging.file |                 | %d{HH:mm:ss.SSS |                 |
| .encoderPattern |                 | } [%thread] %-5 |                 |
|                 |                 | level %logger{3 |                 |
|                 |                 | 6} - %msg%n%n"` |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.logging.fil | string          | `"<rol          |                 |
| e.rollingPolicy |                 | lingPolicy clas |                 |
|                 |                 | s=\"ch.qos.logb |                 |
|                 |                 | ack.core.rollin |                 |
|                 |                 | g.TimeBasedRoll |                 |
|                 |                 | ingPolicy\">\n  |                 |
|                 |                 |    <!-- daily r |                 |
|                 |                 | ollover -->\n   |                 |
|                 |                 |   <fileNamePatt |                 |
|                 |                 | ern>${gravitee. |                 |
|                 |                 | management.log. |                 |
|                 |                 | dir}/gravitee_% |                 |
|                 |                 | d{yyyy-MM-dd}.l |                 |
|                 |                 | og</fileNamePat |                 |
|                 |                 | tern>\n    <!-- |                 |
|                 |                 |  keep 30 days'  |                 |
|                 |                 | worth of histor |                 |
|                 |                 | y -->\n    <max |                 |
|                 |                 | History>30</max |                 |
|                 |                 | History>\n</rol |                 |
|                 |                 | lingPolicy>\n"` |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.loggin      | string          | `"DEBUG"`       |                 |
| g.graviteeLevel |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.log         | string          | `"INFO"`        |                 |
| ging.jettyLevel |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api             | string          | `"%d{HH:mm:ss.S |                 |
| .logging.stdout |                 | SS} [%thread] % |                 |
| .encoderPattern |                 | -5level %logger |                 |
|                 |                 | {36} - %msg%n"` |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.name        | string          | `"api"`         |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.platform    | string          | `"$2            |                 |
| .admin.password |                 | a$10$YCR.gYLmG8 |                 |
|                 |                 | TzKSg5TYxdzeJOp |                 |
|                 |                 | MGpEavOCni5sbHu |                 |
|                 |                 | kD2qwwZxhuXvO"` |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.re          | bool            | `false`         |                 |
| Captcha.enabled |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.reloa       | bool            | `true`          |                 |
| dOnConfigChange |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| a               | int             | `1`             |                 |
| pi.replicaCount |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.resou       | string          | `"500m"`        |                 |
| rces.limits.cpu |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.resource    | string          | `"1024Mi"`      |                 |
| s.limits.memory |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.resourc     | string          | `"200m"`        |                 |
| es.requests.cpu |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.resources.  | string          | `"512Mi"`       |                 |
| requests.memory |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| ap              | string          | `"OnFailure"`   |                 |
| i.restartPolicy |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| ap              | bool            | `true`          |                 |
| i.securityConte |                 |                 |                 |
| xt.runAsNonRoot |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.securityCo  | int             | `1001`          |                 |
| ntext.runAsUser |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.servi       | int             | `8063`          |                 |
| ce.externalPort |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.servi       | int             | `8063`          |                 |
| ce.internalPort |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.service.i   | string          | `"http"`        |                 |
| nternalPortName |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| a               | string          | `"ClusterIP"`   |                 |
| pi.service.type |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.            | string          | `"              |                 |
| services.health |                 | 0 0 0 */1 * *"` |                 |
| CheckPurge.cron |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.serv        | int             | `-1`            |                 |
| ices.healthChec |                 |                 |                 |
| kPurge.onPremis |                 |                 |                 |
| e.healthCheckRe |                 |                 |                 |
| tentionDuration |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.ssl.enabled | bool            | `false`         |                 |
+-----------------+-----------------+-----------------+-----------------+
| ap              | int             | `1`             |                 |
| i.updateStrateg |                 |                 |                 |
| y.rollingUpdate |                 |                 |                 |
| .maxUnavailable |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| api.upda        | string          | `"              |                 |
| teStrategy.type |                 | RollingUpdate"` |                 |
+-----------------+-----------------+-----------------+-----------------+
| authentication. | string          | `nil`           |                 |
| github.clientId |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| auth            | string          | `nil`           |                 |
| entication.gith |                 |                 |                 |
| ub.clientSecret |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| authentication. | string          | `nil`           |                 |
| google.clientId |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| auth            | string          | `nil`           |                 |
| entication.goog |                 |                 |                 |
| le.clientSecret |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| authenticatio   | string          | `nil`           |                 |
| n.oidc.clientId |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
|                 | au              | string          | `nil`           |
|                 | thentication.oi |                 |                 |
|                 | dc.clientSecret |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
|                 |                 | auth            | string          |
|                 |                 | entication.oidc |                 |
|                 |                 | .accessTokenUri |                 |
+-----------------+-----------------+-----------------+-----------------+
| `nil`           |                 |                 | authentica      |
|                 |                 |                 | tion.oidc.userA |
|                 |                 |                 | uthorizationUri |
+-----------------+-----------------+-----------------+-----------------+
| string          | `nil`           |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| auth            | string          | `nil`           |                 |
| entication.oidc |                 |                 |                 |
| .userProfileUri |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
|                 | au              | string          | `nil`           |
|                 | thentication.oi |                 |                 |
|                 | dc.wellKnownUri |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
|                 |                 | chaos.enabled   | bool            |
+-----------------+-----------------+-----------------+-----------------+
| `false`         |                 | mon             | bool            |
|                 |                 | go.auth.enabled |                 |
+-----------------+-----------------+-----------------+-----------------+
| `false`         |                 | mong            | string          |
|                 |                 | o.auth.password |                 |
+-----------------+-----------------+-----------------+-----------------+
| `nil`           |                 | mo              | string          |
|                 |                 | ngo.auth.source |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"admin"`       |                 | mong            | string          |
|                 |                 | o.auth.username |                 |
+-----------------+-----------------+-----------------+-----------------+
| `nil`           |                 | mongo.c         | int             |
|                 |                 | onnectTimeoutMS |                 |
+-----------------+-----------------+-----------------+-----------------+
| `30000`         |                 | mongo.dbhost    | string          |
+-----------------+-----------------+-----------------+-----------------+
| `"gravit        |                 | mongo.dbname    | string          |
| eeio-apim-mongo |                 |                 |                 |
| db-replicaset"` |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"gravitee"`    |                 | mongo.dbport    | int             |
+-----------------+-----------------+-----------------+-----------------+
| `27017`         |                 | mongo.rs        | string          |
+-----------------+-----------------+-----------------+-----------------+
| `"rs0"`         |                 | mongo.rsEnabled | bool            |
+-----------------+-----------------+-----------------+-----------------+
| `true`          |                 | mongo.          | bool            |
|                 |                 | socketKeepAlive |                 |
+-----------------+-----------------+-----------------+-----------------+
| `false`         |                 | m               | bool            |
|                 |                 | ongo.sslEnabled |                 |
+-----------------+-----------------+-----------------+-----------------+
| `false`         |                 | mongodb         | string          |
|                 |                 | -replicaset.aut |                 |
|                 |                 | h.adminPassword |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"password"`    |                 | mon             | string          |
|                 |                 | godb-replicaset |                 |
|                 |                 | .auth.adminUser |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"username"`    |                 | m               | bool            |
|                 |                 | ongodb-replicas |                 |
|                 |                 | et.auth.enabled |                 |
+-----------------+-----------------+-----------------+-----------------+
| `false`         |                 | mongodb-repl    | string          |
|                 |                 | icaset.auth.key |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"keycontent"`  |                 | mongodb-r       | string          |
|                 |                 | eplicaset.auth. |                 |
|                 |                 | metricsPassword |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"password"`    |                 | mongo           | string          |
|                 |                 | db-replicaset.a |                 |
|                 |                 | uth.metricsUser |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"metrics"`     |                 | mongodb-repli   | object          |
|                 |                 | caset.configmap |                 |
+-----------------+-----------------+-----------------+-----------------+
| `{}`            |                 | mongodb-rep     | bool            |
|                 |                 | licaset.enabled |                 |
+-----------------+-----------------+-----------------+-----------------+
| `false`         |                 | mongo           | string          |
|                 |                 | db-replicaset.i |                 |
|                 |                 | mage.repository |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"mongo"`       |                 | mongodb-repli   | float           |
|                 |                 | caset.image.tag |                 |
+-----------------+-----------------+-----------------+-----------------+
| `3.6`           |                 | mongodb         | string          |
|                 |                 | -replicaset.per |                 |
|                 |                 | sistentVolume.a |                 |
|                 |                 | ccessModes\[0\] |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"              |                 | mongodb-repli   | bool            |
| ReadWriteOnce"` |                 | caset.persisten |                 |
|                 |                 | tVolume.enabled |                 |
+-----------------+-----------------+-----------------+-----------------+
| `true`          |                 | mongodb-re      | string          |
|                 |                 | plicaset.persis |                 |
|                 |                 | tentVolume.size |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"1Gi"`         |                 | mon             | string          |
|                 |                 | godb-replicaset |                 |
|                 |                 | .replicaSetName |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"rs0"`         |                 | mongodb-repl    | int             |
|                 |                 | icaset.replicas |                 |
+-----------------+-----------------+-----------------+-----------------+
| `3`             |                 | mongodb-r       | string          |
|                 |                 | eplicaset.resou |                 |
|                 |                 | rces.limits.cpu |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"500m"`        |                 | mongodb-repl    | string          |
|                 |                 | icaset.resource |                 |
|                 |                 | s.limits.memory |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"512Mi"`       |                 | mongodb-rep     | string          |
|                 |                 | licaset.resourc |                 |
|                 |                 | es.requests.cpu |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"100m"`        |                 | mongodb-replic  | string          |
|                 |                 | aset.resources. |                 |
|                 |                 | requests.memory |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"256Mi"`       |                 | smtp.enabled    | bool            |
+-----------------+-----------------+-----------------+-----------------+
| `true`          |                 | smtp.from       | string          |
+-----------------+-----------------+-----------------+-----------------+
| `"inf           |                 | smtp.host       | string          |
| o@example.com"` |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"smt           |                 | smtp.password   | string          |
| p.example.com"` |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"example.com"` |                 | smtp.port       | int             |
+-----------------+-----------------+-----------------+-----------------+
| `25`            |                 | smtp.           | bool            |
|                 |                 | properties.\"st |                 |
|                 |                 | arttls.enable\" |                 |
+-----------------+-----------------+-----------------+-----------------+
| `false`         |                 | smtp.           | bool            |
|                 |                 | properties.auth |                 |
+-----------------+-----------------+-----------------+-----------------+
| `true`          |                 | smtp.subject    | string          |
+-----------------+-----------------+-----------------+-----------------+
| `"              |                 | smtp.username   | string          |
| [gravitee] %s"` |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"inf           |                 | ui.auto         | bool            |
| o@example.com"` |                 | scaling.enabled |                 |
+-----------------+-----------------+-----------------+-----------------+
| `true`          |                 | ui.autoscal     | int             |
|                 |                 | ing.maxReplicas |                 |
+-----------------+-----------------+-----------------+-----------------+
| `3`             |                 | ui.autoscal     | int             |
|                 |                 | ing.minReplicas |                 |
+-----------------+-----------------+-----------------+-----------------+
| `1`             |                 | ui.autosc       | int             |
|                 |                 | aling.targetAve |                 |
|                 |                 | rageUtilization |                 |
+-----------------+-----------------+-----------------+-----------------+
| `50`            |                 | ui.autoscaling. | int             |
|                 |                 | targetMemoryAve |                 |
|                 |                 | rageUtilization |                 |
+-----------------+-----------------+-----------------+-----------------+
| `80`            |                 | ui.enabled      | bool            |
+-----------------+-----------------+-----------------+-----------------+
| `true`          |                 | ui.i            | string          |
|                 |                 | mage.pullPolicy |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"Always"`      |                 | ui.i            | string          |
|                 |                 | mage.repository |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"graviteeio/   |                 | ui.ingres       | string          |
| cockpit-webui"` |                 | s.annotations.\ |                 |
|                 |                 | "kubernetes.io/ |                 |
|                 |                 | ingress.class\" |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"nginx"`       |                 | u               | string          |
|                 |                 | i.ingress.annot |                 |
|                 |                 | ations.\"nginx. |                 |
|                 |                 | ingress.kuberne |                 |
|                 |                 | tes.io/configur |                 |
|                 |                 | ation-snippet\" |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"etag on       |                 | ui.             | bool            |
| ;\nproxy_pass_h |                 | ingress.enabled |                 |
| eader ETag;\n"` |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| `true`          |                 | ui.ing          | string          |
|                 |                 | ress.hosts\[0\] |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"cockpi        |                 | ui.ingress.path | string          |
| t.example.com"` |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"/"`           |                 | ui.ingress.tls\ | string          |
|                 |                 | [0\].hosts\[0\] |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"cockpi        |                 | ui.ingress.tls\ | string          |
| t.example.com"` |                 | [0\].secretName |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"ap            |                 | ui.name         | string          |
| i-custom-cert"` |                 |                 |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"ui"`          |                 | ui.replicaCount | int             |
+-----------------+-----------------+-----------------+-----------------+
| `1`             |                 | ui.resou        | string          |
|                 |                 | rces.limits.cpu |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"100m"`        |                 | ui.resource     | string          |
|                 |                 | s.limits.memory |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"128Mi"`       |                 | ui.resourc      | string          |
|                 |                 | es.requests.cpu |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"50m"`         |                 | ui.resources.   | string          |
|                 |                 | requests.memory |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"64Mi"`        |                 | ui.securityCon  | int             |
|                 |                 | text.runAsGroup |                 |
+-----------------+-----------------+-----------------+-----------------+
| `101`           |                 | u               | bool            |
|                 |                 | i.securityConte |                 |
|                 |                 | xt.runAsNonRoot |                 |
+-----------------+-----------------+-----------------+-----------------+
| `true`          |                 | ui.securityCo   | int             |
|                 |                 | ntext.runAsUser |                 |
+-----------------+-----------------+-----------------+-----------------+
| `101`           |                 | ui.servi        | int             |
|                 |                 | ce.externalPort |                 |
+-----------------+-----------------+-----------------+-----------------+
| `8002`          |                 | ui.servi        | int             |
|                 |                 | ce.internalPort |                 |
+-----------------+-----------------+-----------------+-----------------+
| `8080`          |                 | ui.service.i    | string          |
|                 |                 | nternalPortName |                 |
+-----------------+-----------------+-----------------+-----------------+
| `"http"`        |                 | ui.service.name | string          |
+-----------------+-----------------+-----------------+-----------------+
| `"nginx"`       |                 | ui.service.type | string          |
+-----------------+-----------------+-----------------+-----------------+
