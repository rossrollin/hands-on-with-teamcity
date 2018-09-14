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
```

Note: The `r53_zone_id` points to *devopsplayground.com*, so your domain name for the instance will be `<animal>.devopsplayground.com`
Note2: Right now the WebTTY (wetty) is executed as part of a user_data script, and if you restart the instance it won't restart (PR-s welcome)

```bash
cd infrastructure
terraform init
terraform get
AWS_PROFILE=training terraform plan -var instances_to_deploy=1
AWS_PROFILE=training terraform apply -var instances_to_deploy=1

```

then you can browse/SSH `<animal>.devopsplayground.com`

user: playground
pass: PeoplesComputers1