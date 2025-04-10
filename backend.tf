
# Run first terraform-10-30am/day-4-resources_for_backend_s3_dynamodb to create reources 
# This backend configuration instructs Terraform to store its state in an S3 bucket.
 terraform {
backend "s3" {
    bucket         = "bucket_name"  # Name of the S3 bucket where the state will be stored.
    region         = "region_name"
    key            = "terraform.tfstate" # Path within the bucket where the state will be read/written.
    encrypt        = true  # Ensures the state is encrypted at rest in S3.
}
}
