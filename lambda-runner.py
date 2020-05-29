import boto3
import json
import os

CLUSTER_NAME = os.environ["CLUSTER_NAME"]
SUBNETS = os.environ["SUBNETS"].split(",")

def lambda_handler(event,context):

  print(event)

  client = boto3.client('ecs')
  
  
  response = client.run_task(
  cluster=CLUSTER_NAME, 
  launchType = 'FARGATE',
  taskDefinition='s3-copy-task',
  count = 1,
  platformVersion='LATEST',
  networkConfiguration={
        'awsvpcConfiguration': {
            'subnets': 
                SUBNETS
            ,
            'assignPublicIp': 'DISABLED'
        }
    },
    overrides={"containerOverrides": [{
            "name": "s3-copy",
            "environment": [
                {
                        'name': 'SOURCE',
                        'value': "s3://s3-copy-example-source/file.txt"
                },
                {
                        'name': 'DESTINATION',
                        'value': "s3://s3-copy-example-destination/file.txt"
                },

            ]
        }]}
    )


  print (response)