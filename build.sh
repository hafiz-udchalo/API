#export AWS_DEFAULT_OUTPUT="text"
#export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
#export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY

export AWS_DEFAULT_REGION=us-east-1
export STACK=$NODE_ENV-Test-API-Gateway


# Replace the <NODE_ENV> with the real value

sed -i='' "s/<NODE_ENV>/$NODE_ENV/g" ENV.txt


# Give the name of your deployment bucket name

export BUCKET="deployment-bucket-for-api-gateway"
echo $STACK
echo $BUCKET
#aws s3 mb s3://$BUCKET

#aws s3 cp swagger.yaml s3://$BUCKET

# Uploads files to S3 bucket and creates CloudFormation template
#sam package --template-file template.yaml --s3-bucket $BUCKET --output-template-file package.yaml

# Deploys your stack   
#sam deploy --template-file package.yaml --stack-name $STACK --capabilities CAPABILITY_IAM



# Delete CloudFormation Stack
#aws cloudformation delete-stack --stack-name $STACK

# Delete non-empty bucket
#aws s3 rb s3://$BUCKET --force
