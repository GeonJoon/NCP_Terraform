resource "ncloud_nas_volume" "web_server" {
    zone                           = "KR-2"
    volume_name_postfix            = "web"
    volume_size                    = "500"
    volume_allotment_protocol_type = "NFS"
    server_instance_no_list        = [ncloud_server.web_server[0].id, ncloud_server.web_server[1].id]
}
