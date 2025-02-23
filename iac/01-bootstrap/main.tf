# # Generates an 8-character hex string (4 bytes * 2 hex characters per byte)
resource "random_id" "random_suffix" {
  byte_length = 4
}
