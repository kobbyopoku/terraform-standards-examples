provider "aws" {
  version = "~> 1.2"
  region  = "us-west-2"
}

module "base_network" {
  source   = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork?ref=v0.0.6"

  vpc_name = "VPC-Endpoint-Test"
}

module "security_groups" {
  source        = "git@github.com:rackspace-infrastructure-automation/aws-terraform-security_group?ref=v0.0.5"

  resource_name = "test_sg"
  vpc_id        = "${module.base_network.vpc_id}"
}

module "vpc_endpoint" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_endpoint?ref=v0.0.4"

  codebuild_endpoint_enable               = true
  codebuild_private_dns_enable            = true
  codebuild-fips_endpoint_enable          = false
  codebuild-fips_private_dns_enable       = false
  dynamo_db_endpoint_enable               = true
  ec2_endpoint_enable                     = true
  ec2_private_dns_enable                  = true
  ec2messages_endpoint_enable             = true
  ec2messages_private_dns_enable          = true
  elasticloadbalancing_endpoint_enable    = true
  elasticloadbalancing_private_dns_enable = true
  events_endpoint_enable                  = true
  events_private_dns_enable               = true
  execute-api_endpoint_enable             = true
  execute-api_private_dns_enable          = true
  kinesis-streams_endpoint_enable         = true
  kinesis-streams_private_dns_enable      = true
  kms_endpoint_enable                     = true
  kms_private_dns_enable                  = true
  logs_endpoint_enable                    = true
  logs_private_dns_enable                 = true
  monitoring_endpoint_enable              = true
  monitoring_private_dns_enable           = true
  route_tables_ids_list                   = "${module.base_network.private_route_tables}"
  s3_endpoint_enable                      = true
  sagemaker_runtime_endpoint_enable       = true
  sagemaker_runtime_private_dns_enable    = true
  secretsmanager_endpoint_enable          = true
  secretsmanager_private_dns_enable       = true
  security_group_ids_list                 = ["${module.security_groups.vpc_endpoint_security_group_id}"]
  servicecatalog_endpoint_enable          = true
  servicecatalog_private_dns_enable       = true
  sns_endpoint_enable                     = true
  sns_private_dns_enable                  = true
  ssm_endpoint_enable                     = true
  ssm_private_dns_enable                  = true
  subnet_ids_list                         = "${module.base_network.private_subnets}"
  vpc_id                                  = "${module.base_network.vpc_id}"
}
