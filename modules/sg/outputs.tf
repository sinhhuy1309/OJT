output "sg" {
  value = {
    bastian_sg = aws_security_group.bastian_sg.id
    ingress_efs = aws_security_group.ingress_efs.id
    albSG = aws_security_group.albSG.id
  }
}
