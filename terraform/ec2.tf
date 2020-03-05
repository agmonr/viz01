data "aws_subnet_ids" "main" {
  vpc_id = var.vpc_id
}

data "aws_subnet" "main" {
  for_each = data.aws_subnet_ids.main.ids
  id       = each.value
}

output "subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.for_each : s.cidr_block]
}
