kind: ConfigMap 
apiVersion: v1 
metadata:
  name: {{ .Values.manager.configMap.name }}
data:
   # listen to for resource in all namespaces. Replace with namespace name to listen on a specific namespace
{{- if not .Values.manager.scope.cluster }}
  RESOURCES_NAMESPACE: {{ .Release.Namespace }}
   # setting to false will append logs in a plain text format
{{- end }}
{{- if not .Values.manager.json }}
  DEV_MODE: "false"
{{- end }}
