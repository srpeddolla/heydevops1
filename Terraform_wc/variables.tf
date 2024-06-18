variable "AWS_REGION" {
    default = "us-west-2"
}
variable "s3_bucket_name" {
  default = "srpeddollas"
}
variable "AMI" {
    type = map(string)

    default = {
        us-west-2 = "ami-0b20a6f09484773af"        
        }
}
variable "PUBLIC_KEY_PATH" {
    default = "D:/Github/heydevops/Terraform_wc/oregon-region-key-pair.pub"
}