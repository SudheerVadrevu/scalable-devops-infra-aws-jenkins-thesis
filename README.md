i# Design and Implementation of Scalable DevOps Infrastructure on AWS using Jenkins, Terraform, and Kubernetes

## 📘 Project Overview

This project is my master’s thesis under the course **Master Thesis in Computer Science (DV2572)** at Blekinge Institute of Technology (BTH), Sweden. It focuses on building a scalable, production-grade DevOps infrastructure. The implementation automates infrastructure provisioning and CI/CD pipelines for microservices using Jenkins, Terraform, and Kubernetes on AWS.

---

## 🚀 Key Features

- **Jenkins-based CI/CD** with Groovy pipelines and AWS CodePipeline triggers.
- **Terraform IaaC** for provisioning EKS clusters, EC2 agents, VPC, IAM, security groups.
- **Dockerized microservices** for Spring Boot applications.
- **SonarQube integration** for static code analysis via Gradle and CI job.
- **Monitoring with Grafana & Prometheus**, container metrics, and alerts.
- **Deployment comparison**: Jenkins on ECS vs EC2 agents (evaluated via experiment).

---

## 📁 Repository Structure

```yaml
.
├── app/                   # Spring Boot app source code
├── docker-images/        # Custom Jenkins agents (Dockerfile)
├── lambda/               # AWS Lambda for post-deploy testing
├── codepipeline/deploy/  # AWS CodePipeline buildspecs
├── jenkins-utils/        # Groovy shared libraries
├── k8s/yaml/             # Kubernetes manifests for Jenkins & monitoring stack
├── monitoring/           # Prometheus & Grafana dashboards
├── terraform/            # Terraform IaC for EKS, EC2, VPC, IAM
├── scripts/              # Bash/Gradle build tools
├── Jenkinsfile*          # Declarative pipeline (root)
├── buildspec.yml         # AWS CodeBuild integration
└── README.md             # You're here!
```

---

## 🔍 Evaluation Focus

| Factor                  | Implementation                                   |
|------------------------|--------------------------------------------------|
| CI/CD Tools            | Jenkins (Groovy), AWS CodePipeline               |
| Deployment Methods     | Docker + Kubernetes + EKS                        |
| IaaC                   | Terraform (modular)                              |
| Monitoring             | Prometheus + Grafana                             |
| Code Quality           | SonarQube via Gradle CI job                      |
| Artifact Registry      | DockerHub or ECR                                 |

---

## 📊 Academic Info

- 🎓 **Thesis Title**: Design and Implementation of Scalable DevOps Infrastructure on AWS using Jenkins, Terraform, and Kubernetes  
- 🧑‍🎓 **Course Name**: Master Thesis in Computer Science (DV2572)
- **Institution**: Blekinge Institute of Technology (BTH), Sweden  
- 📅 **Timeline**: October 2024 – March 2025  
- 👨‍💻 **Author**: Sudheer Vadrevu

---

## 🔗 GitHub Link

> https://github.com/SudheerVadrevu/scalable-devops-infra-aws-jenkins-thesis
