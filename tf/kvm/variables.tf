variable "suffix" {
  description = "Suffix to differentiate resources"
  type        = string
  nullable    = false
}

variable "key" {
  description = "Name of the SSH key pair registered in Chameleon"
  type        = string
  default     = "group19-shared-key"
}
