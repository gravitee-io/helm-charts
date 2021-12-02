{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "gravitee.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "gravitee.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified gateway name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "gravitee.gateway.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.gateway.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.gateway.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified gateway name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "gravitee.api.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.api.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.api.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified gateway name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "gravitee.ui.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.ui.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.ui.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Return the apiVersion of ingress.
*/}}
{{- define "ingress.apiVersion" -}}
{{- if .Capabilities.APIVersions.Has "networking.k8s.io/v1" -}}
    {{- print "networking.k8s.io/v1" -}}
{{- else if .Capabilities.APIVersions.Has "networking.k8s.io/v1beta1" -}}
    {{- print "networking.k8s.io/v1beta1" -}}
{{- else -}}
    {{- print "extensions/v1beta1" -}}
{{- end -}}
{{- end -}}

{{/*
Create initContainers for downloading plugins ext plugin-ext
*/}}
{{- define "deployment.pluginInitContainers" -}}
{{- if .plugins }}
- name: get-plugins
  {{- toYaml .initContainers | nindent 2 }}
  command: ['sh', '-c', "mkdir -p /tmp/plugins && cd /tmp/plugins {{- range $url := .plugins -}}
    {{ printf " && wget %s" $url }}
  {{- end -}}"]
  volumeMounts:
    - name: graviteeio-am-plugins
      mountPath: /tmp/plugins
{{- end }}
{{- range $key, $url := .extPlugins }}
- name: get-{{ $key }}-ext
  {{- toYaml .initContainers | nindent 2 }}
  command: ['sh', '-c', "mkdir -p /tmp/plugins-ext && cd /tmp/plugins-ext && wget {{ $url }}"]
  volumeMounts:
    - name: graviteeio-am-{{ $key }}-ext
      mountPath: /tmp/plugins-ext
{{- end }}
{{- end -}}

{{/*
Create volumeMounts for plugins
*/}}
{{- define "deployment.pluginVolumeMounts" -}}
{{- if or .plugins .extPlugins }}
- name: graviteeio-am-plugins
  mountPath: /opt/{{ .appName }}/plugins-ext
{{- end }}
{{- $appName := .appName -}}
{{- range $key, $_ := .extPlugins }}
- name: graviteeio-am-{{ $key }}-ext
  mountPath: /opt/{{ $appName }}/plugins-ext/ext/{{ $key }}
{{- end }}
{{- end -}}

{{/*
Create volumes for plugins
*/}}
{{- define "deployment.pluginVolumes" -}}
{{- if or .plugins .extPlugins }}
- name: graviteeio-am-plugins
  emptyDir: {}
{{- end }}
{{- range $key, $_ := .extPlugins }}
- name: graviteeio-am-{{ $key }}-ext
  emptyDir: {}
{{- end }}
{{- end -}}

{{/*
Create initContainers for downloading jdbc drivers
*/}}
{{- define "deployment.jdbcDriverInitContainers" -}}
{{- if .jdbcDrivers }}
- name: get-jdbc-ext
  image: 'alpine'
  command: ['sh', '-c', "mkdir -p /tmp/plugins-ext && cd /tmp/plugins-ext {{- range $url := .jdbcDrivers -}}
    {{ printf " && wget %s" $url }}
  {{- end -}}"]
  securityContext:
{{ toYaml .securityContext | trim | indent 4 }}
  volumeMounts:
    - name: graviteeio-am-jdbc-ext
      mountPath: /tmp/plugins-ext
{{- end }}
{{- end -}}
