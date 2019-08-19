/*
  update cidr_block
*/

# vpc
resource "aws_vpc" "this" {
  cidr_block = "10.253.0.0/16"
  enable_dns_hostnames = true
  tags = merge(
    {
      "Name" = local.upper_name
    },
    local.tags
  )
}
