variable "accounts" {
  type = map(string)

  default = {
    project  = "grasys-study"
    region   = "asia-northeast1"
    zone     = "asia-northeast1-a",
    location = "ASIA"
  }
}

/*
variable "project_name" {
  default = "grasys-study"
  type = string
}

variable "project_region" {
  default = "asia-northeast1"
  type = string
}

variable "project_zone" {
  type = list(string)
  default = [ "asia-northeast1-a", "asia-northeast1-b", "asia-northeast1-c" ]
  
}

variable "location" {
  type = string
  default = "ASIA"
}
*/