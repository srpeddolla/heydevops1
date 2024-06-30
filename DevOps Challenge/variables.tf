variable "region" {
  description = "AWS region"
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]  // Adjust as per your region's availability zones
}
