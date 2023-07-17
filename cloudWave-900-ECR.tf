resource "aws_ecr_repository" "cwave_image_repo" {
  name                 = "cwave_image_repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}