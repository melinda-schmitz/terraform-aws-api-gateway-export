output "api_export" {
    description = "Plantext API Export document"
    value       = "${base64decode(data.external.api_export.result.result)}"
}

output "api_export_b64" {
    description = "Base64 encoded API Export document"
    value = "${data.external.api_export.result.result}"
}

output "depends_on" {
    description = "Dummy output to force dependency on external resource."
    value       = "${var.depends_on}"
}