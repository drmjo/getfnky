# the order of the providers there is importat as
# terraform will use the first one defined if its not
# specified in the resource block

# this one will default to the region specified by the
# AWS_DEFAULT_REGION variable
provider "aws" {
  alias = "aws.default"
}

# this provider is reserved for operations that MUST be performed
# in the us-east-1 regions like certificates for edge caching
# and some other requirements by aws
provider "aws" {
  region = "us-east-1"
  alias = "edge"
}
