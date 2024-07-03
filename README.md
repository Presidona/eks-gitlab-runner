# GitLab EKS Setup

This repository contains the necessary configurations to deploy an EKS cluster with GitLab Runners.

## Directory Structure

- `terraform/`: Contains the Terraform configurations to set up the EKS cluster.
- `k8s/`: Contains the Kubernetes manifests to deploy GitLab Runners on the EKS cluster.

## Setup

### Step 1: Set Up the EKS Cluster

1. **Navigate to the Terraform directory**:

    ```bash
    cd terraform/
    ```

2. **Initialize Terraform**:

    ```bash
    terraform init
    ```

3. **Apply the Terraform configuration**:

    ```bash
    terraform apply
    ```

4. **Configure kubectl to use the new EKS cluster**:

    ```bash
    aws eks --region <aws-region> update-kubeconfig --name <cluster-name>
    ```

### Step 2: Deploy GitLab Runners on EKS

1. **Navigate to the Kubernetes directory**:

    ```bash
    cd ../k8s/
    ```

2. **Create a Kubernetes secret with your registration token**:

    ```bash
    kubectl apply -f secret.yml
    ```

3. **Apply the Kubernetes manifests**:

    ```bash
    kubectl apply -f deployment.yml
    kubectl apply -f service.yml
    kubectl apply -f hpa.yml
    ```

4. **Verify the deployment**:

    ```bash
    kubectl get pods -n gitlab
    ```

## Notes

- Ensure that you have the necessary AWS and GitLab credentials.
- Adjust configurations as necessary for your environment.
