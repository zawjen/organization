# Terraform Code Conventions

## 1. Project Structure

```
📦 infrastructure
 ┣ 📂 modules
 ┃ ┣ 📂 network
 ┃ ┃ ┣ 📜 main.tf
 ┃ ┃ ┣ 📜 variables.tf
 ┃ ┃ ┣ 📜 outputs.tf
 ┣ 📂 environments
 ┃ ┣ 📂 dev
 ┃ ┃ ┣ 📜 main.tf
 ┃ ┃ ┣ 📜 terraform.tfvars
 ┃ ┣ 📂 prod
 ┃ ┃ ┣ 📜 main.tf
 ┃ ┃ ┣ 📜 terraform.tfvars
 ┣ 📜 provider.tf
 ┣ 📜 backend.tf
 ┣ 📜 variables.tf
 ┣ 📜 outputs.tf
 ┣ 📜 README.md
```

## 2. Naming Conventions

- **Files:** Use `snake_case`, e.g., `network_config.tf`
- **Resources:** Use descriptive names, e.g., `aws_instance.web_server`
- **Variables:** Use `snake_case`, e.g., `instance_type`
- **Outputs:** Prefix with `output_`, e.g., `output_instance_id`

## 3. Module Usage

- Define reusable modules inside `modules/`
- Use `source` to reference modules

```hcl
module "network" {
  source = "./modules/network"
  vpc_id = var.vpc_id
}
```

## 4. Variables & Outputs

- Define all variables in `variables.tf`

```hcl
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
```

- Define outputs in `outputs.tf`

```hcl
output "instance_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}
```

## 5. State Management

- Use remote backend for state management

```hcl
terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
  }
}
```

## 6. Formatting & Linting

- Format code using Terraform formatter

```bash
terraform fmt
```

- Validate syntax

```bash
terraform validate
```

## 7. Best Practices

- Use **terraform.tfvars** for environment-specific values
- Enable **versioning** for the Terraform state bucket
- Follow the **principle of least privilege** for IAM roles
- Use **Terraform Cloud** or **S3 with DynamoDB** for locking

## 8. Running Terraform Commands

- Initialize Terraform

```bash
terraform init
```

- Plan changes

```bash
terraform plan
```

- Apply changes

```bash
terraform apply
```

- Destroy infrastructure

```bash
terraform destroy
```

## 9. Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat(vpc): add new VPC module
fix(s3): resolve bucket policy issue
chore(terraform): format and lint code
```

---

By following these conventions, Terraform projects remain structured, maintainable, and scalable.

