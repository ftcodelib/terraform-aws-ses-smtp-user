# Terraform module to create AWS SES STMP user and SMTP IAM key

This Terraform module is to create AWS AWS SES STMP user and SMTP IAM key from a list.

## Requirement

python3 must be installed in the machine that runs this terraform code if want to decrypt ses smtp password.

## Usage example

An example of Terraform file is contained in the [examples directory](./examples).

```hcl
module "ses_smtp_user" {
  source = "git::https://github.com/ftcodelib/terraform-aws-ses-smtp-user.git?ref=v0.1.0"

  use_name_prefix = true
  ses_email_address_create  = true
  decrypt_ses_smtp_password = false

  ses_smtp_user_list = [
    { "username" = "user1", "email" = "user1@example.com" },
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
|use\_name\_prefix|Whether to use name_prefix or fixed name|`bool`|`true`|no|
|ses\_email\_address\_create|Whether to create the ses email addresses|`bool`|`true`|no|
|decrypt\_ses_smtp\_password|Whether to decrypt the ses smtp password. WARNING: The output will be shown in terraform logs.|`bool`|`false`|no|

## Outputs

| Name | Description |
|---|---|
|ses\_smtp\_user\_created\_list|Output of created user in list object format|

## Authors

Created by [M.Farhan Taib](https://github.com/ftcodelib) - https://my.linkedin.com/in/mohdfarhantaib.

## License

Apache License 2.0 Licensed. See [LICENSE](https://github.com/ftcodelib/aws_cognito_users/LICENSE) for full details.
