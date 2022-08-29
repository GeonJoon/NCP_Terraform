# 서버 전체 공통 정책 생성 
resource "ncloud_access_control_group" "common" {
    vpc_no      = ncloud_vpc.vpc.id
    name        = "acg-common"
}

resource "ncloud_access_control_group" "acg" {
    count       = length(var.server_name)
    vpc_no      = ncloud_vpc.vpc.id
    name        = "acg-${element(var.server_name, count.index)}"
}

resource "ncloud_access_control_group_rule" "acg_common" {
    access_control_group_no = ncloud_access_control_group.common.id
    inbound {
        protocol    = "TCP"
        ip_block    = "10.200.0.0/16"
        port_range  = "1-65535"
        description = "local"
    }

    inbound {
        protocol    = "ICMP"
        ip_block    = "0.0.0.0/0"
    }

    outbound {
        protocol    = "TCP"
        ip_block    = "0.0.0.0/0" 
        port_range  = "1-65535"
        description = "accept 1-65535 port"
    }
}

resource "ncloud_access_control_group_rule" "acg-bastion" {
    access_control_group_no = ncloud_access_control_group.acg[4].id

    inbound {
        protocol    = "TCP"
        ip_block    = "123.142.255.5/32"
        port_range  = "1-65535"
        description = "uwsmsp"
    }
}

resource "ncloud_access_control_group_rule" "acg-uws-dev1" {
    access_control_group_no = ncloud_access_control_group.acg[0].id

}

resource "ncloud_access_control_group_rule" "acg-uws-dev2" {
    access_control_group_no = ncloud_access_control_group.acg[1].id

}

resource "ncloud_access_control_group_rule" "acg-uws-web1" {
    access_control_group_no = ncloud_access_control_group.acg[2].id

}

resource "ncloud_access_control_group_rule" "acg-uws-web2" {
    access_control_group_no = ncloud_access_control_group.acg[3].id

}
