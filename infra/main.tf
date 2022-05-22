terraform {
  backend "s3" {
    bucket            = "rmit-tfstate-skl2x1"
key               = "assignment-2/infra-deployment"
region            = "us-east-1"
dynamodb_endpoint = "https://dynamodb.us-east-1.amazonaws.com"
dynamodb_table    = "rmit-locktable-skl2x1"
}
}


provider "aws" {
  region = "us-east-1"
}

