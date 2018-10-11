module "api_gateway_export" {
    source          = "rojopolis/api-gateway-export-aws"
    api_gateway_id  = "12345"
    stage_name      = "prod"
    region          = "us-east-1"
    extensions      = "postman"
    format          = "json"
    openapi_version = "oas30"
}

output "api" {
    value = "${module.api_gateway_export.api_export}"
}