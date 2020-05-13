locals {
  users = toset(var.users_groups != {} ? keys(var.users_groups) : var.users)
}


/*
 * Create IAM users
 */

resource "aws_iam_user" "users" {
  for_each = local.users

  name          = each.value
  force_destroy = var.force_destroy
  tags          = var.tags
}


/*
 * Create programmatic access
 */

resource "aws_iam_access_key" "programmatic_access" {
  for_each = var.create_access_keys == true ? local.users : []

  user    = aws_iam_user.users[each.value].name
  pgp_key = var.pgp_key
}


/*
 * Create AWS console access
 */

resource "aws_iam_user_login_profile" "console_access" {
  for_each = var.create_login_profiles == true ? local.users : []

  user    = aws_iam_user.users[each.value].name
  pgp_key = var.pgp_key
}


/*
 * Attach IAM users to groups
 */

resource "aws_iam_group_membership" "programmatic_users" {
  depends_on = [aws_iam_user.users]
  for_each   = transpose(var.users_groups)

  name  = "usergroups"
  group = each.key
  users = each.value
}
