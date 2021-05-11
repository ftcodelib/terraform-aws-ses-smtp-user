resource "aws_iam_user" "ses_smtp_user" {
  for_each = {
    for k, v in var.ses_smtp_user_list :
    v.username => v
  }
  name = (var.use_name_prefix ? format("ses-smtp-user.%s", each.key) : each.key)
  path = "/"
}

data "aws_iam_policy_document" "ses_smtp_policy" {
  statement {
    effect    = "Allow"
    actions   = ["ses:SendRawEmail"]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy" "ses_smtp_user_assign_policy" {
  for_each = {
    for k, v in var.ses_smtp_user_list :
    v.username => v
  }
  name   = "AmazonSesSendingAccess"
  user   = aws_iam_user.ses_smtp_user[each.key].name
  policy = data.aws_iam_policy_document.ses_smtp_policy.json
}

resource "aws_iam_access_key" "ses_smtp_user_access_key" {
  for_each = {
    for k, v in var.ses_smtp_user_list :
    v.username => v
  }
  user = aws_iam_user.ses_smtp_user[each.key].name
}

resource "aws_ses_email_identity" "ses_smtp_user" {
  for_each = var.ses_email_address_create ? {
    for k, v in var.ses_smtp_user_list :
    v.username => v
  } : {}
  email = each.value.email
}

data "aws_region" "current" {}

resource "null_resource" "ses_smtp_password_v4_decrypt" {

  for_each = var.decrypt_ses_smtp_password ? {
    for k, v in var.ses_smtp_user_list :
    v.username => v
  } : {}

  triggers = {
    aws_region           = data.aws_region.current.name
    ses_smtp_password_v4 = aws_iam_access_key.ses_smtp_user_access_key[each.value.username].ses_smtp_password_v4
  }

  provisioner "local-exec" {
    command = <<-EOT
    python3 ${path.module}/scripts/smtp_credentials_generate.py ${self.triggers.ses_smtp_password_v4} ${self.triggers.aws_region}
    EOT
  }
}