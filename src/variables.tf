###cloud vars

variable "cloud_id" {
  type        = string
  default	  = "b1grdv4ugue7f7kuoekd"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default	  = "b1g9p822q7vrvfh73q3e"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "vm_web_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "web"
  description = "VPC network & subnet name"
}

variable "vm_web_image" {
  type		= string
  default	= "ubuntu-2004-lts"
}

variable "vm_web_name" {
  type		= string
  default	= "netology-develop-platform-web"
}  

variable "vm_web_platform_id" {
  type		= string
  default	= "standard-v3"
}

/* 
  variable "vm_web_resources" {
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
  })
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }
}
*/
variable "vms_resources" {
	type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))

  default = {
	web={
		cores			=2
		memory			=1
		core_fraction	=20
		},
	db={
		cores			=2
		memory			=2
		core_fraction	=20
		}
  }
}
###ssh vars

variable "vms_ssh_public_key" {
  type        = string
}

variable "vms_metadata_serial_port_enable" {
  type        = number
  default     = 1
}