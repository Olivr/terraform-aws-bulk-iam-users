# terraform-aws-bulk-iam-users

Terraform module to create many AWS IAM users at once.

## Examples

### Simple example to create users with access_keys (unencrypted)

```hcl
module "iam_users" {
  source = "github.com/olivr-com/terraform-aws-bulk-iam-users"

  users              = ["user-1", "user-2"]
  create_access_keys = true
}
```

### Complete example to create users with console access, programmatic access and group memberships

> You need to [create the groups](https://github.com/olivr-com/terraform-aws-bulk-iam-groups) first

```hcl
module "iam_users" {
  source = "github.com/olivr-com/terraform-aws-bulk-iam-users"

  force_destroy         = true
  create_access_keys    = true
  create_login_profiles = true
  pgp_key               = "keybase:romainbarissat"

  users_groups       = {
    user1 = ["group1", "group2"]
    user2 = ["group2", "group3"]
  }

  tags               = {
    Org         = "My Org"
    Environment = "Prod"
  }

  module_depends_on = [module.iam_groups.groups]
}

output "iam_users" {
  value = module.iam_users.users
}
```

<!-- auto-terraform-docs -->

<!-- auto-terraform-docs -->

## Similar modules

- [terraform-aws-bulk-iam-groups](https://github.com/olivr-com/terraform-aws-bulk-iam-groups)
- [terraform-aws-bulk-iam-roles](https://github.com/olivr-com/terraform-aws-bulk-iam-roles)
