# google-cloud

A comprehensive Google Cloud IAC (terraform) library. Includes everything you need to build (and tear down) a mature Google Cloud organisation on demand.

The purpose of this repository is to make it easy to iterate and develop Google Cloud terraform modules with minimal configuration and dependencies.

To get started, register a Google Cloud Org account (and pre-requisites including Google Workspace or Cloud Identity) and install Google Cloud SDK and OpenTofu (or Terraform).

This repository contains a set of Terraform modules to get up and running quickly provision many services via Cloud Build. You are free to switch to alternative CICD tools but those will require manual configuration. The Goal of this repository is ZERO configuration and Cloud Build provides that capability.

## Pre-requisites

## Modules

### 01 - Bootstrap

The first module in the set, Bootstap.

The bootstrap module is the only terraform you will be running locally and provisions a bootstrap folder that will hold the terraform IAC service account and state files.

### 02 - Foundation

### 03 - Gitlab

### 03 - Jenkins

### 03 - Cassandra

### 03 - RabbitMQ

### 03 - Redis

### 03 - Postgresl
