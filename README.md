# aws-ec2-k8

## Step to setup Kubernetes Cluster on EC2 machines


### Install and configure the prerequisites tools 
- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)



### Create and upload aws keypair
```bash
ssh-keygen -t rsa -f ~/.ssh/<Your_name>
aws ec2 describe-key-pairs
aws ec2 import-key-pair --region ap-south-1 --key-name "<Your_name>" --public-key-material file://~/.ssh/<Your_name>.pub
aws ec2 describe-key-pairs
```

### Clone the code 

```bash
git clone https://github.com/manukoli1986/aws-ec2-k8.git
```

### Go to directory "aws-ec2-k8"

```bash
cd aws-ec2-k8
```

### Check main.tf file 

### Init and apply terraform

```bash
terraform init
terraform approve ## Type Yes 
```

### Connect to EC2
```bash 
ssh ec2-user@ec2-ip-address-dns-name-here
```

