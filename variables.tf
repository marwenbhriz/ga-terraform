variable "accounts" {
  type = map(string)

  default = {
    project  = "grasys-study"
    region   = "asia-northeast1"
    zone     = "asia-northeast1-a",
    location = "ASIA"
  }
}
