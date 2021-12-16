resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tmpl", {
    ip          = aws_instance.ec2_ubuntu.public_ip,
    ssh_keyfile = format("%s/%s", pathexpand("~/.ssh"), var.private_key_name)
  })
  filename = format("%s/%s", abspath(path.root), "../ansible/inventory.yml")
}
