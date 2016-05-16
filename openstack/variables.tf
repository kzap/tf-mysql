variable "username" {}
variable "password" {}
variable "tenant_name" {}
variable "auth_url" {}
variable "public_key" {}
variable "user_login" {
    default = "stack"
}
variable "key_file_path" {}

variable "prefix" {
    default = "mysql"
}

variable "nb_of_nodes" {
    default = "4"
}

variable "pub_net_id" {
    default = {
         tr2="PublicNetwork-01"
         tr2-1 = ""
    }
}

variable "region" {
    default = "tr2"
    description = "The region of openstack, for image/flavor/network lookups."
}

variable "image_id" {
    default = "eee08821-c95a-448f-9292-73908c794661"
}

variable "image_name" {
    default = ""
}

variable "flavor_id" {
    default = "200"
}

variable "flavor_name" {
    default = ""
}

variable "servers" {
    default = "1"
    description = "The number of DB servers to launch."
}
