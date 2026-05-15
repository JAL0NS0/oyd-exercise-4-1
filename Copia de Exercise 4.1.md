# **Exercise 4.1 — Log Archive and User Event Ledger**

**Course:** Optimizaciones y Desempeño — Cloud Deployment Automation  
**Session:** 4 — May 14, 2026  
**Time allowed:** 30 minutes  
**Submission:** Initialize a new repository called oyd-exercise-4-1 and commit/push everything into it. Submit the repository URL only.

# Context

You are automating the storage layer for a logistics platform. The platform needs two standalone Terraform modules: one for archiving application logs in S3, and one for tracking user events in DynamoDB. Write both modules from scratch using the patterns demonstrated in class today.

Start from the following provider.tf. Create a new directory, place this file in it, and do not modify it.

### provider.tf

terraform {  
  required\_providers {  
    aws \= {  
      source  \= "hashicorp/aws"  
      version \= "\~\> 5.0"  
    }  
  }  
}  
provider "aws" {  
  region \= var.region  
}

# Setup

## Prerequisites

* AWS CLI configured with credentials that can create S3 buckets and DynamoDB tables in your region.  
* Terraform \>= 1.8 installed and on PATH.  
* A new empty directory initialized as a Git repository. Place the provider.tf above inside it.  
* No starter state file — this workspace is fresh.

# Tasks

## Task 1 — S3 Log Archive Module

Create a reusable Terraform module at modules/log-archive/ with separate variables.tf, main.tf, and outputs.tf files.

The module must satisfy all of the following:

* Accept at minimum the following input variables, each with a type and description: bucket\_name (string) — base name for the bucket; environment (string) — deployment environment; log\_prefix (string, default "logs/") — prefix for the lifecycle rule.  
* Enable versioning on the bucket.  
* Define a lifecycle rule scoped to var.log\_prefix that expires noncurrent object versions after 60 days. The filter prefix must reference the variable — do not hardcode it.  
* Enable SSE-S3 encryption (sse\_algorithm \= "AES256").  
* Attach a bucket policy that denies all requests where aws:SecureTransport is false. Include both the bucket ARN and the /\* suffix in the Resource array.  
* Expose at minimum two outputs with descriptions: bucket\_arn and bucket\_name.

## Task 2 — DynamoDB User Events Module

Create a reusable Terraform module at modules/user-events/ with separate variables.tf, main.tf, and outputs.tf files.

The module must satisfy all of the following:

* Accept at minimum the following input variables, each with a type and description: table\_name (string) — base name for the table; environment (string) — deployment environment.  
* Set billing\_mode \= "PAY\_PER\_REQUEST".  
* Use user\_id (type String) as the hash key and created\_at (type String) as the range key.  
* Declare a Global Secondary Index named order-status-index with hash key order\_status (String), range key created\_at, and projection\_type \= "ALL". Declare order\_status as an attribute block.  
* Enable TTL with attribute\_name \= "expires\_at" and enabled \= true.  
* Enable server-side encryption with server\_side\_encryption { enabled \= true }.  
* Expose at minimum two outputs with descriptions: table\_name and table\_arn.

## Task 3 — Root Module

* Create main.tf at the root calling both modules with appropriate input values.  
* Create variables.tf with at minimum environment (string) and region (string) as root variables, each with a description.  
* Create terraform.tfvars with environment \= "dev" and your chosen region.  
* Define at least one root output referencing each module's outputs — both must appear in terraform output.  
* Run terraform init. Then run terraform apply \-var-file=terraform.tfvars. Both the S3 bucket and the DynamoDB table must be actually provisioned.

## Task 4 — Evidence

After a successful apply, capture and commit the following:

* Run terraform state list. Save the full output to evidence/state-list.txt.  
* Run terraform output. Save the full output to evidence/outputs.txt.  
* Create README.md. Under a \#\# Evidence section, render both files inline as fenced code blocks.

# Acceptance Criteria

* modules/log-archive/ exists with separate variables.tf, main.tf, and outputs.tf.  
* modules/user-events/ exists with separate variables.tf, main.tf, and outputs.tf.  
* All variables in both modules have type and description. All outputs have description.  
* S3 module: versioning enabled; lifecycle rule has a filter block with prefix referencing a variable; SSE-S3 configured; bucket policy denies non-SSL with both bucket ARN and /\* in Resource.  
* DynamoDB module: order-status-index GSI defined with explicit projection\_type \= "ALL"; order\_status declared as an attribute block; TTL enabled; SSE enabled.  
* Both modules called from root main.tf with no environment-specific values hardcoded in module calls.  
* At least one root output per module is present in terraform output.  
* evidence/state-list.txt and evidence/outputs.txt committed and rendered inline in README.md.  
* No hardcoded region or environment strings inside module resource blocks — values come from variables.

