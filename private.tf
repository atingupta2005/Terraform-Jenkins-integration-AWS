/*
  Database Servers
*/
resource "aws_security_group" "db" {
  name        = "vpc_db"
  description = "Allow incoming database connections."

  ingress { # SQL Server Db
    from_port       = 1433
    to_port         = 1433
    protocol        = "tcp"
    security_groups = ["${aws_security_group.web.id}"]
  }
  ingress { # MySQL Db
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.web.id}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.this.id}"

  tags = {
    Name = "DBServerSG"
  }
}
