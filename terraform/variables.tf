variable "Namespace" {
  default = "Default"
}

variable "Environment" {
  default = "Dev"
}

variable "Version" {
  default = "v0"
}

variable "EnableCustomDomain" {
  default = false
}

# script will look for the hosted zone of this TLD if it has access
# will create the subdomain and the proper certificates
# the certs will be in the us-east-1 regardless of any other settings
# as AWS requires the edge caches to use a cert that lives iin the us-east-1
#
# the fqdn will be
# {Version}.{SubDomain}.{TopLevelDomain}
variable "TopLevelDomain" {
  default = "mjo.io"
}

variable "SubDomain" {
  default = "api.getfnky.labs"
}
