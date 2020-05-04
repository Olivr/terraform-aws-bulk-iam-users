output "users" {
  value = {
    for user in aws_iam_user.users :
    user.name => {
      name                              = user.name
      arn                               = user.arn,
      access_key_id                     = var.create_access_keys == true ? aws_iam_access_key.programmatic_access[user.name].id : null,
      access_key_secret_unencrypted     = var.create_access_keys == true && var.pgp_key == null ? aws_iam_access_key.programmatic_access[user.name].secret : null,
      access_key_secret_encrypted       = var.create_access_keys == true && var.pgp_key != null ? aws_iam_access_key.programmatic_access[user.name].encrypted_secret : null,
      access_key_secret_decrypt_command = try(length(regexall("^keybase", var.pgp_key)), 0) > 0 && lookup(lookup(aws_iam_access_key.programmatic_access, user.name, {}), "encrypted_secret", null) != null ? "echo '${aws_iam_access_key.programmatic_access[user.name].encrypted_secret}' | base64 --decode | keybase pgp decrypt" : null
      password_encrypted                = var.create_login_profiles == true ? aws_iam_user_login_profile.console_access[user.name].encrypted_password : null
      password_decrypt_command          = try(length(regexall("^keybase", var.pgp_key)), 0) > 0 && lookup(lookup(aws_iam_user_login_profile.console_access, user.name, {}), "encrypted_password", null) != null ? "echo '${aws_iam_user_login_profile.console_access[user.name].encrypted_password}' | base64 --decode | keybase pgp decrypt" : null
    }
  }
  description = "Created users in the format { name = { name, arn, access_key_id, access_key_secret_unencrypted, access_key_secret_encrypted, access_key_secret_decrypt_command, password_encrypted, password_decrypt_command }}"
}
