# Changelog

This file documents all notable changes to [Gravitee.io Cockpit](https://github.com/gravitee-io/helm-charts/tree/master/cockpit) Helm Chart. The release numbering uses [semantic versioning](http://semver.org).

### 1.9.5

- [X] Upgrade Mongodb dependency to 13.18.5

### 1.9.4

- [X] add networkPolicy

### 1.9.3

- [X] Allow users to define extra manifests

### 1.9.2

- [X] Allow wildcard in ingress host
- [X] Add podSecurityContext

### 1.9.1

- [X] Add property to override endpoints ui URL
- [X] Add property to override endpoints ws URL
- [X] Add property to override authentication callback URL 

### 1.9.0

#### Breaking changes
- [X] UI API_URL environment variable need to be defined 

### 1.8.5

- [X] Add confluence api configuration for trial demo

### 1.8.4

- [X] Add new incomplete onboarding parameter on cockpit
- [X] Remove old onboarding parameter on cockpit

### 1.8.3

- [X] Add onboarding parameter on cockpit

### 1.8.2

- [X] fix Email notifier configuration

### 1.8.1

- [X] Email notifier fix configuration with TLS without truststore

### 1.8.0

- [X] Email notifier definition added

### 1.7.5

- [X] Add hook-delete-policy

### 1.7.4

- [X] Make upgrader framework optional
- [X] Add `externalTrafficPolicy` in service configuration

### 1.7.3

- [X] Add upgrader framework job
- [X] Allow users to define their own configuration file by defining a volume

### 1.7.2
- [X] Replace ClusterRole with Role

### 1.7.1
- [X] Generate hazelcast cluster name using the sha of the tag

### 1.7.0
- [X] Trunc port name with k8s limit (63)
- [X] Define default pod anti-affinity
- [X] Enable INFO logs for Hazelcast
- [X] Create new configmap to generate yaml config for Hazelcast

### 1.6.22

- [X] Use ISO 8601 datetime for cockpit json logging

### 1.6.21

- [X] Fix json logging to log one message per line

### 1.6.20

- [X] Upgrade Mongodb and Elasticsearch dependencies
- [X] Add support for json logging in logback

### 1.6.19

- [X] Add support for appProtocol to the services
- [X] Add support for autoscaling/v2

### 1.6.18

- [X] Add support for managed ServiceAccounts name provided by user
- [X] Add version labels on pods
- [X] Add support for ingressClassName

### 1.6.17

- [X] Remove file logger
- [X] Add missing container ports declaration
- [X] Use named port in service

### 1.6.16

- [X] Add support for PodDisruptionBudget

### 1.6.15

- [X] Reorder HPA resources to avoid outofsync state with ArgoCD

### 1.6.14

- [X] Fix ignoring the managedServiceAccount in the deployment files

### 1.6.13

- [X] Set default array for topologySpreadConstraints

### 1.6.12

- [X] Add support for topologySpreadConstraints

### 1.6.11

- fix API_URL environment variable name
- add missing labels

### 1.6.9

- [X] Ensure additional jar doesn't exist before downloading it
- [X] Define additional loggers in logback configuration

### 1.6.8
- Fix swagger generator default image name
- Update to Cockpit v3.16.0
 
### 1.6.7
- Fix typo in ServiceAccount resources

### 1.6.6

- [X] Make app.kubernetes.io/version label consistent
- [X] Add quotes to version to fix #6450
- [X] Add ServiceAccount to all deployments
- Update gravitee.io Cockpit v3.15.0

### 1.6.5

- [X] Add support for revisionHistoryLimit

### 1.6.4

- [X] Fix Cockpit WS ingress with pathPrefix

### 1.6.3

- [X] Support Ingress kubernetes >= 1.22.x

### 1.6.2

- Set default compatibleVersions
- Update gravitee.io Cockpit v3.12.2

### 1.6.1

- [X] Configure deployment strategy
- Update gravitee.io Cockpit v3.11.1

### 1.6.0

- Add swagger generator url and api key configuration

### 1.5.0

- Add swagger generator

### 1.4.0

- Make management-api ingress sse compatible

### 1.3.0

- Update cockpit ui default image name

### 1.2.1

- Add native support for service account

### 1.2.0

- Add OIDC idp configuration
- Update Hazelcast configuration for primary/replica installations

### 1.1.0

- Add Hazelcast configuration

### 1.0.1

- [X] Add support for health check cron job attributes
- Update gravitee.io Cockpit v1.2.1

### 1.0.0

- [X] Initial Helm Chart for Gravitee.io Cockpit

- Update gravitee.io Cockpit v1.2.0
