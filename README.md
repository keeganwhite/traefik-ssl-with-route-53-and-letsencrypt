# Automated SSL Generation for Traefik
Set up Traefik with SSL using Let's Encrypt and a Route 53 domain on an AWS EC2 Instance. Traefik will act as a reverse proxy and auto-renew your certificates! This means you can host services on this domain using Docker. Just remember to add DNS entries in your Route53 entries to point to the IP address of your EC2 instance.

## Prerequisites
- Install docker and docker compose
- Set up Roles and Policies (see below)

## Run the code
If you have set up the EC2 instance with the correct roles and policies you can run the code as follows:
```
docker compose up -d
```
## Allowing Traefik Access to Route53

General process to create allow Traefik to manage your domain, although you should take as many security precautions as possible and do your own 
research on the implication of these roles...
#### Create an IAM Policy
- Go to the IAM console in AWS. 
- Create a new policy. 
- Grant permissions that allow changes to Route53. A typical policy might include actions like
  `route53:GetChange`, `route53:ChangeResourceRecordSets`, `route53:ListResourceRecordSets`, `route53:ListHostedZonesByName` and `route53:ListHostedZones`. Restrict the resource to the 
specific hosted zone ID that Traefik will be working with.
#### Create an IAM Role
- In IAM console, create a new role.
- Attach the policy you created in the previous step. 
- If Traefik is running on an EC2 instance, choose EC2 as the trusted entity. If it's running on Kubernetes in EKS, 
choose EKS or the appropriate entity.
#### Attach the Role to the Traefik Instance
- Attach the role to the EC2 instance where Traefik is running.
