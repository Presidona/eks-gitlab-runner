# Kubernetes GitLab Runner Setup

This directory contains the Kubernetes manifests to deploy GitLab runners on the EKS cluster.

## Prerequisites

- kubectl configured to use your EKS cluster

## Setup

1. Create a Kubernetes secret with your registration token:

    ```bash
    kubectl apply -f secret.yml
    ```

2. Apply the Kubernetes deployment and service files:

    ```bash
    kubectl apply -f deployment.yml
    kubectl apply -f service.yml
    kubectl apply -f hpa.yml
    ```

3. Verify that the GitLab Runners are deployed and running:

    ```bash
    kubectl get pods -n gitlab
    ```

## Notes

- Replace placeholders like `<base64_encoded_registration_token>` with your actual values.
- The Linux GitLab Runner will auto-scale based on demand, while the Windows Runner will have a single instance.
