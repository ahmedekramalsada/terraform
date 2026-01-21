terraform {
  backend "s3" {
    bucket = "mybucket-lab-terraform"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
}

