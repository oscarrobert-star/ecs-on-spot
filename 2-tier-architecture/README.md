# How to Deploy this infrastracture 
## To initially create the stack run: 

```
aws cloudformation create-stack --stack-name platform-supporting-resources --template-url https://s3.us-west-2.amazonaws.com/terraform-backend.ajua.com/IaC/cf/vault-consul/main-vault-consul-template.yaml --capabilities CAPABILITY_IAM
```
wait for 3 mins for IAM resources to be created then create the QA (or production) environment with the following command

```
aws cloudformation create-stack --stack-name QA --template-url https://s3.us-west-2.amazonaws.com/terraform-backend.ajua.com/IaC/cf/main.yaml 

```

Create vpc peering connection between the newly created VPCs. Ensure you edit the route tables with the correct addresses so that the consul cluster can be created successfully. Config server is dependent on this connection.

Ssh into the vault server and unseal vault. Store the tokens safely for future use. Vault and consul are deployed in a public network to enable access via the UI. Thus, do not share the vault tokens publicly for this is a security risk.

## To update the stack run:
```
aws cloudformation update-stack --stack-name QA --template-url https://s3.us-west-2.amazonaws.com/terraform-backend.ajua.com/IaC/cf/main.yaml
```

## To delete stack, run:

```
aws cloudformation delete-stack --stack-name QA
aws cloudformation delete-stack --stack-name platform-supporting-resources
```

# How to deploy IAM stacks from the templates
```
aws cloudformation update-stack --stack-name QA --template-url https://s3.us-west-2.amazonaws.com/terraform-backend.ajua.com/IaC/cf/main.yaml 
```

# Deploy CICD Pipelines
```
aws cloudformation create-stack --stack-name api-service-pipeline --template-url https://s3.us-west-2.amazonaws.com/terraform-backend.ajua.com/IaC/cf/cicd/Api-Pipeline.yaml --capabilities CAPABILITY_IAM
```
```
aws cloudformation create-stack --stack-name engine-pipeline --template-url https://s3.us-west-2.amazonaws.com/terraform-backend.ajua.com/IaC/cf/cicd/engine-pipeline.yaml --capabilities CAPABILITY_IAM
```

```
aws cloudformation create-stack --stack-name scheduler-pipeline --template-url https://s3.us-west-2.amazonaws.com/terraform-backend.ajua.com/IaC/cf/cicd/scheduler-pipeline.yaml --capabilities CAPABILITY_IAM
```

```
aws cloudformation create-stack --stack-name config-server-pipeline --template-url https://s3.us-west-2.amazonaws.com/terraform-backend.ajua.com/IaC/cf/cicd/config-server-pipeline.yaml --capabilities CAPABILITY_IAM
```