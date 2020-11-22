aws cloudformation create-stack --stack-name ud1-test --region us-east-1 --template-body file://primary_region.yml --parameters file://primary_params.json
aws cloudformation create-stack --stack-name ud1-test-standby --region ap-south-1 --template-body file://secondary_region.yml --parameters file://secondary_params.json
