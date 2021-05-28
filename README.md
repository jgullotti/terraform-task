# Terraform Task


## Requirements:

- [x] Create a VPC with at least 2 Subnets in separate availabilty zones
- [x] 2 EC2 Instances, each in its own subnet. Names: Server1, Server2
- [x] Terraform should print the IPs of the instances and _any info needed to log into them_
- [x] User should be able to ssh into Server1 and Server2
- [x] Server1 and Server2 should be able to communicate over tcp/22 (assumption: With each other and with the external user)
- [x] Server1 and Server2 should be cble to comunication with eachother on tcp/80 and tcp/443
- [x] `terraform destroy` should remove all the resources created

## Bonus:

- [ ] have terraform deploy something that listens on tcp/80 and tcp/443
- [x] utilize data source feature of terraform
- [x] utilize modules
- [ ] write a paragraph on what I like/dislike about terraform
- [ ] configure a service on one of the instances using chef


## Architecture:

![arch](./architecture.png)


## Terraform likes and dislikes

...
