# README

* `content` folder is to hold your playground content you'll use during the presentation
* `infrastructure` folder have a terraform script to deploy the audience instances

## Provision infrastructure

You'll need a `terraform.tfvars` file or you'll need to supply the variables in the command line. Please see an example file below:

```bash
vpc_id = "vpc-cd9f1ba9"
vpc_subnet_id = "subnet-aa53f3f2"
key_name = "dan2test"
aws_region = "eu-west-1"
r53_zone_id = "ZHQ86ZHWMXO1D"
inst_base_name = "mytraining" # optional
ssh_user = "playground" # optional
ssh_password = "PeoplesComputers1" # optional
```

**Notes**<br />
1. The `r53_zone_id` points to **devopsplayground.com**, so your domain name for the instance will be `<animal>.devopsplayground.com`.
2. The framework is expecting the following resources to already exist and the values to line up with those resources: vpc_id, vpc_subnet_id, key_name, aws_region. r53_zone_id. The other parameters are generted by the script using the values provided and so don't need to exit beforehand.

```bash
cd infrastructure
terraform init
terraform get
AWS_PROFILE=training terraform plan -var instances_to_deploy=1
AWS_PROFILE=training terraform apply -var instances_to_deploy=1
```

then you can browse/SSH `<animal>.devopsplayground.com`

```bash
user: playground  
pass: PeoplesComputers1
```
