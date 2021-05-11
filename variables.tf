variable "ses_smtp_user_list" {
  type = list(object({
    username = string
    email    = string
  }))
  default = []
}

variable "use_name_prefix" {
  description = "Whether to use name_prefix or fixed name."
  type        = bool
  default     = true
}

variable "ses_email_address_create" {
  description = "Whether to create the ses email addresses."
  type        = bool
  default     = true
}

variable "decrypt_ses_smtp_password" {
  description = "Whether to decrypt the ses smtp password. WARNING: The output will be shown in terraform logs."
  type        = bool
  default     = false
}