# COSC2759 Assignment 2
## Notes App - CD
- Full Name: **Steven Loek**
- Student ID: **S3808553**




#  Assignment 2
### 1. Analysis of the problem
Alpine Inc. have been using manual clickOps, which is prone to human error. Kubernetes and containers are an option but Alpine inc. think they are not ready with using those, so they would like to use EC2 instances.  
### 1.1 Solution
Developing an infrastructure on AWS using terraform,deploying an application to EC2 using ansible, and using GitHub Actions to automate the deployment to understand the issues associated with deploying software systems and how to manage risk in a CD environment. Also understanding issues involved in ensuring system qualifies to meet the non-functional requirements of a system.
### 1.2 Diagram
<img src="/img/awsDiagram.png" style="height: 70px;"/>


## 2. Step by Step Deployment Guide
### 2.1 VPC
*  Have Terraform and aws cli tools installed. 
*  Login to the AWS academy
* Edit the ~/.aws/credentials aws_access_key_id, aws_secret_access_key, aws_session_token
* fill in the vpc.tf file
* run terraform validate and terraform fmt
* run terraform plan and terraform apply after

###2.2 Database
* fill in the db.tf file if not done
* Run terraform Validate, format and plan to verify the changes
* Run "terraform apply --auto-approve" after verifying the changes

## 3. limitations of using a single ec2 instance to deploy a database
additional measures have to be taken to enable fault tolerance.  the servers may need some maintenance and you may experience downtime.
other options would be: 
*  EC2 instance can be part of a Highly Available configuration which consists of two instances, each one running in a different AZ in the same region with its own copy of the data. The redundant data copies are synchronously mirrored, providing access to the data in different AZs.
*  use a managaed service like DocumentDb or MongoDB Atlas
*  use Amazon RDS DB instance
