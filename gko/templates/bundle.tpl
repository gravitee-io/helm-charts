apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    cert-manager.io/inject-ca-from: $(CERTIFICATE_NAMESPACE)/$(CERTIFICATE_NAME)
    controller-gen.kubebuilder.io/version: v0.9.0
  name: apidefinitions.gravitee.io
spec:
  group: gravitee.io
  names:
    kind: ApiDefinition
    listKind: ApiDefinitionList
    plural: apidefinitions
    shortNames:
    - graviteeapis
    singular: apidefinition
  scope: Namespaced
  versions:
  - additionalPrinterColumns:
    - description: API state (STARTED or STOPPED).
      jsonPath: .status.state
      name: State
      type: string
    - description: API entrypoint.
      jsonPath: .spec.proxy.virtual_hosts[*].path
      name: Entrypoint
      type: string
    - description: API endpoint.
      jsonPath: .spec.proxy.groups[*].endpoints[*].target
      name: Endpoint
      type: string
    - description: API version.
      jsonPath: .spec.version
      name: Version
      type: string
    - description: Management context name.
      jsonPath: .spec.contextRef.name
      name: Management Context
      type: string
    - description: Api definition processing status.
      jsonPath: .status.processingStatus
      name: Processing Status
      type: string
    name: v1alpha1
    schema:
      openAPIV3Schema:
        description: ApiDefinition is the Schema for the apidefinitions API.
        properties:
          apiVersion:
            description: 'APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources'
            type: string
          kind:
            description: 'Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
            type: string
          metadata:
            type: object
          spec:
            description: The API definition is the main resource handled by the Kubernetes Operator Most of the configuration properties defined here are already documented in the APIM Console API Reference. See https://docs.gravitee.io/apim/3.x/apim_installguide_rest_apis_documentation.html
            properties:
              contextRef:
                description: The contextRef refers to the namespace and the name of a ManagementContext used for synchronizing API definitions with a Gravitee API Management instance.
                properties:
                  name:
                    type: string
                  namespace:
                    type: string
                required:
                - name
                type: object
              crossId:
                type: string
              definition_context:
                description: The definition context is used to inform a management API instance that this API definition is managed using a kubernetes operator
                properties:
                  mode:
                    default: fully_managed
                    type: string
                  origin:
                    default: kubernetes
                    type: string
                type: object
              deployedAt:
                format: int64
                type: integer
              description:
                type: string
              flow_mode:
                default: DEFAULT
                enum:
                - DEFAULT
                - BEST_MATCH
                type: string
              flows:
                items:
                  properties:
                    condition:
                      type: string
                    consumers:
                      items:
                        properties:
                          consumerId:
                            type: string
                          consumerType:
                            type: integer
                        type: object
                      type: array
                    enabled:
                      type: boolean
                    methods:
                      items:
                        enum:
                        - GET
                        - POST
                        - PUT
                        - PATCH
                        - DELETE
                        - OPTIONS
                        - HEAD
                        - CONNECT
                        - TRACE
                        - OTHER
                        type: string
                      type: array
                    name:
                      type: string
                    path-operator:
                      properties:
                        operator:
                          default: STARTS_WITH
                          enum:
                          - STARTS_WITH
                          - EQUALS
                          type: string
                        path:
                          type: string
                      type: object
                    post:
                      items:
                        properties:
                          condition:
                            type: string
                          configuration:
                            type: object
                            x-kubernetes-preserve-unknown-fields: true
                          description:
                            type: string
                          enabled:
                            type: boolean
                          name:
                            type: string
                          policy:
                            type: string
                        type: object
                      type: array
                    pre:
                      items:
                        properties:
                          condition:
                            type: string
                          configuration:
                            type: object
                            x-kubernetes-preserve-unknown-fields: true
                          description:
                            type: string
                          enabled:
                            type: boolean
                          name:
                            type: string
                          policy:
                            type: string
                        type: object
                      type: array
                  type: object
                type: array
              gravitee:
                default: 2.0.0
                type: string
              id:
                description: io.gravitee.definition.model.Api
                type: string
              labels:
                items:
                  type: string
                type: array
              lifecycle_state:
                default: CREATED
                enum:
                - CREATED
                - PUBLISHED
                - UNPUBLISHED
                - DEPRECATED
                - ARCHIVED
                type: string
              metadata:
                items:
                  properties:
                    defaultValue:
                      type: string
                    format:
                      enum:
                      - STRING
                      - NUMERIC
                      - BOOLEAN
                      - DATE
                      - MAIL
                      - URL
                      type: string
                    key:
                      type: string
                    name:
                      type: string
                    value:
                      type: string
                  required:
                  - format
                  - key
                  - name
                  type: object
                type: array
              name:
                type: string
              path_mappings:
                items:
                  type: string
                type: array
              plans:
                items:
                  properties:
                    api:
                      type: string
                    characteristics:
                      items:
                        type: string
                      type: array
                    comment_required:
                      type: boolean
                    crossId:
                      type: string
                    description:
                      type: string
                    flows:
                      items:
                        properties:
                          condition:
                            type: string
                          consumers:
                            items:
                              properties:
                                consumerId:
                                  type: string
                                consumerType:
                                  type: integer
                              type: object
                            type: array
                          enabled:
                            type: boolean
                          methods:
                            items:
                              enum:
                              - GET
                              - POST
                              - PUT
                              - PATCH
                              - DELETE
                              - OPTIONS
                              - HEAD
                              - CONNECT
                              - TRACE
                              - OTHER
                              type: string
                            type: array
                          name:
                            type: string
                          path-operator:
                            properties:
                              operator:
                                default: STARTS_WITH
                                enum:
                                - STARTS_WITH
                                - EQUALS
                                type: string
                              path:
                                type: string
                            type: object
                          post:
                            items:
                              properties:
                                condition:
                                  type: string
                                configuration:
                                  type: object
                                  x-kubernetes-preserve-unknown-fields: true
                                description:
                                  type: string
                                enabled:
                                  type: boolean
                                name:
                                  type: string
                                policy:
                                  type: string
                              type: object
                            type: array
                          pre:
                            items:
                              properties:
                                condition:
                                  type: string
                                configuration:
                                  type: object
                                  x-kubernetes-preserve-unknown-fields: true
                                description:
                                  type: string
                                enabled:
                                  type: boolean
                                name:
                                  type: string
                                policy:
                                  type: string
                              type: object
                            type: array
                        type: object
                      type: array
                    id:
                      type: string
                    name:
                      type: string
                    order:
                      type: integer
                    paths:
                      additionalProperties:
                        items:
                          properties:
                            description:
                              type: string
                            enabled:
                              type: boolean
                            methods:
                              items:
                                enum:
                                - GET
                                - POST
                                - PUT
                                - PATCH
                                - DELETE
                                - OPTIONS
                                - HEAD
                                - CONNECT
                                - TRACE
                                - OTHER
                                type: string
                              type: array
                            policy:
                              properties:
                                configuration:
                                  type: object
                                  x-kubernetes-preserve-unknown-fields: true
                                name:
                                  type: string
                              type: object
                          type: object
                        type: array
                      type: object
                    security:
                      type: string
                    securityDefinition:
                      type: string
                    selectionRule:
                      type: string
                    status:
                      default: PUBLISHED
                      enum:
                      - STAGING
                      - PUBLISHED
                      - CLOSED
                      - DEPRECATED
                      type: string
                    tags:
                      items:
                        type: string
                      type: array
                    type:
                      default: API
                      enum:
                      - API
                      - CATALOG
                      type: string
                    validation:
                      default: AUTO
                      enum:
                      - AUTO
                      - MANUAL
                      type: string
                  required:
                  - description
                  - name
                  - security
                  type: object
                type: array
              primaryOwner:
                properties:
                  displayName:
                    type: string
                  email:
                    type: string
                  id:
                    type: string
                  type:
                    type: string
                required:
                - displayName
                - email
                - id
                - type
                type: object
              properties:
                items:
                  properties:
                    encrypted:
                      type: boolean
                    key:
                      type: string
                    value:
                      type: string
                  type: object
                type: array
              proxy:
                properties:
                  cors:
                    properties:
                      allowCredentials:
                        type: boolean
                      allowHeaders:
                        items:
                          type: string
                        type: array
                      allowMethods:
                        items:
                          type: string
                        type: array
                      allowOrigin:
                        items:
                          type: string
                        type: array
                      enabled:
                        type: boolean
                      exposeHeaders:
                        items:
                          type: string
                        type: array
                      maxAge:
                        type: integer
                      runPolicies:
                        default: false
                        type: boolean
                    required:
                    - allowCredentials
                    - enabled
                    - maxAge
                    type: object
                  failover:
                    properties:
                      cases:
                        items:
                          type: string
                        type: array
                      maxAttempts:
                        type: integer
                      retryTimeout:
                        format: int64
                        type: integer
                    type: object
                  groups:
                    items:
                      properties:
                        endpoints:
                          items:
                            properties:
                              '-':
                                type: integer
                              backup:
                                type: boolean
                              headers:
                                items:
                                  properties:
                                    name:
                                      type: string
                                    value:
                                      type: string
                                  type: object
                                type: array
                              healthCheck:
                                properties:
                                  inherit:
                                    type: boolean
                                  schedule:
                                    type: string
                                  steps:
                                    description: HealthCheckService
                                    items:
                                      properties:
                                        name:
                                          type: string
                                        request:
                                          properties:
                                            body:
                                              type: string
                                            fromRoot:
                                              type: boolean
                                            headers:
                                              items:
                                                properties:
                                                  name:
                                                    type: string
                                                  value:
                                                    type: string
                                                type: object
                                              type: array
                                            method:
                                              enum:
                                              - GET
                                              - POST
                                              - PUT
                                              - PATCH
                                              - DELETE
                                              - OPTIONS
                                              - HEAD
                                              - CONNECT
                                              - TRACE
                                              - OTHER
                                              type: string
                                            path:
                                              type: string
                                          type: object
                                        response:
                                          properties:
                                            assertions:
                                              items:
                                                type: string
                                              type: array
                                          type: object
                                      type: object
                                    type: array
                                type: object
                              http:
                                properties:
                                  clearTextUpgrade:
                                    type: boolean
                                  connectTimeout:
                                    format: int64
                                    type: integer
                                  followRedirects:
                                    type: boolean
                                  idleTimeout:
                                    format: int64
                                    type: integer
                                  keepAlive:
                                    type: boolean
                                  maxConcurrentConnections:
                                    type: integer
                                  pipelining:
                                    type: boolean
                                  readTimeout:
                                    format: int64
                                    type: integer
                                  useCompression:
                                    type: boolean
                                  version:
                                    type: string
                                type: object
                              inherit:
                                type: boolean
                              name:
                                description: From Endpoint
                                type: string
                              proxy:
                                properties:
                                  enabled:
                                    type: boolean
                                  host:
                                    type: string
                                  password:
                                    type: string
                                  port:
                                    type: integer
                                  type:
                                    type: string
                                  useSystemProxy:
                                    type: boolean
                                  username:
                                    type: string
                                type: object
                              ssl:
                                properties:
                                  hostnameVerifier:
                                    type: boolean
                                  keyStore:
                                    properties:
                                      type:
                                        type: string
                                    type: object
                                  trustAll:
                                    type: boolean
                                  trustStore:
                                    properties:
                                      type:
                                        type: string
                                    type: object
                                type: object
                              target:
                                type: string
                              tenants:
                                items:
                                  type: string
                                type: array
                              type:
                                type: string
                              weight:
                                type: integer
                            type: object
                          type: array
                        headers:
                          additionalProperties:
                            type: string
                          type: object
                        http:
                          properties:
                            clearTextUpgrade:
                              type: boolean
                            connectTimeout:
                              format: int64
                              type: integer
                            followRedirects:
                              type: boolean
                            idleTimeout:
                              format: int64
                              type: integer
                            keepAlive:
                              type: boolean
                            maxConcurrentConnections:
                              type: integer
                            pipelining:
                              type: boolean
                            readTimeout:
                              format: int64
                              type: integer
                            useCompression:
                              type: boolean
                            version:
                              type: string
                          type: object
                        load_balancing:
                          properties:
                            type:
                              type: string
                          type: object
                        name:
                          type: string
                        proxy:
                          properties:
                            enabled:
                              type: boolean
                            host:
                              type: string
                            password:
                              type: string
                            port:
                              type: integer
                            type:
                              type: string
                            useSystemProxy:
                              type: boolean
                            username:
                              type: string
                          type: object
                        services:
                          properties:
                            discovery:
                              properties:
                                configuration:
                                  type: object
                                  x-kubernetes-preserve-unknown-fields: true
                                enabled:
                                  type: boolean
                                name:
                                  type: string
                                provider:
                                  type: string
                              required:
                              - enabled
                              type: object
                            dynamic-property:
                              properties:
                                provider:
                                  type: integer
                                schedule:
                                  type: string
                              type: object
                            health-check:
                              properties:
                                enabled:
                                  default: false
                                  type: boolean
                                schedule:
                                  type: string
                                steps:
                                  items:
                                    properties:
                                      name:
                                        type: string
                                      request:
                                        properties:
                                          body:
                                            type: string
                                          fromRoot:
                                            type: boolean
                                          headers:
                                            items:
                                              properties:
                                                name:
                                                  type: string
                                                value:
                                                  type: string
                                              type: object
                                            type: array
                                          method:
                                            enum:
                                            - GET
                                            - POST
                                            - PUT
                                            - PATCH
                                            - DELETE
                                            - OPTIONS
                                            - HEAD
                                            - CONNECT
                                            - TRACE
                                            - OTHER
                                            type: string
                                          path:
                                            type: string
                                        type: object
                                      response:
                                        properties:
                                          assertions:
                                            items:
                                              type: string
                                            type: array
                                        type: object
                                    type: object
                                  type: array
                              required:
                              - enabled
                              type: object
                          type: object
                        ssl:
                          properties:
                            hostnameVerifier:
                              type: boolean
                            keyStore:
                              properties:
                                type:
                                  type: string
                              type: object
                            trustAll:
                              type: boolean
                            trustStore:
                              properties:
                                type:
                                  type: string
                              type: object
                          type: object
                      type: object
                    type: array
                  logging:
                    properties:
                      condition:
                        type: string
                      content:
                        enum:
                        - NONE
                        - HEADERS
                        - PAYLOADS
                        - HEADERS_PAYLOADS
                        type: string
                      mode:
                        enum:
                        - NONE
                        - CLIENT
                        - PROXY
                        - CLIENT_PROXY
                        type: string
                      scope:
                        enum:
                        - NONE
                        - REQUEST
                        - RESPONSE
                        - REQUEST_RESPONSE
                        type: string
                    type: object
                  preserve_host:
                    type: boolean
                  strip_context_path:
                    type: boolean
                  virtual_hosts:
                    items:
                      properties:
                        host:
                          type: string
                        override_entrypoint:
                          type: boolean
                        path:
                          type: string
                      type: object
                    type: array
                type: object
              resources:
                items:
                  properties:
                    configuration:
                      type: object
                      x-kubernetes-preserve-unknown-fields: true
                    enabled:
                      type: boolean
                    name:
                      type: string
                    ref:
                      properties:
                        name:
                          type: string
                        namespace:
                          type: string
                      required:
                      - name
                      type: object
                    type:
                      type: string
                  type: object
                type: array
              response_templates:
                additionalProperties:
                  additionalProperties:
                    properties:
                      body:
                        type: string
                      headers:
                        additionalProperties:
                          type: string
                        type: object
                      status:
                        type: integer
                    type: object
                  type: object
                type: object
              services:
                properties:
                  discovery:
                    properties:
                      configuration:
                        type: object
                        x-kubernetes-preserve-unknown-fields: true
                      enabled:
                        type: boolean
                      name:
                        type: string
                      provider:
                        type: string
                    required:
                    - enabled
                    type: object
                  dynamic-property:
                    properties:
                      provider:
                        type: integer
                      schedule:
                        type: string
                    type: object
                  health-check:
                    properties:
                      enabled:
                        default: false
                        type: boolean
                      schedule:
                        type: string
                      steps:
                        items:
                          properties:
                            name:
                              type: string
                            request:
                              properties:
                                body:
                                  type: string
                                fromRoot:
                                  type: boolean
                                headers:
                                  items:
                                    properties:
                                      name:
                                        type: string
                                      value:
                                        type: string
                                    type: object
                                  type: array
                                method:
                                  enum:
                                  - GET
                                  - POST
                                  - PUT
                                  - PATCH
                                  - DELETE
                                  - OPTIONS
                                  - HEAD
                                  - CONNECT
                                  - TRACE
                                  - OTHER
                                  type: string
                                path:
                                  type: string
                              type: object
                            response:
                              properties:
                                assertions:
                                  items:
                                    type: string
                                  type: array
                              type: object
                          type: object
                        type: array
                    required:
                    - enabled
                    type: object
                type: object
              state:
                default: STARTED
                enum:
                - STARTED
                - STOPPED
                type: string
              tags:
                items:
                  type: string
                type: array
              version:
                type: string
              visibility:
                default: PRIVATE
                enum:
                - PUBLIC
                - PRIVATE
                type: string
            type: object
          status:
            description: ApiDefinitionStatus defines the observed state of API Definition.
            properties:
              crossId:
                description: The cross ID of the API definition. Similar to the ID but does not change across environments.
                type: string
              generation:
                description: The observed generation is used internally, together with the processing status, to determine if the API definition is being updated or created.
                format: int64
                type: integer
              id:
                description: The ID of the API definition in the Gravitee API Management instance (if a management context has been configured).
                type: string
              processingStatus:
                description: The processing status of the API definition.
                enum:
                - Completed
                - Failed
                - Reconciling
                type: string
              state:
                description: The state of the API. Can be either STARTED or STOPPED.
                type: string
            required:
            - crossId
            - generation
            - id
            type: object
        type: object
    served: true
    storage: true
    subresources:
      status: {}
