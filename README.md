The main.tf file contains Terraform code that deploys an EKS cluster into an existing VPC. This code will create a new VPC with public and private subnets, and deploy an EKS cluster into the private subnets.

The Terraform code also prepares anything required for a pod to be able to assume an IAM role (see resources part of code). The aws_iam_role and aws_iam_role_policy_attachment resources in Terraform to create an IAM role and attach a policy to it. This code will create an IAM role named "Role_For_Deployers" that can be assumed by EC2 instances and EKS pods, and attach the "AmazonS3FullAccess" policy to it.

This README file explains how to use the Terraform repo and demonstrates how an end-user (a developer from the company) can run a pod on deployed new EKS cluster and also have an IAM role assigned that allows that pod to access an S3 bucket.

MANUAL
-----------------------------------------------------------------------------------------------------
How an end-user (a developer from the company) can run a pod on this new EKS cluster and also have an IAM role assigned that allows that pod to access an S3 bucket?

Prerequisites:

AWS account credentials with enough permissions to create resources mentioned in the Terraform code.
Terraform 1.0 or higher installed on your local machine.

Steps:
1. Clone the repository to your local machine.
2. Navigate to the cloned repository using the terminal/command prompt.
3. Run the following command to initialize the Terraform: terraform init
4. Next, run the following command to create a plan for the resources that will be created: terraform plan
5. Review the plan output and if everything looks good, apply the Terraform code using the following command: terraform apply
6. Once the EKS cluster is up and running, you can deploy your pods to it with an IAM role assigned that allows them to access the S3 bucket by following the below steps:
- Create a Kubernetes deployment and service manifest file for your pod.
- In the manifest file, add the following annotations under the pod spec:

metadata:
  annotations:
    eks.amazonaws.com/role-arn: <arn_of_the_iam_role>

- Replace <arn_of_the_iam_role> with the ARN of the IAM role that you want to assign to the pod.
- Save the changes and apply the manifest file using the following command:

kubectl apply -f <path_to_manifest_file>

7. Verify that your pod is up and running by using the following command: Verify that your pod is up and running by using the following command:kubectl get pods

8. Now, you can test if your pod is able to access the S3 bucket by running the following command: kubectl exec <pod_name> -- aws s3 ls s3://<bucket_name>

- Replace <pod_name> with the name of your pod.
- Replace <bucket_name> with the name of the S3 bucket that you want to access.

As a result you have successfully deployed an EKS cluster using Terraform and assigned an IAM role to your pod that allows it to access an S3 bucket!