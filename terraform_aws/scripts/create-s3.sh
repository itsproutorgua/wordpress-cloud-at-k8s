#!/bin/bash

bucket_name="mondyk8sbucket1911"

aws s3api head-bucket --bucket "$bucket_name"  2>/dev/null

if [[ $? -eq 0 ]]; then
  echo "Bucket $bucket_name alredy exist."
else
  aws s3api create-bucket --bucket "$bucket_name" 
  echo "Bucket $bucket_name created successfully."
fi

