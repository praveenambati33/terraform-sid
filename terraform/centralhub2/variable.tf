#TEST

#Common Variables
variable "location" {
  type        = string
  description = "Resource loaction"
  default     = "eastus"
}

variable "tags" {
  description = "Additional resource tags"
  type        = map(string)
}

#RG Variables
variable "resourcegroupname" {
  type        = string
  description = "Resource group name"
}
