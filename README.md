# Terraform Recipes

Hello!

To run and apply the terraform configuration, we need to run the following commands:

    terraform plan --var-file=../secrets.tfvars
    terraform apply --var-file=../secrets.tfvars

Once that we have created the resources and want to delete it, we can run:

    terraform destroy --var-file=../secrets.tfvars

Please, note that `--var-file` is the file containing all the secrets.

In general, we have two ways to handle secrets, depending on the environment:

### CI/CD

### Local Environment