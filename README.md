# google-cloud

A comprehensive Google Cloud IAC (terraform) library. Includes everything you need to build (and tear down) a mature Google Cloud organisation on demand.

This repository contains a set of Terraform modules to quickly provision many services.

The modules are numbered in the order that they should be provisioned. Modules with the same number can be provisioned in any order following modules provisioned with lower numbers.

## Pre-requisites



## Modules

### 01 - Bootstrap

The first module in the set, Bootstap.

The bootstrap module is the only terraform you will be running locally and provisions a bootstrap folder that will hold the terraform IAC service accounts and state files.

### 02 - Foundation

### 03 - Gitlab

### 03 - Jenkins

### 03 - Cassandra

### 03 - RabbitMQ

### 03 - Redis

### 03 - Postgresl
