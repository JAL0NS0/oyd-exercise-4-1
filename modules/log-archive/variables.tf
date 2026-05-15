variable "bucket_name" {
  type        = string
  description = "Nombre base para el bucket"
}

variable "environment" {
  type        = string
  description = "Entorno de despliegue"
}

variable "log_prefix" {
  type        = string
  default     = "logs/"
  description = "Prefijo para la regla de ciclo de vida"
}