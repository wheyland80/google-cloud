# Bootstrap

## Pre-Requisites

### Google Workspace or Cloud Identity

Google Cloud requires and external idenity provider, either Google Workspace or Google Cloud Identity Must Be Set Up first.

A Google Workspace account should be set up and configured using the Organisation’s custom domain (e.g., mycompany.com).
Alternatively, Google Cloud Identity (a free or paid identity service from Google) can be set up using the organisation’s domain. This allows organisations to manage users, groups, and permissions without using the full suite of Google Workspace tools (like Gmail, Drive, etc.).

Users should be added and the following group(s) created:

* **cloudadmin**: The '**cloudadmin**' group will be used to grant privileged access to the Google Cloud account. Only select 'trusted' users should be granted these permissions. The user (E.g. youruser@yourorg.com)
* Define addtional groups as required

Permissions within your Google Cloud account will be managed as groups. Any permissions assigned to the 'cloudadmin'@YOURORGDOMAIN will be granted to all members of the group.

### External Identity Providers (Optional)

If your organization uses an external identity provider (IdP) such as Microsoft Azure AD, Okta, or LDAP, you can integrate it with Google Cloud Identity or Google Workspace using SAML or OIDC for Single Sign-On (SSO).

### Google Cloud Organisation

Once Google Workspace or Cloud Identity is verified with your domain, you can enable a Google Cloud Organisation.

The Google Cloud Organisation will automatically link to your Google Workspace or Cloud Identity setup.

### Google Cloud Billing Account

Once the Google Cloud Account as been created it is necessary to create a billing account. The billing account ID will be used in further configuration sections below.

### Organisation Permissions

To configure the IAC environment within the Google Cloud org we will require the following org level roles (granted at ORG level). The following permissions should be granted to the '**cloudadmin**' group:

* Organisation Adminstrator - Permission to set ORG level policies
* Billing Admin - Permission to associate new projects/resources to your billing account
* Folder Admin - Permission to create and manage folders
* Owner - Permission to create and manage project resources
* Project IAM Admin - Permission to manage cloud identities including roles, service accounts, etc.

### Install Google Cloud SDK

Follow the official steps to install Google Cloud SDK (it includes the gcloud command line tool)

* [Install Google Cloud SDK](https://cloud.google.com/sdk/docs/install)

#### Authenticate with Google Cloud

Once installed, authenticate with org email address.

```bash
# Login to google cloud
gcloud auth login

# Set application default login
gcloud auth application-default login
```

### Install JQ CLI command

We use the **jq** Command-line JSON processor to extract the name of the OpenTofu state bucket

```bash
sudo apt update
sudo apt install jq
```

### Environment configuration

To run the initial terraform you need to configure the following environment variables

```bash
gcloud organizations list

# Google Cloud config
ORG_DOMAIN=YOURORGDOMAIN
BILLING_ACCOUNT_ID=YOURBILLINGACCOUNTID
ORG_ID=$(gcloud organizations list --format='value(ID)' --filter="displayName:$ORG_DOMAIN")
echo "Organization ID: $ORG_ID"

```

## 01-bootstrap

Run the 01-bootstrap terraform module to provision the following Google Cloud resources:

* Bootstrap Folder - A 'Bootstrap' folder to hold the 'bootstrap' project
* CICD Project - A 'CICD' project for the CICD resources necessary to provision the foundation
  * GCS state file bucket - A bucket that will contain the '01-bootstrap' and '02-foundation' IAC state files
  * Cloud Build - The cloud build CICD workflows for the IAC
* Foundation Folder - A 'Foundation' folder. This folder will contain all further resources provisined by the foundation in the 02-foundation module

Initially, the 01-bootstrap terraform will be run from your local environment. Once the bootstrap resources have been provisioned, further updates to the bootstrap resources can be made via CICD (Cloud Build). No further provisioning should happen from your local environment.

**NOTICE**: We choose Cloud Build for our CICD tooling because we are able to fully automate the provisioning and switch to Cloud Build without any further configuration. Terraform works with state files and includes a locking mechanism. As such it is possible to seamlessly switch to an alternative provider without risk. For simplicity, we recommend you fork this repo and switch to your prefered provider at a **later** stage. This way you can first evaluate this codebase before fully commiting to it.

```bash
# We use the opensource version of terraform (opentofu), switch tofu command to terraform if you use the commercial version
tofu init
tofu validate
tofu plan -var "organisation_id=$ORG_ID" -var "billing_account_id=$BILLING_ACCOUNT_ID" -out /tmp/plan.out
tofu apply /tmp/plan.out
```

### Migrate to Cloud Build

The local state file should be migrated to Google Cloud Storage

```bash
gsutil cp ./terraform.tfstate gs://$( tofu output -json terraform_state_bucket_id | jq -r . )/bootstrap/terraform.tfstate
```

Now that your bootstrap project and resources have been provisioned. Further changes to the environment should be handled via the CICD pipeline (including further 01-bootstrap terraform plan/apply). Jump to the Cloud Build section of Google Cloud to provision further resources, following the 02-foundation/README.md
