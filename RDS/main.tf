resource "aws_db_instance" "my_rds" {
  allocated_storage    = 20
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  max_allocated_storage = 100
  username             = var.username_db
  password             = var.password_db
  skip_final_snapshot  = true
  identifier           = "db-${var.stage_name}-test"
}
