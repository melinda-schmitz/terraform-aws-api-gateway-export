data "external" "api_export" {
    program = [
        "python3",
        "${path.module}/scripts/export_api.py",
        "--api-gateway-id=${var.api_gateway_id}",
        "--stage-name=${var.stage_name}",
        "--region=${var.region}",
        "--format=${var.format}",
        "--extensions=${var.extensions}",
        "--version=${var.openapi_version}",
        "--b64",
        "--terraform"
    ]

    query = {
        # This is just to force dependencies... Not used.
        depends_on = "${var.depends_on}"
    }
}