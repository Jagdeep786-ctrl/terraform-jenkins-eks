module "eks" {
  source =  "terraform-aws-modules/eks/aws"
  version = ">= 21.0.0"
  name = local.name
  kubernetes_version = "1.31"
  authentication_mode = "API_AND_CONFIG_MAP"
  enable_cluster_creator_admin_permissions = true  #This automatically grants admin access to the IAM identity that created the cluster.
  endpoint_public_access = true
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  create_iam_role = false
  iam_role_arn    = aws_iam_role.eks_cluster_role.arn
  additional_security_group_ids = [ aws_security_group.eks_cluster_sg.id ]
   

  addons = {
    vpc-cni = {
      before_compute = true
      most_recent    = true
    }

    kube-proxy = {
      most_recent = true
    }

    coredns = {
      most_recent = true
    }
  }

  eks_managed_node_groups = {
    tf-cluster-ng = {
        instance_types = ["t3.small"]
        min_size = 2
        max_size =3
        desired_size = 2
        capacity_type = "SPOT"

        create_iam_role = false
        iam_role_arn    = aws_iam_role.eks_node_role.arn


        tags = {
           Name        = "tf-cluster-ng"
           Environment = local.env
           Terraform   = "true"
        }

    }
  }
  
   tags = {
     Environment = local.env
     Terraform = "true"   
    }


}



############################################
# EKS ACCESS ENTRY (IAM user → EKS access)   you are telling EKS:

#“This IAM user is allowed to access this cluster”
############################################

resource "aws_eks_access_entry" "tier_user" {
  cluster_name  = module.eks.cluster_name
  principal_arn = "arn:aws:iam::210190732631:user/3tier"
  type          = "STANDARD"
  depends_on = [module.eks]

  tags = {
    Environment = local.env
    Terraform   = "true"
  }
}

############################################
# ATTACH ADMIN POLICY TO USER
#“This user has ADMIN access to the cluster”
############################################


#You are assigning permissions to that user


resource "aws_eks_access_policy_association" "tier_user_admin" {
  cluster_name  = module.eks.cluster_name
  principal_arn = aws_eks_access_entry.tier_user.principal_arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}


##terraform apply
#aws sts get-caller-identity
#aws eks list-access-entries --cluster-name eks-cluster-terraform --region us-east-1 --no-cli-pager
#aws eks update-kubeconfig --region us-east-1 --name eks-cluster-terraform
#kubectl get nodes

# jet tu pella apply kita project fr tenu error milu ga  list-access-entry da  so apply this  , jo niche likha
#terraform import "aws_eks_access_entry.tier_user" "eks-cluster-terraform:arn:aws:iam::210190732631:user/3tier"





#just for know if gett enable_cluster_creator_admin_permissions
#aws --no-cli-pager eks delete-access-entry --cluster-name eks-cluster-terraform --principal-arn arn:aws:iam::210190732631:user/3tier --region us-east-1