---
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    controller-gen.kubebuilder.io/version: v0.9.0
  creationTimestamp: null
  name: apiresources.gravitee.io
spec:
  group: gravitee.io
  names:
    kind: ApiResource
    listKind: ApiResourceList
    plural: apiresources
    singular: apiresource
  scope: Namespaced
  versions:
  - name: v1alpha1
    schema:
      openAPIV3Schema:
        properties:
          apiVersion:
            description: 'APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources'
            type: string
          kind:
            description: 'Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
            type: string
          metadata:
            type: object
          spec:
            description: ApiResourceSpec defines the desired state of ApiResource.
            properties:
              configuration:
                type: object
                x-kubernetes-preserve-unknown-fields: true
              enabled:
                type: boolean
              name:
                type: string
              type:
                type: string
            type: object
          status:
            type: object
        type: object
    served: true
    storage: true
    subresources:
      status: {}
---
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    controller-gen.kubebuilder.io/version: v0.9.0
  creationTimestamp: null
  name: managementcontexts.gravitee.io
spec:
  group: gravitee.io
  names:
    kind: ManagementContext
    listKind: ManagementContextList
    plural: managementcontexts
    shortNames:
    - graviteecontexts
    singular: managementcontext
  scope: Namespaced
  versions:
  - additionalPrinterColumns:
    - jsonPath: .spec.name
      name: Name
      type: string
    - jsonPath: .spec.baseUrl
      name: BaseUrl
      type: string
    name: v1alpha1
    schema:
      openAPIV3Schema:
        description: ManagementContext is the Schema for the Management API.
        properties:
          apiVersion:
            description: 'APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources'
            type: string
          kind:
            description: 'Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
            type: string
          metadata:
            type: object
          spec:
            description: ManagementContext represents the configuration for a specific environment of a Management API instance.
            properties:
              auth:
                description: Auth defines the authentication method used to connect to the API Management. Can be either basic authentication credentials, a bearer token or a reference to a kubernetes secret holding one of these two configurations.
                properties:
                  bearerToken:
                    description: The bearer token used to authenticate against the API Management instance (must be generated from an admin account)
                    type: string
                  credentials:
                    description: The Basic credentials used to authenticate against the API Management instance.
                    properties:
                      password:
                        type: string
                      username:
                        type: string
                    type: object
                  secretRef:
                    description: A secret reference holding either a bearer token or the user name and password used for basic authentication
                    properties:
                      name:
                        type: string
                      namespace:
                        type: string
                    required:
                    - name
                    type: object
                type: object
              baseUrl:
                description: The URL of a management API instance
                pattern: ^http(s?):\/\/.+$
                type: string
              environmentId:
                description: An existing environment id targeted by the context within the organization.
                type: string
              organizationId:
                description: An existing organization id targeted by the context on the management API instance.
                type: string
            required:
            - auth
            - baseUrl
            - environmentId
            - organizationId
            type: object
          status:
            description: ManagementContextStatus defines the observed state of ManagementContext.
            type: object
        type: object
    served: true
    storage: true
    subresources:
      status: {}
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: gko-controller-manager
  namespace: '{{.Release.Namespace}}'
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: gko-leader-election-role
  namespace: '{{.Release.Namespace}}'
