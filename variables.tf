variable "users" {
  type        = list(string)
  description = "Users to create in a simple list format `[\"user1\", \"user2\"]. Use either variable `users` or `users_groups`"
  default     = []
}

variable "users_groups" {
  type        = map(list(string))
  description = "Users to create in a map format to specify group memberships. The groups must exist already. Use either variable `users` or `users_groups`. See [_var_users_groups.example.tfvars.json](_var_users_groups.example.tfvars.json)"
  default     = {}
}

variable "force_destroy" {
  type        = bool
  description = "When destroying users, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy users with non-Terraform-managed access keys and login profile will fail to be destroyed."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags to add to all users"
  default     = {}
}

variable "create_access_keys" {
  type        = bool
  description = "Set to true to create programmatic access for all users"
  default     = false
}

variable "create_login_profiles" {
  type        = bool
  description = "Set to true to create console access for all users"
  default     = false
}

variable "pgp_key" {
  type        = string
  description = "PGP key in plain text or using the format `keybase:username` to encrypt user keys and passwords"
  default     = null
}

variable "module_depends_on" {
  description = "Use this if you want this module to run after other modules"
  default     = []
}
