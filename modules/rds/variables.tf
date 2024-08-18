variable "name" {
  description = "The name of the RDS instance"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "username" {
  description = "The username for the database"
  type        = string
}

variable "password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}

variable "allocated_storage" {
  description = "The amount of allocated storage (in GB)"
  type        = number
  default     = 20
}

variable "engine_version" {
  description = "The version of the MySQL engine"
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "parameter_group_name" {
  description = "The name of the DB parameter group to associate"
  type        = string
  default     = "default.mysql8.0"
}

variable "subnet_ids" {
  description = "A list of subnet IDs for the DB subnet group"
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "A list of VPC security group IDs to associate with the RDS instance"
  type        = list(string)
}

variable "skip_final_snapshot" {
  description = "Whether to skip taking a final snapshot when deleting the DB instance"
  type        = bool
  default     = true
}

variable "publicly_accessible" {
  description = "Whether the RDS instance should be publicly accessible"
  type        = bool
  default     = false
}

variable "storage_type" {
  description = "The storage type for the RDS instance"
  type        = string
  default     = "gp2"
}