rules:
- apiGroups:
  - ""
  resources:
  - configmaps
  verbs:
  - get
  - list
  - watch
  - create
  - update
  - patch
  - delete
- apiGroups:
  - coordination.k8s.io
  resources:
  - leases
  verbs:
  - get
  - list
  - watch
  - create
  - update
  - patch
  - delete
- apiGroups:
  - ""
  resources:
  - events
  verbs:
  - create
  - patch
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  creationTimestamp: null
  name: gko-manager-role
rules:
- apiGroups:
  - ""
  resources:
  - configmaps
  verbs:
  - create
  - delete
  - get
  - list
  - patch
  - update
  - watch
- apiGroups:
  - ""
  resources:
  - events
  verbs:
  - create
  - patch
- apiGroups:
  - ""
  resources:
  - secrets
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - gravitee.io
  resources:
  - apidefinitions
  verbs:
  - create
  - delete
  - deletecollection
  - get
  - list
  - patch
  - update
  - watch
- apiGroups:
  - gravitee.io
  resources:
  - apidefinitions/finalizers
  verbs:
  - update
- apiGroups:
  - gravitee.io
  resources:
  - apidefinitions/status
  verbs:
  - get
  - patch
  - update
- apiGroups:
  - gravitee.io
  resources:
  - apiresources
  verbs:
  - create
  - delete
  - get
  - list
  - patch
  - update
  - watch
