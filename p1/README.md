# Project 1: Recoverability In AWS

- Selected regions
  - Primary: `us-east-1`
  - Secondary: `ap-south-1`

- Screenshots are in `db_screenshots` and `s3_screenshots` folders

- In the directory `cloudformation`, added cloudformation stacks descriptions for primary and secondary regions.
  - `primary_region.yml`: On top of VPC description, added Database and DB subnet group
  - `secondary_region.yml`: On top of VPC, added the read replica description

- Added a VPC peering between primary and secondary VPC
  - After some route table and DNS configuration fixed, I was able to access read-replica in secondary region from an EC2 instance in primary region
  - screenshot: `db_screenshots/vpc_peering.png`

- Added a cloudfront distribution for sample S3 static site
  - endpoint: https://d2ruu6pjepeav6.cloudfront.net/
  - Setup an origin group with two origins
    - s3://ud1-vin
    - s3://ud1-vin-secondary
