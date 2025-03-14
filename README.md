# DevOps Demo

## Introduction

This is the implementation of my master thesis project.  The implementation includes:

* DevOps toolchain for software development teams, the continuous delivery pipeline implemented with on Jenkins and AWS DevOps respectively (for comparison in experiment)

* Terraform infrastructure for
  * Jenkins cluster with build agents on ECS and EC2 (for  comparison in experiment).
  * Networking and security groups
  * EKS cluster for deployment

* Case project for testing the DevOps toolchains, a simple rest-api implemented with Spring Boot.

## Directory Structure

* `app`: Spring Boot application
* `k8s`: Kubernetes deployment definition
* `terraform`: Terraform configuration files for cloud recourse creation.
* `docker-images`: Dockerfile of self-modified Dockerized Jenkins build agent.
* `codepipeline`: Configuration files for blue-green deployment with AWS CodePipeline.