- apiGroups:
  - gravitee.io
  resources:
  - apiresources/finalizers
  verbs:
  - update
- apiGroups:
  - gravitee.io
  resources:
  - apiresources/status
  verbs:
  - get
  - patch
  - update
- apiGroups:
  - gravitee.io
  resources:
  - managementcontexts
  verbs:
  - create
  - delete
  - get
  - list
  - patch
  - update
  - watch
- apiGroups:
  - gravitee.io
  resources:
  - managementcontexts/finalizers
  verbs:
  - update
- apiGroups:
  - gravitee.io
  resources:
  - managementcontexts/status
  verbs:
  - get
  - patch
  - update
- apiGroups:
  - networking.k8s.io
  resources:
  - ingresses
  verbs:
  - create
  - delete
  - get
  - list
  - patch
  - update
  - watch
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: gko-metrics-reader
rules:
- nonResourceURLs:
  - /metrics
  verbs:
  - get
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: gko-proxy-role
rules:
- apiGroups:
  - authentication.k8s.io
  resources:
  - tokenreviews
  verbs:
  - create
- apiGroups:
  - authorization.k8s.io
  resources:
  - subjectaccessreviews
  verbs:
  - create
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: gko-leader-election-rolebinding
  namespace: '{{.Release.Namespace}}'
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: gko-leader-election-role
subjects:
- kind: ServiceAccount
  name: gko-controller-manager
  namespace: '{{.Release.Namespace}}'
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: gko-manager-rolebinding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: gko-manager-role
subjects:
- kind: ServiceAccount
  name: gko-controller-manager
  namespace: '{{.Release.Namespace}}'
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: gko-proxy-rolebinding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: gko-proxy-role
subjects:
- kind: ServiceAccount
  name: gko-controller-manager
  namespace: '{{.Release.Namespace}}'
