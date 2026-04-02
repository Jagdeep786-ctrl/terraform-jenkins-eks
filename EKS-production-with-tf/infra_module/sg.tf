
#sg for ekscluster
resource "aws_security_group" "eks_cluster_sg" {
    vpc_id = module.vpc.vpc_id
    name = "${local.env}-cluster-sg"

 
    ingress {
        description = "allow HTTPs acess"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "allow all outbound traffic"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"] 
    }
     
     
         
    tags = {
      Name = "${local.env}-cluster-sg-TF"
    } 


}




#
#👉 Why not open port 80/22 on cluster SG?
#“Because EKS control plane only exposes Kubernetes API over HTTPS (443). Application traffic and SSH should go through worker nodes or load balancers, not directly to the control plane.”



