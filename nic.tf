resource "ncloud_network_interface" "nic_bastion" {
    description           = "bastion server private"
    subnet_no             = ncloud_subnet.subnet1.id
    private_ip            = "10.200.0.9"
    access_control_groups = [ncloud_access_control_group_rule.acg_common.id, ncloud_access_control_group_rule.acg-bastion.id]
}

resource "ncloud_network_interface" "web_dev_server" {
    count                 = length(var.server_name)-1
    description           = "web_dev server private"
    subnet_no             = ncloud_subnet.subnet2.id
    private_ip            = var.nic[count.index]
    access_control_groups = [ncloud_access_control_group_rule.acg_common.id]
}