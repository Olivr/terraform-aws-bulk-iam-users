# terraform-aws-bulk-iam-users

Create many AWS IAM users at once.

## Examples

### Simple example to create users with access_keys

```hcl
module "iam_users" {
  source = "github.com/OlivrDotCom/terraform-aws-bulk-iam-users"

  users              = ["user-1", "user-2"]
  create_access_keys = true
}

output "iam_users" {
  value = module.iam_users.users
}
```

### Create users with console access, programmatic access and group memberships

> You need to [create the groups](https://github.com/OlivrDotCom/terraform-aws-bulk-iam-groups) first

```hcl
module "iam_users" {
  source = "github.com/OlivrDotCom/terraform-aws-bulk-iam-users"

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

## Requirements

| Name      | Version    |
| --------- | ---------- |
| terraform | ~> 0.12.24 |
| aws       | ~> 2.58    |

## Providers

| Name | Version |
| ---- | ------- |
| aws  | ~> 2.58 |

## Inputs

Either `users` or `users_groups` is **required**

| Name                  | Description                                                                                                                                                                             | Type                | Default | Required |
| --------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------- | ------- | :------: |
| create_access_keys    | Set to true to create programmatic access for all users                                                                                                                                 | `bool`              | `false` |    no    |
| create_login_profiles | Set to true to create console access for all users                                                                                                                                      | `bool`              | `false` |    no    |
| force_destroy         | When destroying users, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices                                                                       | `bool`              | `false` |    no    |
| module_depends_on     | Use this if you want this module to run after other modules                                                                                                                             | `list(string)`      | `[]`    |    no    |
| pgp_key               | PGP key in plain text or using the format `keybase:username` to encrypt user keys and passwords                                                                                         | `string`            | `null`  |    no    |
| tags                  | Tags to add to all users                                                                                                                                                                | `map(string)`       | `{}`    |    no    |
| users                 | Users to create in a simple list format [user1, user2]. Use either variable `users` or `users_groups`                                                                                   | `list(string)`      | `[]`    |    no    |
| users_groups          | Users to create in the format { user1 = [group1, group2], user2 = [group2, group3] }. The groups must exist already. `users_groups` takes precedence over `users` if both are specified | `map(list(string))` | `{}`    |    no    |

## Outputs

| Name  | Description                                                                                                                                                                                                       |
| ----- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| users | Created users in the format `{ name = { name, arn, access_key_id, access_key_secret_unencrypted, access_key_secret_encrypted, access_key_secret_decrypt_command, password_encrypted, password_decrypt_command }}` |
