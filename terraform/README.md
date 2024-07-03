# Terraform GitLab EKS Setup

This directory contains the Terraform configuration files to set up an EKS cluster for running GitLab runners.

## Prerequisites

- AWS CLI configured
- Terraform installed

## Setup

1. Initialize Terraform:

    ```bash
    terraform init
    ```

2. Apply the Terraform configuration:

    ```bash
    terraform apply
    ```

3. Configure kubectl to use the new EKS cluster:

    ```bash
    aws eks --region <aws-region> update-kubeconfig --name <cluster-name>
    ```