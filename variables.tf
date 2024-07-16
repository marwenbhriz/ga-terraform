variable "accounts" {
  type = map(string)

  default = {
    project  = ""
    region   = "asia-northeast1"
    zone     = "asia-northeast1-a",
    location = "ASIA"
  }
}
