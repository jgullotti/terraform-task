# Terraform Task


## Requirements:

- [x] Create a VPC with at least 2 Subnets in separate availability zones
- [x] 2 EC2 Instances, each in its own subnet. Names: Server1, Server2
- [x] Terraform should print the IPs of the instances and _any info needed to log into them_
- [x] User should be able to ssh into Server1 and Server2
- [x] Server1 and Server2 should be able to communicate over tcp/22 (assumption: With each other and with the external user)
- [x] Server1 and Server2 should be able to communicate with each other on tcp/80 and tcp/443
- [x] `terraform destroy` should remove all the resources created

## Bonus:

- [ ] have terraform deploy something that listens on tcp/80 and tcp/443
- [x] utilize data source feature of terraform
- [x] utilize modules
- [x] write a paragraph on what I like/dislike about terraform
- [ ] configure a service on one of the instances using chef


## Architecture:

![arch](./architecture.png)


## Terraform likes and dislikes

With the qualification that my experience with Terraform isn't very extensive, I actually find it great to work with and really like what it is capable of with such little code. I love the design behind modules and the reusability that it enables. I also think the HCL language was thoughtfully designed, striking a nice balance between familiar and accessible formats such as json and the expressiveness and capabilities of some functional languages. The documentation is well organized and complete. I also appreciate the tooling ecosystem around Terraform. For small projects like this it's seamless to get up and running with the Terraform cloud. Also in regard to the tooling I appreciate the golang-like autoformatting of `terraform fmt`. I am also really enjoying the [terraform-lsp](https://github.com/juliosueiras/terraform-lsp) which integrates no-problem with vim.  I am hard pressed to think of something I _don't_ like about it. That said, I can imagine challenges when developing larger-scale terraform projects where one might be dealing with complex environments. This is by no means unique to terraform however and I suspect my lack of deep experience with it contributes to this suspicion of mine.


## Getting started

Here is how to get up and running with the code in this repo. It is assumed that you have the [terraform cli installed](https://learn.hashicorp.com/tutorials/terraform/install-cli#install-terraform) and an [AWS account configured](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication)

For simplicity, the code uses a local backend but this could be enhanced by configuring a remote backend, for example, on [Terraform Cloud](https://learn.hashicorp.com/collections/terraform/cloud-get-started?utm_source=WEBSITE&utm_medium=WEB_IO&utm_offer=ARTICLE_PAGE&utm_content=DOCS)

```bash
# clone this repository
git clone git@github.com:jgullotti/terraform-task.git
cd terraform-task/terraform

# add access_ip and pubkey_path to terraform.tfvars. Replace these values with ones appropriate to you.
# access_ip will be your public ip address from where connections to your VPC will be allowed.
# pubkey_path is the public key which will added to your provisioned instances allowing your user to ssh
echo "access_ip = 12.34.56.78/32" > terraform.tfvars
echo "pubkey_path = /home/username/.ssh/id_rsa.pub" >> terraform.tfvars

# run `terraform plan` to review the proposed changes
terraform plan

# apply your configuration to create your infrastructure, you will be presented with the proposed
# configuration again and prompted yes/no to proceed.
terraform apply
```

After applying, you'll be presented with an output like:

```bash
Apply complete! Resources: 13 added, 0 changed, 0 destroyed.

Outputs:

instance_public_ips = {
  "Server1" = "54.162.45.118"
  "Server2" = "204.226.212.158"
}
instance_username = "centos"
ssh_identity = "/home/user/.ssh/id_rsa.pub"
```

You can use this information to connect to your instances i.e.:

```bash
ssh centos@54.162.45.118 -i /home/user/.ssh/id_rsa
```
