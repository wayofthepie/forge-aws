# Infrastructure Forge
Automation of initial creation and state change of infrastructure for the
following tools on AWS:

* Jenkins
    * ECS Docker cluster and related nodes for use with Jenkins
    * Artifactory
        * Amazon RDS DB (todo)
            * ECS Docker cluster and related nodes for use with Artifactory

# Terraform Setup
First, install 
[terraform](https://www.terraform.io/intro/getting-started/install.html). 
To allow terraform access to AWS you will need to
setup a user with specific permissions (todo: add perms to readme) and add the
users *Access Key Id* and *Secret Acces Key* to `~/.aws/credentials`:

```bash
$ cat ~/.aws/credentials 
[default]
aws_access_key_id=****
aws_secret_access_key=****
```

# Building
## Planning
`terraform plan` generates an execution plan taking into account the current
configuration and state.
```bash
$ terraform plan
Refreshing Terraform state prior to plan...

The Terraform execution plan has been generated and is shown below.
Resources are shown in alphabetical order for quick scanning. Green resources
will be created (or destroyed and then created if an existing resource
exists), yellow resources are being changed in-place, and red resources
will be destroyed.

Note: You didn't specify an "-out" parameter to save this plan, so when
"apply" is called, Terraform can't guarantee this is what will execute.

+ aws_ecs_cluster.slave-cluster
    name: "" => "slave-cluster"

    + aws_ecs_cluster.tools-cluster
        name: "" => "tools-cluster"

        ...
        ```
## Applying Changes
        `terraform apply` builds out or changes infrastructure according to
        Terraform configuration files in the given directory, defaults to the
        directory it is run.

## Destroy
`terraform destroy` destroys managed infrastructure.


