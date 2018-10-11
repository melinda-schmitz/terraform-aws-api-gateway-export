import base64
import click
import json
import requests

from aws_requests_auth.boto_utils import BotoAWSRequestsAuth


@click.command()
@click.option('--api-gateway-id', help='ID of the API Gateway.', required=True)
@click.option('--stage-name', help='Name of the API Gateway Stage',
              required=True)
@click.option('--region', help='AWS Region of the API Gateway.', required=True)
@click.option('--extensions', help='API Gateway Extensions to include.',
              type=click.Choice(['postman', 'integrations']), default=None)
@click.option('--format', help='Format of the export',
              type=click.Choice(['json', 'yaml']), default='json')
@click.option('--version', help='OpenAPI version to export',
              type=click.Choice(['swagger', 'oas30']), default='swagger')
@click.option('--b64/--no-b64', help='base64 encode export',
              is_flag=True, default=False)
@click.option('--outfile', help='Save exported API to file',
              type=click.File('wb'))
@click.option('--terraform', help='Format output for consumption by Terraform',
              is_flag=True, default=False)
def export_api(**kwargs):
    host = f'apigateway.{kwargs["region"]}.amazonaws.com'
    endpoint = f'https://{host}/restapis/{kwargs["api_gateway_id"]}/stages/{kwargs["stage_name"]}/exports/{kwargs["version"]}'
    auth = BotoAWSRequestsAuth(aws_host=host,
                               aws_region=kwargs["region"],
                               aws_service='apigateway')

    if kwargs.get('extensions'):
        endpoint += f'?extensions={kwargs["extensions"]}'

    response = requests.get(endpoint, auth=auth,
                            headers={'Accept': f'application/{kwargs["format"]}'})
    response.raise_for_status()

    result = response.text.encode('ascii')
    if kwargs.get('b64'):
        result = base64.b64encode(result)

    if kwargs.get('terraform'):
        result = json.dumps({'result': result.decode('utf-8')})

    if kwargs.get('outfile'):
        kwargs.get('outfile').write(result)
    else:
        click.echo(result)

if __name__=='__main__':
    export_api()
