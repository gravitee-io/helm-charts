# Changelog

This file documents all notable changes to [Gravitee.io Cockpit](https://github.com/gravitee-io/helm-charts/tree/master/cockpit) Helm Chart. The release numbering uses [semantic versioning](http://semver.org).

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