---
apiVersion: v1
data:
  controller_manager_config.yaml: |
    # Copyright (C) 2015 The Gravitee team (http://gravitee.io)
    #
    # Licensed under the Apache License, Version 2.0 (the "License");
    # you may not use this file except in compliance with the License.
    # You may obtain a copy of the License at
    #
    #         http://www.apache.org/licenses/LICENSE-2.0
    #
    # Unless required by applicable law or agreed to in writing, software
    # distributed under the License is distributed on an "AS IS" BASIS,
    # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    # See the License for the specific language governing permissions and
    # limitations under the License.

    apiVersion: controller-runtime.sigs.k8s.io/v1alpha1
    kind: ControllerManagerConfig
    health:
      healthProbeBindAddress: :8081
    metrics:
      bindAddress: 127.0.0.1:8080
    webhook:
      port: 9443
    leaderElection:
      leaderElect: true
      resourceName: 24d975d3.gravitee.io
kind: ConfigMap
metadata:
  name: gko-manager-config
  namespace: '{{.Release.Namespace}}'
---
apiVersion: v1
kind: Service
metadata:
  labels:
    control-plane: controller-manager
  name: gko-controller-manager-metrics-service
  namespace: '{{.Release.Namespace}}'
spec:
  ports:
  - name: https
    port: 8443
    protocol: TCP
    targetPort: https
  selector:
    control-plane: controller-manager
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    control-plane: controller-manager
  name: gko-controller-manager
  namespace: '{{.Release.Namespace}}'
