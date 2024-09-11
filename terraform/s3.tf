# Create a basic S3 bucket
resource "aws_s3_bucket" "evgeni_bucket" {
  bucket = "evgeni-test-bucket" 
}

# Upload a file to the bucket
resource "aws_s3_object" "sample_file" {
  bucket = aws_s3_bucket.evgeni_bucket.bucket
  key    = "sample.txt"
  source = "./../assets/sample.txt" #
  acl    = "private"              
}