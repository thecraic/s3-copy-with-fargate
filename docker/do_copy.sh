#!/bin/bash
echo "s3 file copy task"

echo "$SOURCE"
echo "$DESTINATION"
aws s3 ls $SOURCE
aws s3 ls $DESTINATION
echo "Performing copy"
aws s3 cp  $SOURCE $DESTINATION



