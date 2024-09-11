# Unleash Devops Home Exercise

This repository contains an node Express server written in TypeScript that hosts an endpoint to check if a file exists in a specified S3 bucket. 

`GET /check-file?fileName=myfile.txt`

## Configuration

The following environment variables needs to be configured in the server:
- BUCKET_NAME
- PORT - (Default to 3000 if not specified)

## Tasks

### 1. Dockerization

Dockerize the server using best practices.

### 2. Continuous Integration (CI)

Set up a CI process using your preferred CI tool (e.g., GitHub Actions, GitLab CI, Azure Pipelines):

- Configure the CI pipeline to build and push a Docker image to a Docker registry on every commit to the main branch.

### 3. Continuous Deployment (CD)

Enhance the CI pipeline to include a CD stage:

- Automate the deployment of the Docker image to a cloud environment.
- Ensure the CD process deploys the service and its dependencies (e.g., the S3 bucket) in a robust, reproducible, and scalable manner.
- Apply infrastructure as code principles where appropriate.

**Note**: The infrastructure of the service (where this service runs) doesn't have to be managed as infrastructure as code within this repository.

---

# Work Done
## Server:
1. Added AWS Secrets support to allow access to s3

## Docker image
1. Created a basic Dockerfile from 18-alpine.
2. Work env configuration and missing dependencies.
3. Built a local docker image.
4. Run a container and see if it doesn't crash

## Helm
1. Create a helm chart for the application
2. Use simple load balancer service to expose the app

## Terraform
1. Create an S3 bucket: evgeni-test-bucket with a sample.txt file
2. Create EKS cluster
3. Create network components
4. Create security group resources

## Github
1. Create pipeline secrets
    * AWS_ACCESS_KEY_ID
    * AWS_SECRET_ACCESS_KEY
2. Create a basic CI pipeline
3. Insert CD functionality

## Final
1. Test app

---
