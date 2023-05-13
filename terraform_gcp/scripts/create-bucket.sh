 #!/bin/bash
 
if [[ $(gsutil ls gs://${BUCKET_NAME} >/dev/null; echo $?) -eq 1 ]]; then
    echo "===[ Bucket doesn't exist. Creating... ]==="
    gsutil mb -l us-central1 -c Standard -p $GCP_PROJECT_ID  -b off gs://$BUCKET_NAME
else
    echo "===[ Bucket already exists ]==="
fi
