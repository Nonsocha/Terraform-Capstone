resource "aws_key_pair" "wordpress" {
  key_name   = "wordpress-key"
  public_key = file("C:/Users/WILLIAMS/Downloads/wordpress-key.pub")
}