# aws.env file must be present at the root

IT:=-it
DEFAULT_USER:=default
STATE_FILE:=tmp/tfstate/${DEFAULT_USER}.tfstate
TFVARS_FILE:=tmp/tfvars/${DEFAULT_USER}.tfvars

define TERRAFORM_CLI
docker run ${IT} --rm \
  --env-file `pwd`/aws.env \
	-v `pwd`:/home/terraform/stack \
	-v `pwd`.terraform:/home/terraform/.terraform \
  -w /home/terraform/stack \
  --hostname getfnky \
  drmjo/terraform:0.11.7
endef

define TERRAFORM_APPLY
${TERRAFORM_CLI} /bin/terraform apply \
  --var-file=${TFVARS_FILE} \
	--state ${STATE_FILE}
endef

define TERRAFORM_PLAN
${TERRAFORM_CLI} /bin/terraform plan \
	--var-file=${TFVARS_FILE} \
	--state ${STATE_FILE}
endef

define AWS_CLI
docker run ${IT} --rm \
  --env-file `pwd`/aws.env \
  -v `pwd`:/home/aws/workdir \
  -w /home/aws/workdir \
  --hostname getfnky \
  drmjo/aws:latest
endef

# Bin Bash will grant you a shell inside
.PHONY: aws
aws:
	${AWS_CLI} /bin/bash

.PHONY: terraform
terraform:
	${TERRAFORM_CLI} /bin/bash

# bootstrapping functions
.PHONY: terraform-init
terraform-init:
	${TERRAFORM_CLI} /bin/terraform init terraform/

# terraform plan and apply
.PHONY: plan
plan: terraform-init
	${TERRAFORM_PLAN} terraform/

.PHONY: apply
apply:
	${TERRAFORM_APPLY} terraform/

# build binary from git repo
.PHONY: build
build:
	go get -u github.com/anthoneous/getfnky


# lambda bucket create example
# .PHONY: create-lambda-bucket
# create-lambda-bucket:
# 	${TERRAFORM_APPLY} \
# 	--target aws_s3_bucket.lambda_bucket \
# 	terraform/
