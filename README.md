# GitLab EKS Setup

This repository contains the necessary configurations to deploy an EKS cluster with GitLab Runners and manage Kubernetes resources using Terraform.

## Prerequisites

- AWS CLI configured
- Terraform installed
- kubectl configured to use your EKS cluster

## Setup

1. Clone the repository and navigate to the Terraform directory:

    ```bash
    git clone https://github.com/your-repo/gitlab-eks-setup.git
    cd gitlab-eks-setup
    ```

2. Initialize Terraform:

    ```bash
    terraform init
    ```

3. Apply the Terraform configuration:

    ```bash
    terraform apply
    ```

4. Verify the deployment:

    ```bash
    kubectl get pods -n gitlab
    ```

## Notes

- Ensure that you have the necessary AWS and GitLab credentials.
- Adjust configurations as necessary for your environment.
