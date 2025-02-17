variable "image_tag_mutability" {
  description = "Specifies whether to allow image tags to be mutable. If set to 'MUTABLE', tags can be overwritten."
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Specifies whether to scan images on push."
  type        = bool
  default     = false
}