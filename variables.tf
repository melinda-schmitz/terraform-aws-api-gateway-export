variable "api_gateway_id" {
    description = "ID of api_gateway resource"
    type        = "string"
}

variable "stage_name" {
    description = "Name of API Gateway stage to generate SDK from"
    type        = "string"
}

variable "region" {
    description = "Name of AWS Region"
    type        = "string"
}

variable "extensions" {
    description = <<EOF
        You can append the extensions query string to specify whether to include
        API Gateway extensions (with the integration value) or Postman
        extensions (with the postman value). 
    EOF
    type        = "string"
    default     = ""
}

variable "openapi_version" {
    description = "Version of the open API spec to export. 'swagger' or 'oas30'."
    type        = "string"
    default     = "swagger"
}

variable "format" {
    description = "Data format of the open API spec to export.  json or yaml."
    type        = "string"
    default     = "json"
}
