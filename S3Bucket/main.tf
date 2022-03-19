provider "aws" {
	region = "eu-west-1"
	profile = "PaulCarcea-terraform"
}

//Create S3 Bucket
resource "aws_s3_bucket" "MyBucket" {
  bucket = "mybucket-tf-100222"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "myFirstObject" {
  bucket = "${aws_s3_bucket.MyBucket.id}"
  key    = "testfile.txt"
  source = "../TestFiles/sampleobject.txt"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("../TestFiles/sampleobject.txt")
}