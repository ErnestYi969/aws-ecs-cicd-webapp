# AWS ECS CI/CD Web Application

A containerized Flask web application deployed on AWS ECS Fargate.

## Architecture

Local:

Browser
↓
Docker Container
↓
Flask Application


## Tech Stack

- Python Flask
- Docker
- AWS ECS Fargate
- Amazon ECR
- Application Load Balancer
- Terraform
- GitHub Actions

## Local Run

Build image:

docker build -t ecs-cicd-demo ./app


Run container:

docker run -p 5000:5000 ecs-cicd-demo