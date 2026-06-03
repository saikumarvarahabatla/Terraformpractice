terraform {
    backend "s3" {
    bucket = "day1bucketsai"
    key = "terraform.tfstate"
    region = "us-east-1"
}
}