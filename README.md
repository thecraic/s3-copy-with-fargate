# S3 to S3 large file copy with fargate

This example  shows how to use fargate for copying large files from one s3 bucket to another.

The CloudFormation template creates a standard VPC architecture with public and private subnets, an ECS cluster and task definition to allow running of the fargate tasks.

A lambda function is used to trigger the Fargate task and copy the files between the buckets.

The source and destination buckets are hard coded in the lamba code, but sent in environment variables to the task at runtime.

Notes: 

*The code provided is not intendted for production use*
*The IAM role allows full S3 access - This should be scoped down*


### 1. Create the source and destination buckets.

Using the AWS CLI create a source and destination

```
aws s3 mb <source bucket name>
```

```
aws s3 mb <destination bucket name>
```

Get a large file into the source bucket for testing:

```
curl ftp://speedtest:speedtest@ftp.otenet.gr/test5Gb-a.db | aws s3 cp - s3://<source bucket name>/file.txt
```


### 2. Deploy the template.

```
aws cloudformation create-stack \
    --stack-name s3-to-s3-example \
    --capabilities CAPABILITY_IAM  \
    --template-body file://$PWD/infrastructure.yml
```

### 3. Modify the lamda function

Open the AWS Lambda Console and replace the source & destination bucket/object parameters for the task with your own bucket/object values.

Create a test event and trigger the ECS task.

Progress can be monitored in CloudWatch Logs.





