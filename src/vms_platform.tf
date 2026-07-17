###cloud vars

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vm_db_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_db_vpc_name" {
  type        = string
  default     = "db"
}

variable "vm_db_image" {
  type		= string
  default	= "ubuntu-2004-lts"
}

variable "vm_db_name" {
  type		= string
  default	= "netology-develop-platform-db"
}

variable "vm_db_platform_id" {
  type		= string
  default	= "standard-v3"
}
/*
variable "vm_db_resources" {
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
  })
  default = {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
}
*/