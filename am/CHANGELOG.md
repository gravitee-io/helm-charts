# Changelog

This file documents all notable changes to [Gravitee.io Access Management 3.x](https://github.com/gravitee-io/helm-charts/tree/master/am/) Helm Chart. The release numbering uses [semantic versioning](http://semver.org).

### 1.0.25

- [X] Add logger for com.graviteesource packages

### 1.0.24

- [X] Fix additional plugins integration

### 1.0.23

- [X] Fix additional plugins integration

### 1.0.22

- [X] Make Management API entrypoint configurable
- [X] Allow to enable or disable liquibase execution

### 1.0.21

- [X] Improve Deployment configurability

### 1.0.20

- [X] Remove Ingress beta API and add support for networking.k8s.io
- Update gravitee.io AM v3.9.2

### 1.0.19

- [X] Add validation on baseURL value 
- [X] Add support for JDBC Connection pool
- Update gravitee.io AM v3.9.0

### 1.0.18

- [X] Correctly evaluate ingress properties to customize constants.json file
- [X] Remove duplicate gateway.url value in AM 

### 1.0.17

- [X] Correctly mount constants.json file
- [X] Handle gateway.url value

### 1.0.16

- [X] Fix wrong constants.json file
- Update gravitee.io AM v3.8.1

### 1.0.15

- [X] Add TLS Protocols support version for the Gateway

### 1.0.14

- [X] Manage JDBC deployment
- [X] Map handlers for Auth Gateway to override X-Transaction and X-Request
- [X] Manage baseURL for the UI constants.json file
- Update gravitee.io AM v3.7.1

### 1.0.13

- [X] Externalize securityContext from deployments

### 1.0.12

- [X] Add condition for replica settings

### 1.0.11

- Update gravitee.io AM v3.4.0

### 1.0.10

- Bump AM Chart version

### 1.0.9

- Bump AM Chart version

### 1.0.8

- [X] Handle valueFrom for environment variables
- Update gravitee.io AM v3.1.2

### 1.0.7

- Update gravitee.io AM v3.1.1

### 1.0.6

- Update gravitee.io AM v3.0.4

### 1.0.5

- [X] Fix security context

### 1.0.4

- Update gravitee.io AM v2.10.15

### 1.0.3

- Bump AM Chart version

### 1.0.2

- Update gravitee.io AM v2.10.14

### 1.0.1

- Update gravitee.io AM v2.10.19

### 1.0.0

- [X] Initial support for AM charts
- Update gravitee.io AM v2.10.8
