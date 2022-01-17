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
{{- if .Values.fullnameOverride -}}
{{- printf "%s-%s" .Values.fullnameOverride .Values.gateway.name | trunc 63 | trimSuffix "-" -}}
{{- else if contains $name .Release.Name -}}
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
{{- if .Values.fullnameOverride -}}
{{- printf "%s-%s" .Values.fullnameOverride .Values.api.name | trunc 63 | trimSuffix "-" -}}
{{- else if contains $name .Release.Name -}}
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
{{- if .Values.fullnameOverride -}}
{{- printf "%s-%s" .Values.fullnameOverride .Values.ui.name | trunc 63 | trimSuffix "-" -}}
{{- else if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.ui.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.ui.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified gateway name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "gravitee.portal.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if .Values.fullnameOverride -}}
{{- printf "%s-%s" .Values.fullnameOverride .Values.portal.name | trunc 63 | trimSuffix "-" -}}
{{- else if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.portal.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.portal.name | trunc 63 | trimSuffix "-" -}}
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
    {{ printf " && ( rm "}} {{regexFind "[^/]+$" $url}} {{ printf " 2>/dev/null || true ) && wget %s" $url }}
  {{- end -}}"]
  volumeMounts:
    - name: graviteeio-apim-plugins
      mountPath: /tmp/plugins
{{- end }}
{{- range $key, $url := .extPlugins }}
- name: get-{{ $key }}-ext
  {{- toYaml .initContainers | nindent 2 }}
  command: ['sh', '-c', "mkdir -p /tmp/plugins-ext && cd /tmp/plugins-ext && ( rm {{regexFind "[^/]+$" $url}} || true ) && wget {{ $url }}"]
  volumeMounts:
    - name: graviteeio-apim-{{ $key }}-ext
      mountPath: /tmp/plugins-ext
{{- end }}
{{- if .pluginsToRemove }}
- name: delete-plugins
  {{- toYaml .initContainers | nindent 2 }}
  command: ['sh', '-c', "cd /opt/{{ .appName }}/plugins {{- range $key := .pluginsToRemove -}}
    {{ printf " && rm -f %s-*.zip" $key }}
  {{- end -}}"]
{{- end }}
{{- end -}}

{{- define "ratelimit.plugin" -}}
{{- $version := (.Values.redis.repositoryVersion | default .Values.gateway.image.tag | default .Chart.AppVersion ) -}}
{{- if or (eq "nightly" $version) (contains "latest" $version) -}}
  {{- printf "https://download.gravitee.io/graviteeio-apim/plugins/repositories/gravitee-apim-repository-redis/gravitee-apim-repository-redis-%s.zip" (.Values.redis.repositoryVersion | default .Chart.AppVersion) -}}
{{- else if $version | semverCompare "<=3.5.18" -}}
  {{- printf "https://download.gravitee.io/graviteeio-apim/plugins/repositories/gravitee-repository-redis/gravitee-repository-redis-%s.zip" $version -}}
{{- else -}}
  {{- printf "https://download.gravitee.io/graviteeio-apim/plugins/repositories/gravitee-apim-repository-redis/gravitee-apim-repository-redis-%s.zip" $version -}}
{{- end -}}
{{- end -}}

{{/*
Create volumeMounts for plugins
*/}}
{{- define "deployment.pluginVolumeMounts" -}}
{{- if or .plugins .extPlugins }}
- name: graviteeio-apim-plugins
  mountPath: /opt/{{ .appName }}/plugins-ext
{{- end }}
{{- $appName := .appName -}}
{{- range $key, $_ := .extPlugins }}
- name: graviteeio-apim-{{ $key }}-ext
  mountPath: /opt/{{ $appName }}/plugins-ext/ext/{{ $key }}
{{- end }}
{{- end -}}

{{/*
Create volumes for plugins
*/}}
{{- define "deployment.pluginVolumes" -}}
{{- if or .plugins .extPlugins }}
- name: graviteeio-apim-plugins
  emptyDir: {}
{{- end }}
{{- range $key, $_ := .extPlugins }}
- name: graviteeio-apim-{{ $key }}-ext
  emptyDir: {}
{{- end }}
{{- end -}}

{{/*
Use the fullname if the serviceAccount value is not set
*/}}
{{- define "apim.serviceAccount" -}}
{{- if .Values.apim.serviceAccount }}
{{- .Values.apim.serviceAccount -}}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}