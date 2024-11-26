provider "aws" {
  region = "us-east-2" # Substitua pela região desejada
}

resource "aws_s3_bucket" "bucket" {
  bucket = "meu-bucket-rafa-so-27" # Substitua por um nome único global

  tags = {
    Environment = "Dev"
    Name        = "MeuBucket"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.bucket.bucket
}

resource "aws_s3_object" "upload_files" {
  for_each = fileset("/iac/dados", "**/*")

  bucket = aws_s3_bucket.bucket.bucket
  key    = "dados/${each.value}" # Subpasta 'dados' no bucket
  source = "/iac/dados/${each.value}" 

  etag = filemd5("/iac/dados/${each.value}") # Garantir idempotência
}
