# terraform-aws-bulk-iam-users

Terraform module to create many AWS IAM users at once.

## Examples

### Simple example

Create users with access_keys (unencrypted)

```hcl
module "iam_users" {
  source = "github.com/olivr-com/terraform-aws-bulk-iam-users"

  users              = ["user-1", "user-2"]
  create_access_keys = true
}
```

### Complete example

Create users with console access, programmatic access and group memberships

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

| Name                  | Description                                                                                                                                                                                                                        | Type                | Default | Required |
| --------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------- | ------- | :------: |
| create_access_keys    | Set to true to create programmatic access for all users                                                                                                                                                                            | `bool`              | `false` |    no    |
| create_login_profiles | Set to true to create console access for all users                                                                                                                                                                                 | `bool`              | `false` |    no    |
| force_destroy         | When destroying users, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy users with non-Terraform-managed access keys and login profile will fail to be destroyed. | `bool`              | `false` |    no    |
| module_depends_on     | Use this if you want this module to run after other modules                                                                                                                                                                        | `list`              | `[]`    |    no    |
| pgp_key               | PGP key in plain text or using the format `keybase:username` to encrypt user keys and passwords                                                                                                                                    | `string`            | `null`  |    no    |
| tags                  | Tags to add to all users                                                                                                                                                                                                           | `map(string)`       | `{}`    |    no    |
| users                 | Users to create in a simple list format `["user1", "user2"]. Use either variable`users`or`users_groups                                                                                                                             | `list(string)`      | `[]`    |    no    |
| users_groups          | Users to create in a map format to specify group memberships. The groups must exist already. Use either variable `users` or `users_groups`. See [\_var_aws_iam_users.example.json](_var_aws_iam_users.example.json)                | `map(list(string))` | `{}`    |    no    |

## Outputs

| Name  | Description           |
| ----- | --------------------- |
| users | Map of created users. |

<!-- auto-terraform-docs -->

## Similar modules

- [terraform-aws-bulk-iam-groups](https://github.com/olivr-com/terraform-aws-bulk-iam-groups)
- [terraform-aws-bulk-iam-roles](https://github.com/olivr-com/terraform-aws-bulk-iam-roles)

<!-- auto-support -->

## Support

Create a new issue on this GitHub repository.

<!-- auto-support -->
<!-- auto-contribute -->

## Contributing

All contributions are welcome! Please see the [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md)

<!-- auto-contribute -->
<!-- auto-license -->

## License

This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details

<!-- auto-license -->
<!-- auto-about-org -->

## About olivr

[Olivr](https://olivr.com) is an AI co-founder for your startup.

<!-- auto-about-org -->
