terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
    }
  }

  required_version = ">= 0.14.9"
}

<<<<<<< HEAD

=======
>>>>>>> c541bbf8e5e4708762ac6ddd6298ce12de337683
provider "aws" {
  profile = "default"
  region  = var.region
}
