provider "aws" {
  region = "eu-west-1"
  profile = "default"
  shared_credentials_file = "~/.aws/credentials"
  version = "~> 2.51"
}

provider "template" {
  version = "~> 2.1"
}

