identity_token "aws" {
  audience = ["aws.workload.identity"]
}

identity_token "k8s" {
  audience = ["k8s.workload.identity"]
}


deployment "development" {
  inputs = {
    aws_identity_token = identity_token.aws.jwt
    role_arn            = "arn:aws:iam::931787512616:role/stacks"
    regions             = ["eu-central-1"]
    vpc_name = "vpc-dev1"
    vpc_cidr = "10.0.0.0/16"

    #EKS Cluster
    kubernetes_version = "1.30"
    cluster_name = "eksdev03"
    
    #EKS OIDC
    tfc_kubernetes_audience = "k8s.workload.identity"
    tfc_hostname = "https://app.terraform.io"
    tfc_organization_name = "liamcervante"
    eks_clusteradmin_arn = "arn:aws:iam::931787512616:role/aws_liam.cervante_test-developer"
    eks_clusteradmin_username = "aws_liam.cervante_test-developer"

    #K8S
    k8s_identity_token = identity_token.k8s.jwt
    namespace = "hashibank"

  }
}
