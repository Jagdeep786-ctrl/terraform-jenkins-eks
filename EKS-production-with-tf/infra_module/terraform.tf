terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.36"
    }
  }

  # backend "s3" {
  #   bucket = "bucket-8268-tf-cluster"
  #   region = "us-east-1"
  #   key = "infra_module/terraform.tfstate"
  #   dynamodb_table = "eks-dynamodb-table"

  # }


}






# terraform force-unlock <lockid>  to remove lockid 


# terraform init
#rm terraform.tfstate
#rm terraform.tfstate.backup

#terraform init -reconfigure

# 
# terraform init -migrate-state # first comment  backend with #, # you can get tfstate file back from s3 to local