output "ses_smtp_user_created_list" {
  value = [
    for k, v in var.ses_smtp_user_list : {
      username               = v.username
      email                  = v.email
      ses_smtp_username      = aws_iam_user.ses_smtp_user[v.username].name
      ses_smtp_password_v4   = aws_iam_access_key.ses_smtp_user_access_key[v.username].ses_smtp_password_v4
      ses_smtp_access_key_id = aws_iam_access_key.ses_smtp_user_access_key[v.username].id
      ses_email_arn          = var.ses_email_address_create ? aws_ses_email_identity.ses_smtp_user[v.username].arn : null
    }
  ]
}