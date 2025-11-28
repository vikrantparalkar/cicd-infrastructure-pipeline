# GitOps on AWS EKS with ArgoCD and NGINX

This repository explains how to provision an **Amazon EKS cluster** with **Terraform**, install **ArgoCD** for GitOps, and deploy an **NGINX application** that is exposed publicly via a LoadBalancer.

---

## 1. Steps to Provision the Cluster
- Install and configure AWS CLI with appropriate IAM credentials.  
- Use Terraform to provision the EKS cluster and supporting resources (VPC, subnets, IAM roles, node groups).  
- After Terraform completes, update your local kubeconfig to connect `kubectl` to the new cluster by cmd "terraform output kubeconfig > ./eks-kubeconfig.yaml" and "export KUBECONFIG=./eks-kubeconfig.yaml" OR can directly get the cluster joining output by cmd "terraform output eks_update_kubeconfig_command" by just enabling the terraform/outputs.tf line 25 comment
- use AWS CLI cmd "aws eks update-kubeconfig --region <region> --name <cluster_name>" 
- Verify that the cluster is active and worker nodes are in the `Ready` state.  

---

## 2. ArgoCD Installation and Login Instructions
- Create a dedicated namespace called `argocd`.  
- Install ArgoCD using the official manifests.  
- Expose the ArgoCD server service as a **LoadBalancer** so it receives a public endpoint.
- Retrieve the external IP or DNS name of the ArgoCD service from the cluster.  
- Obtain the initial admin password from the ArgoCD secret in the `argocd` namespace.  
- Log in to ArgoCD either via the CLI or by opening the ArgoCD web UI in a browser using the LoadBalancer URL.  
- Use the `admin` username and the retrieved password for the first login.  

---

## 3. Deploying NGINX via ArgoCD
- Create an ArgoCD Application resource that points to your GitHub repository containing the NGINX manifests.  
- Ensure the Application is configured to track the correct branch and path in the repository.  
- ArgoCD will automatically sync the manifests from GitHub into the target namespace in your cluster.  
- Confirm that the NGINX pods are running successfully.

---

## 4. Exposing NGINX Publicly
- Define a Kubernetes Service of type **LoadBalancer** for the NGINX deployment.  
- Apply the service manifest so that AWS provisions an external LoadBalancer.  
- Retrieve the external IP or DNS name of the NGINX service from the cluster.  
- **Application**: points to GitHub repo with NGINX manifests.  
- **NGINX**: deployed and exposed via LoadBalancer service, accessible publicly.
