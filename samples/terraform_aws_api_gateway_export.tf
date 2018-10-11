module "api_gateway_export" {
    source          = "../"
    api_gateway_id  = "rg71x4z96c"
    stage_name      = "labda-environment"
    region          = "us-east-1"
    extensions      = "postman"
    format          = "json"
    openapi_version = "oas30"
}

output "api" {
    value = "${module.api_gateway_export.api_export}"
}