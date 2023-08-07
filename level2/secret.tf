data "aws_secretsmanager_secret" "rds_password20" {
  name = "main/rds/password20"
}

data "aws_secretsmanager_secret_version" "rds_password20" {
  secret_id = data.aws_secretsmanager_secret.rds_password20.id
}

locals {
  rds_password = jsondecode(data.aws_secretsmanager_secret_version.rds_password20.secret_string)["password"]
  db_name      = "mydb"
  db_username  = "hungpham"
}
