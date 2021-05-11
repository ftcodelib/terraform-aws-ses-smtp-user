module "ses_smtp_user" {
  source = "../"

  use_name_prefix = true
  ses_email_address_create  = true
  decrypt_ses_smtp_password = false

  ses_smtp_user_list = yamldecode(file("${path.cwd}/list.yaml"))
}