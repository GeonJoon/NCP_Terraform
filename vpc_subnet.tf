resource "ncloud_vpc" "vpc" {
    ipv4_cidr_block = "10.200.0.0/16"
    name            = "vpc-ggd-${var.name}"
}

resource "ncloud_subnet" "subnet1" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = cidrsubnet(ncloud_vpc.vpc.ipv4_cidr_block, 8, 0)
  zone           = "KR-2"
  network_acl_no = ncloud_vpc.vpc.default_network_acl_no
  subnet_type    = "PUBLIC" // PUBLIC(Public) | PRIVATE(Private)
  // below fields is optional
  name           = "subnet-ggd-${var.name}-pub"
  usage_type     = "GEN"    // GEN(General) | LOADB(For load balancer)
}

resource "ncloud_subnet" "subnet2" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = cidrsubnet(ncloud_vpc.vpc.ipv4_cidr_block, 8, 1)
  zone           = "KR-2"
  network_acl_no = ncloud_vpc.vpc.default_network_acl_no
  subnet_type    = "PRIVATE" // PUBLIC(Public) | PRIVATE(Private)
  // below fields is optional
  name           = "subnet-ggd-${var.name}-pri"
  usage_type     = "GEN"    // GEN(General) | LOADB(For load balancer)
}

resource "ncloud_subnet" "subnet3" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = cidrsubnet(ncloud_vpc.vpc.ipv4_cidr_block, 10, 8)
  zone           = "KR-2"
  network_acl_no = ncloud_vpc.vpc.default_network_acl_no
  subnet_type    = "PRIVATE" 
  name           = "subnet-ggd-${var.name}-lb"
  usage_type     = "LOADB"
}