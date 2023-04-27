# Keypair
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.private_key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.private_key.private_key_pem}' > ./${var.key_pair_name}.pem"
    when = create
  }

  provisioner "local-exec" {
    command = "rm -f *.pem"
    when = destroy
  }
}

## Generate private key
resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}