spec:
  replicas: 1
  selector:
    matchLabels:
      control-plane: controller-manager
  template:
    metadata:
      annotations:
        kubectl.kubernetes.io/default-container: manager
      labels:
        control-plane: controller-manager
    spec:
      containers:
      - args:
        - --secure-listen-address=0.0.0.0:8443
        - --upstream=http://127.0.0.1:8080/
        - --logtostderr=true
        - --v=0
        image: gcr.io/kubebuilder/kube-rbac-proxy:v0.11.0
        name: kube-rbac-proxy
        ports:
        - containerPort: 8443
          name: https
          protocol: TCP
        resources:
          limits:
            cpu: 500m
            memory: 128Mi
          requests:
            cpu: 5m
            memory: 64Mi
      - args:
        - --health-probe-bind-address=:8081
        - --metrics-bind-address=127.0.0.1:8080
        - --leader-elect
        command:
        - /manager
        envFrom:
        - configMapRef:
            name: '{{.Values.manager.configMap.name}}'
            optional: true
        image: '{{ .Values.manager.image.repository }}:{{ default .Chart.AppVersion .Values.manager.image.tag }}'
        imagePullPolicy: IfNotPresent
        livenessProbe:
          httpGet:
            path: /healthz
            port: 8081
          initialDelaySeconds: 15
          periodSeconds: 20
        name: manager
        readinessProbe:
          httpGet:
            path: /readyz
            port: 8081
          initialDelaySeconds: 5
          periodSeconds: 10
        resources:
          limits:
            cpu: 500m
            memory: 128Mi
          requests:
            cpu: 10m
            memory: 64Mi
        securityContext:
          allowPrivilegeEscalation: false
      securityContext:
        runAsNonRoot: true
      serviceAccountName: gko-controller-manager
      terminationGracePeriodSeconds: 10
