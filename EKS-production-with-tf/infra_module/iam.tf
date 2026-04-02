resource "aws_iam_role" "eks_cluster_role" {
   name = "${local.env}-eks-cluster-role"


    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
    })


}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
   role       = aws_iam_role.eks_cluster_role.name
   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}



resource "aws_iam_role" "eks_node_role" {
  name = "${local.name}-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "${local.name}-eks-node-role"
    Environment = local.env
    Terraform   = "true"
  }
}


resource "aws_iam_role_policy_attachment" "worker_node_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "cni_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ecr_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}




resource "aws_iam_policy" "eks_access_entry_admin" {
  name        = "${local.name}-eks-access-entry-admin"
  description = "Allow managing EKS access entries and access policies"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "eks:ListClusters",
          "eks:DescribeCluster",
          "eks:ListAccessEntries",
          "eks:DescribeAccessEntry",
          "eks:CreateAccessEntry",
          "eks:UpdateAccessEntry",
          "eks:DeleteAccessEntry",
          "eks:ListAccessPolicies",
          "eks:AssociateAccessPolicy",
          "eks:DisassociateAccessPolicy"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "tier_user_eks_access_admin_attach" {
  user       = "3tier"
  policy_arn = aws_iam_policy.eks_access_entry_admin.arn
}





# Create IAM Policy in iam.tf  for s3 bucket and dynamodb   



resource "aws_iam_policy" "terraform_permissions" {
  name        = "${local.name}-terraform-permissions"
  description = "Permissions for Terraform user to create S3, DynamoDB, EKS infra"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [

      # ✅ S3 permissions (for backend + general use)
      {
        Effect = "Allow"
        Action = [
          "s3:CreateBucket",
          "s3:DeleteBucket",
          "s3:PutBucketVersioning",
          "s3:PutEncryptionConfiguration",
          "s3:PutBucketPublicAccessBlock",
          "s3:PutBucketTagging",
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = "*"
      },

      # ✅ DynamoDB (state locking)
      {
        Effect = "Allow"
        Action = [
          "dynamodb:CreateTable",
          "dynamodb:DeleteTable",
          "dynamodb:DescribeTable",
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:DeleteItem"
        ]
        Resource = "*"
      },

      # ✅ EKS (you are already using it)
      {
        Effect = "Allow"
        Action = [
          "eks:*"
        ]
        Resource = "*"
      },

      # ✅ EC2 (needed for VPC + nodes)
      {
        Effect = "Allow"
        Action = [
          "ec2:*"
        ]
        Resource = "*"
      },

      # ✅ IAM (important for roles you created)
      {
        Effect = "Allow"
        Action = [
          "iam:CreateRole",
          "iam:DeleteRole",
          "iam:AttachRolePolicy",
          "iam:DetachRolePolicy",
          "iam:PassRole"
        ]
        Resource = "*"
      }

    ]
  })
}

# Attach Policy to IAM User

resource "aws_iam_user_policy_attachment" "terraform_user_attach" {
  user       = "3tier"
  policy_arn = aws_iam_policy.terraform_permissions.arn
}