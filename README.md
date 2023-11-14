# Automated SSL Generation for Traefik
Set up Traefik with SSL using Let's Encrypt and a Route 53 domain on an AWS EC2 Instance.

## Prerequisites
- Install docker and docker compose
- Set up Roles and Policies (see below)

## Run the code
If you have set up the EC2 instance with the correct roles and policies you can run the code as follows:
```
docker compose up -d
```
## Getting Key and Zone

### Hosted Zone
On your AWS Console navigate to Route 53, select your hosted zone and get the hosted zone ID that will appear when you 
select the zone like so:

![hosted-zone](images/hosted-zone-id.png)

### Key
General process to create a key, although you should take as many security precautions as possible and do your own 
research on the implication of these roles...
#### Create an IAM Policy
- Go to the IAM console in AWS. 
- Create a new policy. 
- Grant permissions that allow changes to Route53. A typical policy might include actions like route53:ListHostedZones
  `route53:GetChange`, `route53:ChangeResourceRecordSets` and `route53:ListHostedZones`. Restrict the resource to the 
specific hosted zone ID that Traefik will be working with.
#### Create an IAM Role
- In IAM console, create a new role.
- Attach the policy you created in the previous step. 
- If Traefik is running on an EC2 instance, choose EC2 as the trusted entity. If it's running on Kubernetes in EKS, 
choose EKS or the appropriate entity.
#### Attach the Role to the Traefik Instance
- Attach the role to the EC2 instance where Traefik is running.