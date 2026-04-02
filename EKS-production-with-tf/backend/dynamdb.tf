resource "aws_dynamodb_table" "tf_dynamodb" {
  name = "eks-dynamodb-table"
  hash_key = "LockID"
  billing_mode = "PAY_PER_REQUEST"

   attribute {
    name = "LockID"
    type = "S"
   }
  
   tags = {
    Name =  "eks-dynamodb-table"
    Environment = "prod"
    Terraform   = "true"
   } 

}